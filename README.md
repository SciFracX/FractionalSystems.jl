# FractionalSystems.jl

<p align="center">
<img width="250px" src="https://raw.githubusercontent.com/SciFracX/FractionalSystems.jl/master/docs/src/assets/logo.svg"/>
</p>


<p align="center">
  <a href="https://github.com/SciFracX/FractionalSystems.jl/actions?query=workflow%3ACI">
    <img alt="building" src="https://github.com/SciFracX/FractionalSystems.jl/workflows/CI/badge.svg">
  </a>
  <a href="https://codecov.io/gh/SciFracX/FractionalSystems.jl">
    <img alt="codecov" src="https://codecov.io/gh/SciFracX/FractionalSystems.jl/branch/master/graph/badge.svg">
  </a>
  <a href="https://scifracx.github.io/FractionalSystems.jl/dev/">
    <img src="https://img.shields.io/badge/docs-dev-blue.svg" alt="license">
  </a>
  <a href="https://github.com/SciFracX/FractionalSystems.jl/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/SciFracX/FractionalSystems.jl?style=flat-square" alt="license">
  </a>
</p>

<p align="center">
  <a href="https://github.com/SciFracX/FractionalSystems.jl/issues">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/SciFracX/FractionalSystems.jl?style=flat-square">
  </a>
  <a href="#">
    <img alt="GitHub stars" src="https://img.shields.io/github/stars/SciFracX/FractionalSystems.jl?style=flat-square">
  </a>
  <a href="https://github.com/SciFracX/FractionalSystems.jl/network">
    <img alt="GitHub forks" src="https://img.shields.io/github/forks/SciFracX/FractionalSystems.jl?style=flat-square">
  </a>
</p>



FractionalSystems.jl is a Julia toolbox can be used to model and analyse the fractional order systems.

## Get Started

To add the FractionalSystems.jl, using the Julia package manager:

```julia
pkg> add FractionalSystems
```

### Basic FOTF and FOSS

Fractional order transfer functions and fractional order state space are the basic elements in fractional control system, it is esay to create them in FractionalSystems.jl:

```julia
julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
------------------ exp(-2*s)     
s^{0.5} + 2s^{0.6}
```

```julia
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

## Analyzing methods

To see the root locus of a fractional order system:

```julia
julia> G = fotf([1], [0], [1, 10, 35, 50, 24], [3.5, 2.8, 2.1, 1.4, 0.7])
julia> rlocus(G)
```

![rlocus](examples/rlocusexample.png)

## Notice

The FractionalSystems.jl can be seen as the combination of [FOTF](https://www.mathworks.com/matlabcentral/fileexchange/60874-fotf-toolbox), [FOMCON](https://fomcon.net/) and [ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl)

We are working hard on FractionalSystems.jl to provide performant features as much as possible, if you are interested, don't hesitate to get in touch:)