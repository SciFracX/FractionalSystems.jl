# Get Started

## Fractional transfer function

After installed the FractionalSystems.jl package and using it, we can now create a fractional order transfer function:

```julia-repl
julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
------------------
s^{0.5} + 2s^{0.6}
```

## Fractional order state space

In FractionalSystems.jl, it is easy to create a fractional order state space:

```julia-repl
julia> sys = foss()
```