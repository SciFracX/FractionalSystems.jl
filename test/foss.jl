using FractionalSystems, ControlSystems
using Test

@testset "Test FOSS" begin
    s = foss([-5 0; 0 -5], [2; 2], [3 3],[0], 0.5, 2, [2], 2)

    @test foss2ss(s)  == ss([-5 0; 0 -5], [2; 2], [3 3], [0])
end