# Lifted codes

## References for implementation

https://github.com/quantumgizmos/bias_tailored_qldpc?tab=readme-ov-file#lifted-product-codes

https://github.com/quantumgizmos/ldpc

https://github.com/Infleqtion/qLDPC

## Abstract algebraic structures

### Groups

Lifts can be chosen as elements of a group. For parity checks, we need a representation over $\mathbb F_2$.

A common way is to use permutation representation.

As the first step, we will support permutation group elements for lifts. And the later plan is to support more groups.

The gap is that Julia packages do not have functions that compute representations. Also, groups are defined in Oscar.jl, not AbstractAlgebra.jl, which is already a dependency.

For reference, a Python package, abstract_algebra, has [a function](https://github.com/alreich/abstract_algebra/blob/9f7efb79ebe30167b621f5eff5f07b0766c90c7f/src/finite_algebras.py#L686) that computes regular representation for groups, with [document pages](https://abstract-algebra.readthedocs.io/en/latest/40_reg_rep.html).

So, what we need to do is the following:

1. Introduce groups from Oscar.jl or somewhere else.
2. Implement permutation representation for groups.

### Rings

In literature, rings are also used for lifts. In most cases, the ring is taken as a group algebra over $\mathbb F_2$, which is fundamentally the same as a group.

We can also consider any ring $R$ and its associative $\mathbb F_2$-algebra. The $\mathbb F_2$-algebra $R$ has a faithful matrix representation, as mentioned in Panteleev's paper.

[A small piece of math.](https://math.stackexchange.com/questions/141249/what-is-difference-between-a-ring-and-a-field)

Further, we will need the ring $R$ to have a multiplicative identity for hypergraph product construction. (It means the multiplication is a monoid.) The $\mathbb F_2$-algebra $R$ will then be called an unital associative algebra.

(I think supporting rings is not an urgent need since groups are usually used for lifts. When people say they use polynomial rings, they usually just mean cyclic groups.)
