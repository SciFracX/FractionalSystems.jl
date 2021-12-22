module FractionalSystems

using ControlSystems

include("foss/foss.jl")

include("fotf/fotf.jl")

export FOTF, fotf, fotfdata

export FOSS, foss, foss2ss

end
