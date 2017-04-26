all: io.out

%.out:%.hs
	ghc $^ -o $@

clean:
	rm -rf *.out *.o *.cmi *.cmx *.hi

mrproper: clean
	rm -rf *~
