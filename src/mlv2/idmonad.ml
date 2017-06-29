module type IDMONAD = sig
  type 'a m
  val bind: 'a m -> ('a -> 'b m) -> 'b m
  val return: 'a -> 'a m
  val run: 'a m -> 'a
end

module IdMonad:IDMONAD = struct
  type 'a m = IdMonad of 'a
  let bind = fun (IdMonad a) -> fun (f:'a-> 'b m) -> f a
  let return = fun n -> IdMonad n
  let run = fun (IdMonad n) -> n
end

module IdMonadEssence = (IdMonad:MONAD)

let ex1 = IdMonad.run
  (IdMonad.bind (IdMonad.bind (IdMonad.return 0) (fun x ->
  IdMonad.return ((string_of_int x) ^ "0"))) (fun y ->
  IdMonad.return y))
