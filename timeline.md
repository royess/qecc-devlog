# Timeline

## Weekly plan

In total 12+ weeks, with the following plan:

- ECCs (`QuantumClifford.jl`)
    - Week 1 (May 28 - June 9): concatenate quantum codes.
    - Week 2 (June 10 - June 16): random Clifford circuit codes.
    - Week 3 (June 17 - June 23): hypergraph product, lifted, lifted product codes.
    - Week 4 (June 24 - June 30): classial codes: [Cyclic codes](https://errorcorrectionzoo.org/c/cyclic) and [Quasi-cyclic code](https://errorcorrectionzoo.org/c/quasi_cyclic).
    - Week 5 (July 1 - July 7): classical codes: random codes and Tanner codes, for which we may reuse [QuantumExpander.jl](https://github.com/QuantumSavory/QuantumExpanders.jl).
    - Week 6 (July 8 - July 14): generalized bicycle, bivariate bicycle code, and 2GBA codes. (Balanced product, if time permits.) **(Midterm evaluation)**.
- Decoders (`LDPCDecoders.jl`)
    - Week 7 (July 15 - July 21): improve the performance of OSD.
    - Week 8 (July 22 - July 28): improve the performance of iterative decoders.
    - Week 9 (July 29 - August 4): small-set flip, *more on readings and implementations*.
    - Week 10 (August 5 - August 11): small-set flip, *more on performance and testings*.
- Documentations.
    - Week 11 (August 12 - August 18): documentations, *more on benchmarkings*, https://eccbench.areweentangledyet.com/.
    - Week 12 (August 19 - August 26): documentations, *more on tutorials*. **(Final evaluation)**.

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
