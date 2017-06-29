all:
	ocamlc -c monad.mli
	ocamlc -c idMonad.mli
	ocamlc -c idMonad.ml
	ocamlc -c maybeMonad.mli
	ocamlc -c maybeMonad.ml
	ocamlc -c errorMonad.mli
	ocamlc -c errorMonad.ml
	ocamlc -c listMonad.mli
	ocamlc -c listMonad.ml
	ocamlc -c main.ml
	ocamlc listMonad.cmo errorMonad.cmo idMonad.cmo maybeMonad.cmo main.cmo -o main.out

%.cmo: %.ml
	ocamlc -c $^ -o $@

clean:
	rm -rf *.out *.cm*

mrproper: clean
	rm -rf *~

