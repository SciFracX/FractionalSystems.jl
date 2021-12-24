using ControlSystems

function ControlSystems.rlocus(G::FOTF)
    G1 = fotf2cotf(G)
    ControlSystems.rlocus(G1)
end