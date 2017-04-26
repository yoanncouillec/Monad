all: monad.scm.out

%.scm.out:%.scm
	bigloo $^ -o $@

clean:
	rm -rf *.out *.o *.cmi *.cmx *.hi

mrproper: clean
	rm -rf *~
