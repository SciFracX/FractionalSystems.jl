using ControlSystems

"""
    rlocus(G)

Draw the root locus plot
"""
function ControlSystems.rlocus(G::FOTF)
    G1 = fotf2cotf(G)
    ControlSystems.rlocus(G1)
end