import Base: +, -, *, \
import Base: size

import Base: print

abstract type AbstractFOTransferFunction end

mutable struct FOTF <: AbstractFOTransferFunction
    num
    nn
    den
    nd
    ioDelay
end

"""
    fotf(numerator, order_of_numerator, denumerator, order_of_denumerator, delay)

Construct the transfer function in fractional order systems.

### Example

```julia-repl
julia> G = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
--------------
s^{0.5} + 2s^{0.6}
```
"""
function fotf(a, na, b, nb, T)
    return FOTF(a, na, b, nb, T)
end

function fotf(a, na, b, nb)
    return FOTF(a, na, b, nb, 0)
end

#FIXME: size()
function size(tf::FOTF)
    return size(tf.num)
end

"""
Test two FOTF are  equal or not.
"""
#=function ==(G1::FOTF, G2::FOTF)

end
=#
"""
Add two fractional order model.

!!! warning
    You can't add two systems with different I/O delay.

"""
#=function +(G1::FOTF, G2::FOTF)

end
=#
#=
function sisoplus(G1, G2)
    if iszero(G2)
        return G1
    elseif G1.ioDelay == G2.ioDelay
        key=0
        G1=simplify(G1)
        G2=simplify(G2)
        (a1, na1, b1, nb1)=fotfdata(G1)
        (a2, na2, b2, nb2)=fotfdata(G2)
        if length(a1) == length(a2)
            if all()
    end
end
=#

function simplify(G::FOTF, tol=0.000001)
    (b, nb) = polyuniq(G.num, G.nn, tol)
    (a, na) = polyuniq(G.den, G.nd, tol)

    if length(a) == length(b)
        da=a[1]
        db=b[1]
        if abs(a/da - b/db) < tol && abs(na - nb) < tol
            a=1
            b=db/da
            na=0
            nb=0
        end
    end

    if length(nb)==0
        nb=0
        b=0
        na=0
        a=0
    end

    nn = min(na[end], nb[end])
    nb = nb-nn
    na = na-nn
    return fotf(a, na, b, nb, G.ioDelay)
end

function polyuniq(a, an, tol)
    an = sort(an, rev=true)
    ii = sortperm(an, rev=true)
    a = a[ii]
    ax = diff(an)
    key=1
    for i = 1:length(ax)
        if abs(ax[i]) <= tol
            a[key] = a[key]+a[key+1]
            deleteat!(a, key+1)
            deleteat!(an, key+1)
        else
            key = key+1
        end
    end
    ii = findall(x -> abs(x) > tol, a)
    a = a[ii]
    an = an[ii]
    # Here  a and an become one-element vector
    return a[1], an[1]
end

"""
    kronsum(A, B)

Return the Kronecker sum of two matrices
"""
function kronsum(A, B)
    (ma, na) = size(A)
    (mb, nb) = size(B)
    A = reshape(A, 1, ma, 1, na)
    B= reshape(B, mb, 1, nb, 1)
    C = reshape(broadcast(+, A, B), (mb*mb, na*nb))
    return C
end


"""
    fotf2cotf(tf)

Convert an FOTF object to a commensurate order object.

### Example

```julia-repl
julia> fotf2cotf(G)
TransferFunction{Discrete{Int64}, ControlSystems.SisoRational{Float64}}   
2.0z^4 + 1.0z^3
---------------
2.0z^6 + 1.0z^5

Sample Time: 2 (seconds)
Discrete-time transfer function model
```
"""
function fotf2cotf(G::FOTF)
    α = base_order(G)

    if α == 0
        a = G.den
        b = G.num
        d = b[1]/a[1]
        return tf(d), α
    else
        n0 = Int64.(round.(G.nd/α))
        a = zeros(maximum(n0)+1)
        a[n0.+1] = G.den
        a = a[end:-1:1]

        m0 = Int64.(round.(G.nn/α))
        b = zeros(maximum(m0)+1)
        b[m0.+1] = G.num
        b = b[end:-1:1]
        return G.ioDelay == 0 ? tf(b, a) : tf(b, a, G.ioDelay)
    end
end

"""
    base_order(G)

Find the base order of an FOTF.

### Example

```julia-repl
julia> G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78]);
julia> base_order(G)
0.01
```
"""
function base_order(G::FOTF)
    a=[]
    a=[a; G.nn; G.nd]

    # Julia doesn't has broadcasting `rationalize` method😟
    nume = Int64[]
    denume = Int64[]
    for (_, i) in enumerate(a)
        if isa(i, Int64)
            continue
        else
            i = rationalize(i)
        end
        push!(nume, numerator(i))
        push!(denume, denominator(i))
    end
    return gcd(nume)/lcm(denume)
end



Base.print(io::IO, G::FOTF) = show(io, G)

function Base.show(io::IO, G::FOTF)
    println(typeof(G))
    print("\n")
    for (i, _) in enumerate(G.num)
        j=G.num[i]
        l=G.nn[i]
        if i == 1
            if j == 1
                print("s^{$l}")
            else
                print("$(showfirstsign(j))s^"*"{$l}")
            end
        else
            print("$(showsign(j))s^"*"{$l}")
        end
    end
    print("\n")

    G.ioDelay == 0 ? println("-------"^length(G.den)) : println("-------"^length(G.den)*"exp($(G.ioDelay)*s)")

    for (i, _) in enumerate(G.den)
        j=G.den[i]
        l=G.nd[i]
        if i == 1
            if j == 1
                print("s^{$l}")
            else
                print("$(showfirstsign(j))s^"*"{$l}")
            end
        else
            print("$(showsign(j))s^"*"{$l}")
        end
    end
end


# Handling the signs of the polynomials's coefficients
function showsign(a)
    if a > 0
        return " + "*"$a"
    elseif a < 0
        return " - "*"$(abs(a))"
    end
end
function showfirstsign(a)
    if a > 0
        return "$a"
    elseif a < 0
        return "-"*"$(abs(a))"
    end
end

function fotfdata(G::FOTF)
    b=G.num
    a=G.den
    nb=G.nn
    na=G.nd
    L=G.ioDelay

    return [a, na, b, nb, L]
end


function Base.iszero(G::FOTF)
    (a, na, b, nb) = fotfdata(G)

    if length(nb) == 1 & abs(b[1]) < eps
        return true
    else
        return false
    end
end