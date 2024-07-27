# TODOs for LP code PR

Thanks for all the answers you have provided -- they help in wrapping my head around your work. In terms of TODOs, besides the things you are already taking care of, I think we need the following:

- [ ] Make a draft pull request to the Nemo folks with the code you have created for the permutation representations here, to get their opinion on your approach. No expectation to have such a PR merged in the near term, but it would be valuable to engage more properly with that community, given how heavily we are relying on their functionality.
- [ ] Add to the docstring of the permutation object you have created a section along the lines of "why do we need this and why is it not upstreamed to Nemo". I think I am mostly convinced by the reasons you have given, but keeping a record of these reasons for future developers would be very useful. This is related to the first point.
- [ ] Make simple intuitive ways to construct the historical precursors of the general lifted product codes (bicycle and generalized bicycle) with documentation (and references to papers) that explain how the generalization works
- [ ] Make all the constructors you enumerated in Lifted and lifted product codes #312 (comment) (this is related to the previous point)
- [ ] Document all of these constructors (potentially including examples from papers)
- [ ] Re-examine the choice of internal fields for the code types you have created -- the hardcoded matrix type and the general "representation" function. I personally do not have better ideas right now, but after having the previous 3 points completed, I imagine it would be easier to figure out whether there is a better option here.

Others:

- [ ] Encoding and syndrome circuit issues. Syndrom circuits seem to be more difficult to deal with.
