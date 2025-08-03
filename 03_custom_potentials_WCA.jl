using NESCGLE
using OrnsteinZernike

# Potential
function LJT(r, p)
    σ = p.σ
    #return r <= σ ? p.ϵ * ((σ/r)^12 - 2*(σ/r)^6 + 1.0) : 0.0
    return r <= (2^(1/6))*σ ? 4.0*p.ϵ * ((σ/r)^12 - (σ/r)^6) + p.ϵ : 0.0
end

p = (σ = 1.0, ϵ = 1.8)
potential = CustomPotential(LJT, p)

# thermodynamic state
dims = 2 # we consider a 2D system
ϕ = 0.5
ρ = (4/π)*ϕ # number density
kBT = 1.0 # thermal energy
system = SimpleLiquid(dims, ρ, kBT, potential)

# closure
closure = PercusYevick()
method = NgIteration()

sol = solve(system, closure, method)
save_data("gdr_phi_"*NESCGLE.complete_str(ϕ)*".dat", [sol.r sol.gr])
save_data("sdk_phi_"*NESCGLE.complete_str(ϕ)*".dat", [sol.k sol.Sk])
