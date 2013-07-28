# manna

A model of trait-based/neutral dynamics of trophic networks

Author: Timothée Poisot (`timothee_poisot_at_uqar.ca`)

Released under the terms of the BSD 2-clause licence. Forking this repository
grants implicit authorisation to pull and mere all future changes and release
them (with attribution) under the original license.

# sub-program `niche`

`niche` is a implementation of the niche model of food webs, also generating random carrying capacities based on species body sizes (see the preprint discussing this model to see how this is done).

```
niche S C
```

will generate a network of (exactly) `S` species, with (approximately) `C` connectance.

# sub-program `pop`

`pop` is an individual-based simulation model using the output of `niche` to
simulate network dynamics. The options are
