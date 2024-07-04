using AbstractAlgebra

using Random: Random, SamplerTrivial, GLOBAL_RNG
using RandomExtensions: RandomExtensions, Make2, AbstractRNG

import AbstractAlgebra: Ring
import AbstractAlgebra: RingElem
import AbstractAlgebra: add!
import AbstractAlgebra: addeq!
import AbstractAlgebra: base_ring
import AbstractAlgebra: base_ring_type
import AbstractAlgebra: canonical_unit
import AbstractAlgebra: characteristic
import AbstractAlgebra: divexact
import AbstractAlgebra: elem_type
import AbstractAlgebra: expressify
import AbstractAlgebra: get_cached!
import AbstractAlgebra: is_domain_type
import AbstractAlgebra: is_exact_type
import AbstractAlgebra: is_unit
import AbstractAlgebra: isequal
import AbstractAlgebra: mul!
import AbstractAlgebra: parent
import AbstractAlgebra: parent_type
import AbstractAlgebra: zero!

import Base: *
import Base: +
import Base: -
import Base: ==
import Base: ^
import Base: deepcopy_internal
import Base: hash
import Base: inv
import Base: isone
import Base: iszero
import Base: one
import Base: rand
import Base: show
import Base: zero

@attributes mutable struct PermGroupRing{T<:RingElement} <: NCRing
    base_ring::Ring
    l::Int

    function PermGroupRing{T}(R::Ring, l::Int, cached::Bool) where {T<:RingElement}
        return get_cached!(PermGroupRingElemID, R, cached) do
            new{T}(R, l)
        end::PermGroupRing{T}
    end
end

const PermGroupRingElemID = AbstractAlgebra.CacheDictType{NCRing,PermGroupRing}()

mutable struct PermGroupRingElem{T<:RingElement} <: NCRingElem
    coeffs::Dict{Perm,T}
    parent::PermGroupRing{T}

    function PermGroupRingElem{T}(coeffs::Dict{Perm,T}) where {T<:RingElement}
        return new{T}(coeffs)
    end

    function PermGroupRingElem{T}() where {T<:RingElement}
        return new{T}(Dict{Perm,T}())
    end

    function PermGroupRingElem{T}(n::T) where {T<:RingElement}
        return new{T}(Dict(Perm(parent.l) => n))
    end

    function PermGroupRingElem{T}(p::Perm) where {T<:RingElement}
        return new{T}(Dict(p => one(T)))
    end
end

# Data type and parent object methods

parent_type(::Type{PermGroupRingElem{T}}) where {T<:RingElement} = PermGroupRing{T}

elem_type(::Type{PermGroupRing{T}}) where {T<:RingElement} = PermGroupRingElem{T}

base_ring_type(::Type{PermGroupRing{T}}) where {T<:RingElement} = parent_type(T)

base_ring(R::PermGroupRing) = R.base_ring::base_ring_type(R)

parent(f::PermGroupRingElem) = f.parent

is_domain_type(::Type{PermGroupRingElem{T}}) where {T<:RingElement} = is_domain_type(T)

is_exact_type(::Type{PermGroupRingElem{T}}) where {T<:RingElement} = is_exact_type(T)

# TODO: gen?

function hash(f::PermGroupRingElem, h::UInt)
    r = 0x65125ab8e0cd44ca # TODO: what to do with this?
    return xor(r, hash(f.c, h))
end

function deepcopy_internal(f::PermGroupRingElem{T}, dict::IdDict) where {T<:RingElement}
    r = PermGroupRingElem{T}(deepcopy_internal(f.coeffs, dict))
    r.parent = f.parent # parent should not be deepcopied
    return r
end

# Basic manipulation

zero(R::PermGroupRing) = R()

one(R::PermGroupRing) = R(1)

iszero(f::PermGroupRingElem) = f == 0

isone(f::PermGroupRingElem) = f == 1

# TODO is_unit, characteristic

# Arithmetic functions

function -(a::PermGroupRingElem{T}) where {T<:RingElement}
    r = parent(a)()
    for (k, v) in a.coeffs
        r.coeffs[k] = -v
    end
    return r
end

function +(a::PermGroupRingElem{T}, b::PermGroupRingElem{T}) where {T<:RingElement}
    r = parent(a)()
    for (k, v) in a.coeffs
        r.coeffs[k] = v
    end
    for (k, v) in b.coeffs
        r.coeffs[k] += v
    end
    return r
end

-(a::PermGroupRingElem{T}, b::PermGroupRingElem{T}) where {T<:RingElement} = a + (-b)

function *(a::PermGroupRingElem{T}, b::PermGroupRingElem{T}) where {T<:RingElement}
    r = parent(a)()
    for (k1, v1) in a.coeffs
        for (k2, v2) in b.coeffs
            k = k1 * k2
            if haskey(r.coeffs, k)
                r.coeffs[k] += v1 * v2
            else
                r.coeffs[k] = v1 * v2
            end
        end
    end
    return r
end

# Ad hoc arithmetic functions

*(a::PermGroupRingElem{T}, n::T) where {T<:RingElement} = a * parent(a)(n)

*(n::T, a::PermGroupRingElem{T}) where {T<:RingElement} = a * n

+(a::PermGroupRingElem{T}, n::T) where {T<:RingElement} = a + parent(a)(n)

+(n::T, a::PermGroupRingElem{T}) where {T<:RingElement} = a + n

*(a::PermGroupRingElem{T}, p::Perm) where {T<:RingElement} = a * parent(a)(p)

*(p::Perm, a::PermGroupRingElem{T}) where {T<:RingElement} = parent(a)(p) * a

+(a::PermGroupRingElem{T}, p::Perm) where {T<:RingElement} = a + parent(a)(p)

+(p::Perm, a::PermGroupRingElem{T}) where {T<:RingElement} = a + p

# Comparison

function ==(a::PermGroupRingElem{T}, b::PermGroupRingElem{T}) where {T<:RingElement}
    if length(a.coeffs) != length(b.coeffs)
        return false
    end
    for (k, v) in a.coeffs
        if !haskey(b.coeffs, k) || b.coeffs[k] != v
            return false
        end
    end
    return true
end

# Ad hoc comparison

==(a::PermGroupRingElem{T}, n::T) where {T<:RingElement} = length(a.coeffs) == 1 && a.coeffs[Perm(parent(a).l)] == n

==(n::T, a::PermGroupRingElem{T}) where {T<:RingElement} = a == n

==(a::PermGroupRingElem{T}, p::Perm) where {T<:RingElement} = length(a.coeffs) == 1 && a.coeffs[p] == 1

==(p::Perm, a::PermGroupRingElem{T}) where {T<:RingElement} = a == p


# TODO division

# TODO Random generation

# TODO Promotion rules

# Constructors by overloading the call syntax for parent objects

function (R::PermGroupRing{T})() where {T<:RingElement}
    r = PermGroupRingElem{T}()
    r.parent = R
    return r
end

function (R::PermGroupRing{T})(n::Union{Integer,Rational,AbstractFloat}) where {T<:RingElement}
    r = PermGroupRingElem{T}(base_ring(R)(n))
    r.parent = R
    return r
end

function (R::PermGroupRing{T})(n::T) where {T<:RingElement}
    base_ring(R) != parent(n) && error("Unable to coerce group ring element")
    r = PermGroupRingElem{T}(n)
    r.parent = R
    return r
end

function (R::PermGroupRing{T})(p::Perm) where {T<:RingElement}
    r = PermGroupRingElem{T}(p)
    r.parent = R
    return r
end

function (R::PermGroupRing{T})(f::PermGroupRingElem{T}) where {T<:RingElement}
    parent(f) != R || error("Unable to coerce group ring")
    return f
end

# TODO may need more constructors to remove ambiguities
