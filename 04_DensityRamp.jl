include("utils.jl")
using OrnsteinZernike

# Potential
function Yukawa_R(r, p)
    κa = p.κ*0.5*p.σ
    LB = (p.z^2)*p.λB*exp(2*κa)/(1+κa)^2
#    return r <= p.σ ? Inf64 : LB*exp(-p.κ*r)/r
    return LB*exp(-p.κ*r)/r
end

# ML
σ = 144.0
z = -440
κ = σ/566.02

# MS
#σ = 32.0
#z = -110
#κ = σ/293.85

p = (λB = 0.71432/σ, σ = 1.0, κ = κ, z = -z)
potential = CustomPotential(Yukawa_R, p)

# thermodynamic state
dims = 3 # we consider a 3D system
ϕ = 0.00081 # ML
#ϕ = 0.0001825 # MS
ρ = (6/π)*ϕ # number density
kBT = 0.59 # thermal energy ML
#kBT = 0.72 # thermal energy MS
system = SimpleLiquid(dims, ρ, kBT, potential)

# closure
closure = HypernettedChain()

# Ng solver
M = 10^4 # number of gridpoints
dr = 200.0/M # grid spacing
max_iterations = 10^4 # max number of iterations before convergence
N_stages = 50 # number of previous iterations to use for the next guess

# density ramp
method = NgIteration(M=M; dr=dr, max_iterations=max_iterations, N_stages=N_stages)
#χ = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.91, 0.92, 0.93, 0.94, 0.95, 0.96, 0.97, 0.98, 0.99]
χ = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99]
densities = ρ*χ
method2 = DensityRamp(method, densities)

for i in eachindex(densities)
    println("$(χ[i]), $(densities[i])")
end

SOL = solve(system, closure, method2)
for (idx, sol) in enumerate(SOL)
    save_data("sdk_"*string(idx)*".dat", [sol.k sol.Sk])
end
#save_data("test.dat", [sol.r sol.gr])

