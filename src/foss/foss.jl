abstract type AbstractStateSpace end

struct FOSS <: AbstractStateSpace
    a
    b
    c
    d
    α::Float64
    ioDelay
    E
    x0
end

function foss(a, b, c, d, α, L, E, x0)
    return FOSS(a, b, c, d, α, L, E, x0)
end

# Convert fractional order state space to intege state space
function foss2ss(sys::FOSS)
    return ss(sys.a, sys.b, sys.c, sys.d)
end


Base.print(io::IO, sys::FOSS) = show(io, sys)

function Base.show(io::IO, sys::FOSS)
    println(typeof(sys))
    print("\n")
    println("A =")
    Base.print_matrix(io::IO, sys.a)
    print("\n")
    println("B =")
    Base.print_matrix(io::IO, sys.b)
    print("\n")
    println("C =")
    Base.print_matrix(io::IO, sys.c)
    print("\n")
    println("D =")
    Base.print_matrix(io::IO, sys.d)
    print("\n")
    println("\nDescriptor matrix:\n")
    print("E =\n")
    Base.print_matrix(io::IO, sys.E)
    println("\n")
    println("Time delay is $(sys.ioDelay)")
    println("α = $(sys.α)")
    println("Initial state vector x₀ = $(sys.x0)")
end