using FractionalSystems, ControlSystems
using Test

@testset "Test FractionalSystems.jl" begin
    include("fotf.jl")
    include("foss.jl")
    #include("FOLE.jl")
end
