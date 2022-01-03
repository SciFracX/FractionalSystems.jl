using ControlSystems

"""
    freqresp(s, G)

The frequency response of FOTF.
"""
function ControlSystems.freqresp(s, G::FOTF)
    (a, na, b, nb, L) = fotfdata(G)

    # Initialize response
    # H1 = zeros(length(s))
    H1 = []

    for  k = 1:length(s)
        P = b'*(s[k].^nb)
        Q = a'*(s[k].^na)
        #H1[k] = P/Q
        push!(H1, P/Q)
    end
    
    if L>0
        H1 = H1.*exp.(L*s)
    end
    return H1
end