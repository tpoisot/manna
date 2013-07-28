all: pop niche
	mkdir -p bin
	mv pop bin
	mv niche bin

pop: popmodel.c
	clang popmodel.c -o pop -lgsl -lgslcblas -O3 -DHAVE_INLINE
	chmod +x pop
	touch pop

niche: nichemodel.c
	clang nichemodel.c -o niche -lgsl -lgslcblas -O3 -DHAVE_INLINE
	chmod +x niche
	touch niche
