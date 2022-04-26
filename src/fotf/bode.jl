using ControlSystems, ControlSystemIdentification

logspace(a, b) = exp10.(LinRange(a, b, 50))

"""
    bodeplot(G::FOTF)

Generate the bode plot of a given FOTF object.
"""
function ControlSystems.bodeplot(G::FOTF, w = exp10.(logspace(-4, 4)))
    H1 = freqresp(w.*im, G)
    result = zeros(ComplexF64, 1, 1, length(w))
    result[1, 1, :] = H1[:]
    H1 = FRD(w, result) # Frequency response data model here
    plot(H1)
end

"""
    bode(G::FOTF)

The frequency response data model of a given FOTF object.
"""
function ControlSystems.bode(G::FOTF, w = exp10.(logspace(-4, 4)))
    H1 = freqresp(w.*im, G)
    result = zeros(ComplexF64, 1, 1, length(w))
    result[1, 1, :] .= H1[:]
    H1 = FRD(H1, w) # Frequency response data model here
    return H1
end