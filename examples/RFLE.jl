using FractionalSystems

function RF(du, u, t)
    du[1] = u[2]*(u[3]-1+u[1]*u[1])+0.1*u[1];
    du[2] = u[1]*(3*u[3]+1-u[1]*u[1])+0.1*u[2];
    du[3] = -2*u[3]*(0.98+u[1]*u[2]);
    du
end

LE, tspan=FOLyapunov(RF, 0.98, 0, 0.02, 300, [0.1; 0.1; 0.1], 0.005, 1000)

plot(tspan, LE[1, :])
plot!(tspan, LE[2, :])
plot!(tspan, LE[3, :])