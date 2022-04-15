module FractionalSystems

using ControlSystems, LinearAlgebra, FractionalDiffEq

include("foss/foss.jl")

include("fotf/fotf.jl")
include("fotf/show.jl")
include("fotf/rlocus.jl")
include("fotf/freqresp.jl")

export FOTF, fotf, fotfdata, base_order, fotf2cotf, rlocus, polyuniq, simplify, freqresp

export polyshow

export FOSS, foss, foss2ss

end
