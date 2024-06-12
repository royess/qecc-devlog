using QuantumClifford
using QuantumClifford.Experimental.NoisyCircuits


function random_local_layer(nqubits, parity)
    c = ⊗([random_clifford(2) for i in 1:nqubits÷2]...)
    parity==0 ? c : permute(c, vcat(2:nqubits, [1]))
end

function apply_random_local_layers!(state, nlayers)
    for i in 1:nlayers
        apply!(state, random_local_layer(nqubits(state), i%2))
    end
    state
end

function apply_random_local_layers(state, nlayers)
    s = copy(state)
     apply_random_local_layers!(s, nlayers)
    s
end

function random_clifford_with_measurements(nqubits, nlayers, p)
    places_to_measure = rand(nlayers*nqubits) .< p
    reg = Register(one(Stabilizer, nqubits), fill(false, nlayers*nqubits))
    for i in 1:nlayers
        apply!(reg, random_local_layer(nqubits, i%2))
        for j in 1:nqubits
            k = nqubits*(i-1)+j
            places_to_measure[k] && apply!(reg, sMZ(j,k))
        end
    end
    reg
end
