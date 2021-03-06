abstract type AbstractFOStateSpace end

mutable struct FOSS <: AbstractFOStateSpace
    a
    b
    c
    d
    α::Float64
    ioDelay
    E
    x0
end

foss(a, b, c, d, α, L, E, x0) =  FOSS(a, b, c, d, α, L, E, x0)

function fossdata(sys::FOSS)
    return [sys.a sys.b sys.c sys.d sys.E sys.ioDelay sys.x0 sys.α]
end

function minreal(G::FOSS)
    α = G.α
    G2 = foss2ss(G)
    G2 = minreal(G2)
end

# Convert fractional order state space to integer state space
function foss2ss(sys::FOSS)
    return ss(sys.a, sys.b, sys.c, sys.d)
end

# Show the created fractional order state space
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
    isa(sys.E, Matrix) ? Base.print_matrix(io::IO, sys.E) : print(sys.E)
    println("\n")
    println("Time delay is $(sys.ioDelay)")
    println("α = $(sys.α)")
    println("Initial state vector x₀ = $(sys.x0)")
end

"""
    ctrb(G::FOSS)

Controllability test matrix for FOSS
"""
ctrb(G::FOSS) = ControlSystems.ctrb(G.a, G.b)

"""
    obsv(G::FOSS)

Observability test matrix for FOSS
"""
obsv(G::FOSS) = ControlSystems.obsv(G.a, G.c)
