all: world.ml.out functor.ml.out monad.ml.out realworld.ml.out monoid.ml.out appfunctor.ml.out

%.ml.out:%.ml
	ocamlopt $^ -o $@

clean:
	rm -rf *.out *.o *.cmi *.cmx *.hi

mrproper: clean
	rm -rf *~
