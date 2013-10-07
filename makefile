all: bin output pop niche
	mv pop bin
	mv niche bin

bin:
	mkdir -p bin

output:
	mkdir -p output

pop: popmodel.c
	clang popmodel.c -o pop -lgsl -lgslcblas -O3 -DHAVE_INLINE -lm

niche: nichemodel.c
	clang nichemodel.c -o niche -lgsl -lgslcblas -O3 -DHAVE_INLINE -lm
