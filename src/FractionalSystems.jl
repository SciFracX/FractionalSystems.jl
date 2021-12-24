module FractionalSystems

using ControlSystems

include("foss/foss.jl")

include("fotf/fotf.jl")
include("fotf/rlocus.jl")

export FOTF, fotf, fotfdata, base_order, fotf2cotf, rlocus

export FOSS, foss, foss2ss

end
