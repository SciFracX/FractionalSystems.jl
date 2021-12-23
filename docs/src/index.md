```@meta
CurrentModule = FractionalSystems
```

# FractionalSystems

Hello there👋!

FractionalSystems.jl is a Julia package aiming at providing support for fractional order system analysis.

## Installation

To install FractionalCalculus, please open Julia REPL and press ```]``` key to use package mode and then type the following command:

```julia-repl
Pkg> add FractionalSystems
```

Or if you want to experience the latest version of FractionalSystems.jl:

```julia-repl
Pkg> add FractionalSystems#master
```

## Motivation

Why we create the FractionalSystems.jl?

* The current Fractional computing packages are encoded using Matlab and has not been updated for quite a long time

* There are many good algorithms and valuable designs out there in papers have not been implemented so far

* We admire the features and performance of the Julia language

* We need the help of the existing fractional computing relating packages(Also maintained by SciFracX community)

## Notice

FractionalSystems.jl is evolved from [FOMCON](https://fomcon.net/) and [FOTF](https://www.mathworks.com/matlabcentral/fileexchange/60874-fotf-toolbox), which are Matlab toolboxs used to serve Matlab. In the future, we plan to integrate all the current fractional order modeling toolboxs, such as Ninteger toolbox, CRONE toolbox and with the help of Julia, build a performant and feature rich toolbox.

!!! info "WIP"
    FractionalSystems.jl is under heavy construction, some API or docs might change a lot.