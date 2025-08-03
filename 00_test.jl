include("utils.jl")
using OrnsteinZernike

dims = 3; kBT = 1.0 
ρ = 0.1

potential = HardSpheres(1.0)
system = SimpleLiquid(dims, ρ, kBT, potential)
closure = PercusYevick()
sol = @time solve(system, closure);

save_data("test.dat", [sol.r sol.gr])
#save_data("test.dat", [sol.k sol.Sk])
