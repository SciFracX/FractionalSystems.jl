using FractionalSystems
using Test

@testset "Test FOTF" begin
    a = fotf([1, 2], [1, 2], [1, 2], [1, 2])

    @test isa(a, FOTF)
    @test fotfdata(a) == [[1, 2], [1, 2], [1, 2], [1, 2], 0]
    @test iszero(a) == false
end