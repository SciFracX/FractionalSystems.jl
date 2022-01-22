# Frequency domain analysis

Frequency analysis is a powerful tool in system analysis, we can access the properties of the system in frequency domain to reveal the stability, gain margin, phase margin etc.

In FractionalSystems.jl, it is also easy to transform the system to frequency domain:

```julia-repl
julia> freqresp(s, G)
```

The ```freqresp``` function return the frequency response of the fractional order systems.

!!! tip "```logspace``` substitute"
    In Julia, there are no ```logspace(a, b)``` API, we can use ```exp10.(range(a, b, length=50))``` instead.