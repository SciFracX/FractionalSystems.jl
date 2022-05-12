using FractionalSystems, Plots

function Danca(du, u, t)
    du[1] = -u[1]+u[2]
    du[2] = -u[3]*sign(u[1])+u[4]
    du[3] = abs(u[1])-1
    du[4] = -0.5*u[2]
    du
end

LE, tspan=FOLyapunov(Danca, 0.98, 0, 0.02, 300, [0.1; 0.1; 0.1; 0.1], 0.005, 1000)


plot(tspan, LE[1, :])
plot!(tspan, LE[2, :])
plot!(tspan, LE[3, :])
plot!(tspan, LE[4, :])
