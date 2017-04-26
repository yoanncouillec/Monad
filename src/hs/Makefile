all: io.out io_no_sugar.out io_test.out

%.out:%.hs
	ghc $^ -o $@

clean:
	rm -rf *.out *.o *.cmi *.cmx *.hi

mrproper: clean
	rm -rf *~
