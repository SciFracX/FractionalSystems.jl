using ControlSystems

function ControlSystems.bode(G)
    # Julia replace `logspace` as `exp10.(range(start, stop=stop, length=50))`
    w = exp10.(range(1, 3, length=50))
    H1 = freqresp(w.*im, G)
    #H1 = ControlSystems.bode(H1, w)
    ControlSystems.bodeplot(H1)
end


#=
function ControlSystems.bode(G, w)
    H1 = freqresp(w.*im, G)
    H1 = ControlSystems.freqresp(H1, w)
    H1 = ControlSystems.bode(H1, w)
    ControlSystems.bodeplot(H1)
end
=#