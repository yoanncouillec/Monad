all: monad.scm.out monad2.scm.out world.ml.out io.out functor.ml.out monad.ml.out realworld.ml.out

monad.scm.out:monad.scm
	bigloo $^ -o $@

monad2.scm.out:monad2.scm
	bigloo $^ -o $@

world.ml.out:world.ml
	ocamlopt $^ -o $@

io.out:io.hs
	ghc $^ -o $@

functor.ml.out:functor.ml
	ocamlopt $^ -o $@

monad.ml.out:monad.ml
	ocamlopt $^ -o $@

realworld.ml.out:realworld.ml
	ocamlopt $^ -o $@

clean:
	rm -rf *.out *.o *.cmi *.cmx *.hi