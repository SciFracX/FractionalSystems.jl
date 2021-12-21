import Base: +, -, *, \
import Base: size

import Base: print

abstract type AbstractTransferFunction end

struct FOTF <: AbstractTransferFunction
    num
    nn
    den
    nd
    ioDelay
end

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


function +(G1::FOTF, G2::FOTF)

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

    println("---------"^length(G.den))

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
    key=0

end