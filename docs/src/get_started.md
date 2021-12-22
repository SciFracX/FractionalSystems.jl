# Get Started

After installed the FractionalSystems.jl package and using it. we can first look at how to create a fractional order transfer function:

```julia
julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
--------------
s^{0.5} + 2s^{0.6}
```