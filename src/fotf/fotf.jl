import Base: +, -, *, /, ==, inv
import Base: size
import Base: print, show


abstract type AbstractFOTransferFunction end

"""
FOTF object
"""
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
------------------
s^{0.5} + 2s^{0.6}
```
"""
function fotf(a, na, b, nb, T)
    a = a
    na = na
    b = b
    nb = nb
    return FOTF(a, na, b, nb, T)
end

fotf(a, na, b, nb) = FOTF(a, na, b, nb, 0)

fotf(s::String) = s == "s" ? (return fotf([1], [1], [1], [0], 0)) : (nothing)
fotf(c::Char) = c == 's' ? (return fotf([1], [1], [1], [0], 0)) : (nothing)
fotf(x::Number) = x

#FIXME: size()
function size(tf::FOTF)
    return size(tf.num)
end


function simplify(G::FOTF)
    (b, nb) = polyuniq(G.num, G.nn, eps())
    (a, na) = polyuniq(G.den, G.nd, eps())

    if length(a) == length(b)
        da = a[1]
        db = b[1]
        if a./da == b./db && na == nb
            a = 1
            b = db/da
            na = 0
            nb = 0
        end
    end

    if length(nb) == 0
        nb = 0
        b = 0
        na = 0
        a = 0
    end

    nn = min(na[end], nb[end])
    nb = nb.-nn
    na = na.-nn
    return fotf( b, nb, a, na, G.ioDelay)
end

function polyuniq(a, an, tol)
    ii = sortperm(an, rev=true)
    an = sort(an, rev=true)
    

    a = a[ii]
    ax = diff(an)
    key = 1
    for i = 1:length(ax)
        if abs(ax[i]) <= tol
            a[key] = a[key] + a[key+1]
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
    return a, an
end

"""
    kronsum(A, B)

Return the Kronecker sum of two matrices
"""
function kronsum(A::T, B::T) where {T <: AbstractArray}
    ma, na = size(A, 2), size(A, 1)
    mb, nb = size(B, 2), size(B, 1)
    A = reshape(A, 1, ma, 1, na)
    B= reshape(B, mb, 1, nb, 1)
    C = reshape(broadcast(+, A, B), (mb*mb, na*nb))
    return C
end

kronsum(A, B) = A .+ B




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

    # Julia doesn't has `rationalize` method for Integer😟
    nume = Int64[]
    denume = Int64[]
    for (_, i) in enumerate(a)
        isa(i, Int64) ? continue : i = rationalize(i)
        push!(nume, numerator(i))
        push!(denume, denominator(i))
    end
    return gcd(nume)/lcm(denume)
end

"""
    fotfdata(G)

Get the data from an FOTF object

### Example

```julia-repl
julia> G = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
julia> fotfdata(G)
5-element Vector{Any}:
  [1, 2]
  [0.5, 0.6]
  [1, 2]
  [0.3, 0.4]
 2
```
"""
function fotfdata(G::FOTF)
    b = G.num
    a = G.den
    nb = G.nn
    na = G.nd
    L = G.ioDelay

    if typeof(a) <: Number && typeof(b) <: Number
        a=[a]
        b=[b]
    end

    if typeof(na) <: Number && typeof(nb) <: Number
        na=[na]
        nb=[nb]
    end

    return a, na, b, nb, L
end




function Base.iszero(G::FOTF)
    (a, na, b, nb) = fotfdata(G)

    length(nb) == 1 & abs(b[1]) < eps() ? true : false
end

function isstable(G::FOTF)
    a0=0.001
    g=G
    a=g.nd
    a1=floor.(a./a0)
    g1= fotf2cotf(G)
    α = base_order(G)
    c = denvec(g1)[1]
    p0 = roots(c)# Need to verify
    kk=[]

    for k=1:length(p0)
        a=g.den
        na=g.nd
        pa=p0[k]^(1/α)
        if norm(a*(pa.^na)) < 1e-6
            push!(kk,k)
        end
    end
    p=p0[kk]
    
end



"""
Addition operation of two fractional order model.

!!! warning
    You can't add two systems with different I/O delay.

"""
function +(G1::FOTF, G2::FOTF)
    if iszero(G2)
        return G1
    elseif G1.ioDelay == G2.ioDelay
        key = 0
        G1 = simplify(G1)
        G2 = simplify(G2)
        (a1, na1, b1, nb1) = fotfdata(G1)
        (a2, na2, b2, nb2) = fotfdata(G2)
        if length(a1) == length(a2) #eps()
            if a1 == a2 && na1 == na2
                a=a1
                na=na1
                b=[b1 b2]
                nb=[nb1 nb2]
                key=1
            end
        end

        if key == 0
            a = kron(a1, a2)
            na = kronsum(na1, na2)
            b = [kron(a1, b2); kron(b1, a2)]
            nb = [kronsum(na1, nb2); kronsum(nb1, na2)]
        end# Here the a, na, b, nb should be vector, instead of matrix here.
        a=a[:]
        na=na[:]
        b=b[:]
        nb=nb[:]
        G = fotf(b, nb, a, na)
        return simplify(G)
    end
end

"""
Minus operation of FOTF
"""
function -(G1::FOTF, G2::FOTF)
    G = G1+(-G2)
    return G
end

-(G::FOTF) = fotf(-G.num, G.nn, G.den, G.nd)


function *(G1::FOTF, G2::FOTF)
    G = sisotimes(G1, G2)
    return G
end

*(x::Number, G::FOTF) = fotf(x*G.num, G.nn, G.den, G.nd, G.ioDelay)

*(G::FOTF, x::Number) = *(x::Number, G::FOTF)

function sisotimes(G1::FOTF, G2::FOTF)
    (a1, na1, b1, nb1) = fotfdata(G1)
    (a2, na2, b2, nb2) = fotfdata(G2)
    a = kron(a1, a2)
    na = kronsum(na1, na2)
    b = kron(b1, b2)
    nb = kronsum(nb1, nb2)
    a=a[:]
    na=na[:]
    b=b[:]
    nb=nb[:]
    G = simplify(fotf(b, nb, a, na, G1.ioDelay+G2.ioDelay))
    return G
end

# Equality judgement
"""
Test two FOTF are  equal or not.
"""
function ==(G1::FOTF, G2::FOTF)
    key = 0
    G = G1-G2
    b = G.num
    key = key + (length(b)==1 && b[1]==0)
    key == 0 ? false : true
end

"""
The inversion of an FOTF object
"""
function inv(G::FOTF)
    (a, na, b, nb, L) = fotfdata(G)
    L > 0 ? error("Delay term is not allowed in inversion operation.") : nothing

    G1 = fotf(a, na, b, nb, L)
    dd = b[1]
    G1.num = a/dd
    G1.den = b/dd
    G1.nd = nb
    G1.nn = na

    return simplify(G1)
end


"""
The division of two FOTF objects
"""
/(G1::FOTF, G2::FOTF) = G1.ioDelay == 0 && G2.ioDelay == 0 ? G1*inv(G2) : nothing

/(x::Number, G2::FOTF) = x*inv(G2)

/(G::FOTF, x::Number) = G*inv(x)