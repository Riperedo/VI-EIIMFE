using NESCGLE
using OrnsteinZernike

# In order to solve an Ornstein-Zernike equation, there are a number of things that need to be specified.

# 1. The interaction potential,
ϵ = 1.0
σ = 1.0
n = 8
potential = PowerLaw(ϵ, σ, n)

# 2. Thermodynamic State: Now that we have the potential, we define the system

dims = 3 # we consider a 3D system
ρ = 0.1 # number density
kBT = 0.2 # thermal energy
system = SimpleLiquid(dims, ρ, kBT, potential)

# 3. Closure relation: The third step is to define a closure relation. For now, let's stick to the simple Hypernetted Chain closure
closure = HypernettedChain()

# 4. solver
sol = solve(system, closure)

save_data("test.dat", [sol.r sol.gr])
#save_data("test.dat", [sol.k sol.Sk])

