# manna

A model of trait-based/neutral dynamics of trophic networks

Compilation and execution requires the *GNU Scientific Library*

Author: Timothée Poisot (`timothee_poisot_at_uqar.ca`)

Released under the terms of the GPL license. Forking this repository
grants implicit authorisation to pull and mere all future changes and release
them (with attribution) under the original license.

# sub-program `niche`

`niche` is a implementation of the niche model of food webs, also
generating random carrying capacities based on species body sizes (see
the preprint discussing this model to see how this is done).

```
niche S C
```

will generate a network of (exactly) `S` species, with
(approximately) `C` connectance. The resulting list of species will be
put in a file called `splist.txt`. This file is then read by the
sub-program `pop`.

The file `splist.txt` is made of 6 columns: the identifier of the
species (from 1 to `S`), its body size, range, and centroid (all
between 0 and 1, as in the original *niche model* of Williams
& Martinez), and the randomly generated carrying capacity and
starting population size.

# sub-program `pop`

`pop` is an individual-based simulation model using the output of
`niche` to simulate network dynamics. Note that because `pop` reads
informations within a file called `splist.txt`, the user can
generate this file in any other way. Examples are given in the
publication accompanying this program.

The executable generated after compilation requires a number of arguments:

1. the file in which the species list is stored (`splist.txt`, unless an other file was generated)
2. an integer giving the number of species in the flile `splist.txt`
3. an integer telling whether to use body size to determine feeding range (`1`) or only neutral dynamics (`0`)
4. an integer giving the simulation time
5. an integer giving the number of timesteps that should be recovered by the end of the simulation
6. the prefix of the output file
7. an integer telling whether there is migration at each timestep (`1`for migration, `0` for no migration)
8. an integer telling how many individuals are added at each time step
9. an integer telling whether the system starts with all species (`0`), or whether it should be assembled species-by-species (`1`)

