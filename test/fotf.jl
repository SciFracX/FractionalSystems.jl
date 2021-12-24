using FractionalSystems
using Test

@testset "Test FOTF" begin
    a = fotf([1, 2], [1, 2], [1, 2], [1, 2])

    @test isa(a, FOTF)
    @test fotfdata(a) == [[1, 2], [1, 2], [1, 2], [1, 2], 0]
    @test iszero(a) == false
end

@testset "Test base_order" begin
    G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78])
    
    @test base_order(G) == 0.01
end