import ControlSystems.feedback

"""
    feedback(G1::FOTF, G2::FOTF)

Two FOTF in feedback connection.
"""
function ControlSystems.feedback(G1::FOTF, G2::FOTF)
    if G1.ioDelay == G2.ioDelay
        (a1, na1, b1, nb1, L1) = fotfdata(G1);
        (a2, na2, b2, nb2, L2) = fotfdata(G2);
        b = kron(b1, a2)
        nb = kronsum(nb1, na2)
        a = [kron(a1, a2); kron(b1, b2)]
        na = [kronsum(na1, na2)'; kronsum(nb1, nb2)']
        G = fotf(b[:], nb[:], a[:], na[:], G1.ioDelay)
    else
        error("Delays are incompatible")
    end
    return G
end