using Test
using AbstractAlgebra
include(joinpath(pathof(AbstractAlgebra), "..", "..", "test", "Rings-conformance-tests.jl"))
include("const_poly.jl")

S, _ = polynomial_ring(QQ, "x")

function test_elem(R::ConstPolyRing{elem_type(S)})
   return R(rand(base_ring(R), 1:6, -999:999))
end

test_Ring_interface(ConstantPolynomialRing(S))
