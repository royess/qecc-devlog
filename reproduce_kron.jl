using Hecke
import LinearAlgebra

GA = group_algebra(GF(2), abelian_group(10))
x = gens(GA)[]
A = [x GA(1); x GA(0)]
B = LinearAlgebra.I(10)
@show kron(B, A)
