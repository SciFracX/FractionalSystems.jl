module FractionalSystems

using ControlSystems, ControlSystemIdentification
using LinearAlgebra, SpecialFunctions
using ForwardDiff

include("foss/foss.jl")

include("fotf/fotf.jl")
include("fotf/show.jl")
include("fotf/rlocus.jl")
include("fotf/freqresp.jl")


export FOTF, fotf, fotfdata, base_order, fotf2cotf, rlocus, polyuniq, simplify, freqresp

export polyshow

export FOSS, foss, foss2ss

end
