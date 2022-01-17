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

-(G::FOTF)=fotf(-G.num, G.nn, G.den, G.nd)


function *(G1::FOTF, G2::FOTF)
    G = sisotimes(G1, G2)
    return G
end

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


# Not done
function ==(G1::FOTF, G2::FOTF)
    key = 0
    G = G1-G2
    b = G.num
    key = key+(length(b))
end

"""
The inversion of an FOTF object
"""
function inv(G::FOTF)
    (a, na, b, nb, L) = fotfdata(G)
    L > 0 ? error("Delay term is not allowed in inversion operation.") : nothing

    G1 = fotf(a, na, b, nb, L)
    dd=b[1]
    G1.num=a/dd
    G1.den=b/dd
    G1.nd=nb
    G1.nn=na

    return simplify(G1)
end