# Conversation with ControlSystems.jl

While Fractional systems are generalization of integer order control systems, so it is also convenient to transform between FractionalSystems.jl and ControlSystems.jl.

## Conversation between Transfer Function

To achieve the translation of ```Transfer Function``` and ```Fractional Order Transfer Function```,  we only need to use the command **fotf2cotf** to transform the fractional order transfer function to integer order transfer function:

```julia-repl
julia> G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78])
FOTF

s^{0.1} + 2s^{0.2} + 3s^{0.34}
---------------------
4s^{0.65} + 5s^{0.67} + 6s^{0.78}

julia> fotf2cotf(G)
TransferFunction{Continuous, ControlSystems.SisoRational{Float64}}        
3.0s^34 + 2.0s^20 + 1.0s^10
---------------------------
6.0s^78 + 5.0s^67 + 4.0s^65

Continuous-time transfer function model
```


## Conversation between State Space

To transform the fractional order state space to integer state space, we can use the **foss2ss** function:

```julia-repl
julia> s = foss([-5 0; 0 -5], [2; 2], [3 3],[0], 0.5, 2, [2], 2)
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
[2]

Time delay is 2
α = 0.5
Initial state vector x₀ = 2

julia> foss2ss(s)
StateSpace{Continuous, Int64}
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

Continuous-time state-space model
```