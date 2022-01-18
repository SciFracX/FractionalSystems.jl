# Get Started

## Fractional transfer function

After installed the FractionalSystems.jl package and using it, we can now create a fractional order transfer function:

```julia-repl
julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)
FOTF

s^{0.3} + 2s^{0.4}
------------------ exp(-2*s)     
s^{0.5} + 2s^{0.6}
```

You can perform basic arithmetic operations on fractional order functions:

```julia-repl
julia> a = fotf([5, 6], [7, 8], [1, 2], [3, 4]);
julia> b = fotf([1, 2], [1, 2], [1, 2], [1, 2]);
julia> a+b
2.0s^{1} + 1.0s^{5} + 6.0s^{0} + 5.0s^{4}
-----------------------------------------
          2s^{1} + 1s^{0}
```

### Basic arithmetic operations

In FractionalSysetms.jl we can perform basic arithmetic operations on fractional order transfer functions:

    * Addition
    * Subtraction
    * Multiplication
    * Division

```julia-repl
julia> a = fotf([1, 2], [0.3, 0.4], [3, 4], [0.5, 0.6])
FOTF

2s^{0.4}+s^{0.3}
-----------------
4s^{0.6}+3s^{0.5}
julia> b=fotf([1, 2], [0.3, 0.4], [2, 3], [0.4, 0.5])
FOTF

2s^{0.4}+s^{0.3}
-----------------
3s^{0.5}+2s^{0.4}

julia> a+b
FOTF

8s^{0.3}+16s^{0.2}+10s^{0.10000000000000003}+2
----------------------------------------------
12s^{0.39999999999999997}+17s^{0.3}+6s^{0.2}

julia> a-b
-8s^{0.3}-4s^{0.2}+4s^{0.10000000000000003}+2
---------------------------------------------
12s^{0.39999999999999997}+17s^{0.3}+6s^{0.2}

julia> a*b
FOTF

4s^{0.20000000000000007}+4s^{0.09999999999999998}+1
-----------------------------------------------------------
12s^{0.5000000000000001}+17s^{0.4}+6s^{0.30000000000000004}

julia> a/b
FOTF

6.0s^{0.20000000000000007}+7.0s^{0.09999999999999998}+2.0
---------------------------------------------------------------------------------
8.0s^{0.29999999999999993}+10.0s^{0.20000000000000007}+3.0s^{0.09999999999999998}
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