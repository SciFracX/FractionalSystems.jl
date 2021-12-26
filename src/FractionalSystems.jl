module FractionalSystems

using ControlSystems

include("foss/foss.jl")

include("fotf/fotf.jl")
include("fotf/show.jl")
include("fotf/rlocus.jl")
include("fotf/freqresp.jl")

export FOTF, fotf, fotfdata, base_order, fotf2cotf, rlocus, polyuniq, simplify, freqresp

export FOSS, foss, foss2ss

end
