include("utils.jl")
using OrnsteinZernike

# Potencial
pot = HardSpheres(1.0)

# Estado termodinamico
ρ = 0.6
kBT = 1.0
dims = 3
system = SimpleLiquid(dims, ρ, kBT, pot)

# cerradura
closure = PercusYevick()

# Ng solver
M = 10^4 # number of gridpoints
dr = 100.0/M # grid spacing
max_iterations = 10^4 # max number of iterations before convergence
N_stages = 8 # number of previous iterations to use for the next guess

method = NgIteration(M=M; dr=dr, max_iterations=max_iterations, N_stages=N_stages)

sol = solve(system, closure, method);

save_data("test.dat", [sol.r sol.gr])
#save_data("test.dat", [sol.k sol.Sk])

