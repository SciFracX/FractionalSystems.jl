module FractionalSystems

using ControlSystems, ControlSystemIdentification
using LinearAlgebra, SpecialFunctions
import FractionalDiffEq: FODESystem
using ForwardDiff

include("foss/foss.jl")

include("fotf/fotf.jl")
include("fotf/show.jl")
include("fotf/rlocus.jl")
include("fotf/freqresp.jl")

include("FOLE.jl")

export FOTF, fotf, fotfdata, base_order, fotf2cotf, rlocus, polyuniq, simplify, freqresp

export polyshow

export FOSS, foss, foss2ss

export FOLyapunov

end
