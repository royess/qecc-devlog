# Timeline

## Weekly plan

<!--
Codes:
- Hypergraph product, lifted, lifted product, and generalized bicycle.
- Classical codes.
Decoder:
- Iterative decoders, better performance.
- OSD.
-->

In total 12+ weeks, with the following plan:

- Week 1 (May 28 - June 9): concatenate quantum codes.
- Week 2 (June 10 - June 16): random Clifford circuit codes.
- Week 3 (June 17 - June 23): hypergraph product, lifted, lifted product.
- Week 4 (June 24 - June 30): classical codes for product construction.
- Week 5 (July 1 - July 7): generalized bicycle and 2GBA codes.
- Week 6 (July 8 - July 14): **(Midterm evaluation)**.
- Week 7 (July 15 - July 21):
- Week 8 (July 22 - July 28):
- Week 9 (July 29 - August 4):
- Week 10 (August 5 - August 11):
- Week 11 (August 12 - August 18):
- Week 12 (August 19 - August 26): **(Final evaluation)**.

## Process tracking

Schedule a weekly meeting on Friday, starting from June 21 in week 3.

### Week 1 and 2 (May 28 - June 16)

- 6-14: PR for concatenated quantum codes is merged [QuantumSavory/QuantumClifford.jl/pull/289].
- 6-15: random Clifford circuit codes are implemented and pass basic tests.

### Week 3 (June 17 - June 23)

- (Running into some problems in decoder tests.)
- 6-17: report a decoder bug [QuantumSavory/QuantumClifford.jl/issues/291].
    - later got fixed [QuantumSavory/QuantumClifford.jl/pull/296].
- 6-18: found that `ldpc` incompatable with `numpy`.
    - later got fixed [QuantumSavory/PyQDecoders.jl/pull/12].
