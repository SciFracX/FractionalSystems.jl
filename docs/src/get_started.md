# Get Started

## Fractional transfer function

After installed the FractionalSystems.jl package and using it, we can now create a fractional order transfer function:

```julia-repl
julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
------------------ exp(2*s)     
s^{0.5} + 2s^{0.6}
```

You can perform basic arithmetic operations on fractional order functions:

```julia-repl
julia> a = fotf([5, 6], [7, 8], [1, 2], [3, 4])
julia> b = fotf([1, 2], [1, 2], [1, 2], [1, 2])
julia> a+b
2.0s^{1} + 1.0s^{5} + 6.0s^{0} + 5.0s^{4}
-----------------------------------------
          2s^{1} + 1s^{0}
```

## Fractional order state space

In FractionalSystems.jl, it is easy to create a fractional order state space:

```julia-repl
julia> sys = foss([-5 0; 0 -5],[2; 2],[3 3],[0], 0.5, 1, 1, 1)
FOSS

A =
 -5   0
  0  -5
B =
 2
 2
C =
 3  3
D =
 0

Descriptor matrix:

E =
1

Time delay is 1
α = 0.5
Initial state vector x₀ = 1
```