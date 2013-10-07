BIN = bin
NICHE = $(BIN)/niche
POP = $(BIN)/pop
OPTS = -lgsl -lgslcblas -O3 -DHAVE_INLINE -lm

all: $(BIN) output $(POP) $(NICHE)

$(BIN):
	mkdir -p $(BIN)

output:
	mkdir -p output

$(POP): popmodel.c
	clang popmodel.c -o $(POP) $(OPTS)

$(NICHE): nichemodel.c
	clang nichemodel.c -o $(NICHE) $(OPTS)
