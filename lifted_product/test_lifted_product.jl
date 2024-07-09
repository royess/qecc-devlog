using Revise, QuantumClifford.ECC, Nemo

R = PermutationGroupRing(GF(2), 20)
A = Matrix(R[Dict(Perm(20) => 1) Dict(Perm(20) => 1); Perm(vcat([1,3,2], 4:20)) Dict(Perm(20) => 1)])
c = LiftedCode(A)
lpc = LPCode(c, c)
lpc |> parity_checks
