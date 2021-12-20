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
    for (i, j) in enumerate(G.num)
        l=G.nn[i]
        print("$j*s^"*"{$l}")
    end
    print("\n")

    println("---------"^length(G.den))

    for (i, j) in enumerate(G.den)
        l=G.nd[i]
        print("$j*s^"*"{$l}")
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