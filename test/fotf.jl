using FractionalSystems, ControlSystems
using Test

@testset "Test FOTF" begin
    a = fotf([1, 2], [1, 2], [1, 2], [1, 2])

    @test isa(a, FOTF)
    @test fotfdata(a) == [[1, 2], [1, 2], [1, 2], [1, 2], 0]
    @test iszero(a) == false
end

G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78])
num = zeros(34+1)
num[34+1] = 3
num[20+1]=2
num[10+1] = 1
num = num[end:-1:1]

den = zeros(78+1)
den[78+1] = 6
den[67+1] = 5
den[65+1] = 4
den = den[end:-1:1]

@testset "Test base_order" begin
    @test base_order(G) == 0.01
end

@testset "Test fotf2cotf" begin
    @test fotf2cotf(G) == tf(num, den)
end

@testset "Test Polyuniq" begin
    @test polyuniq([2, 2], [4, 4], 0.0001) == (4, 4)
end

@testset "Test simplify" begin
    g = fotf([2, 2], [4, 4], [6, 6], [8, 8])
    sg = fotf(12, 4, 4, 0)
    @test fotfdata(simplify(g, 0.0001)) == fotfdata(sg)
end

@testset "Test freqresp" begin
    a = fotf([1, 2], [1, 2], [1, 2], [1, 2])
    @test freqresp([1; 2; 3], a) == [1.0; 1.0; 1.0]
end