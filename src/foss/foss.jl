abstract type AbstractStateSpace end

struct FOSS <: AbstractStateSpace
    a
    b
    c
    d
    α
    ioDelay
    E
    x0
end

function foss(a, b, c, d, α, L, E, x0)
    return FOSS(a, b, c, d, α, L, E, x0)
end