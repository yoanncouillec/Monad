let monoid_example = 
  let g = fun a -> a in
  let f = fun a -> a in
  let composition f g = fun a -> f (g a) in
  composition f g 12

type 'a idmonad = IdMonad of 'a

let bind = fun (IdMonad a) -> fun (f:'a-> 'b idmonad) -> f a
let return = fun n -> IdMonad n
let run = fun (IdMonad a) -> a
let id_monad_example = 
  let (g:'a->'b idmonad) = fun a -> IdMonad a in
  let (f:'b->'c idmonad) = fun a -> IdMonad a in
  run (bind (g 12) f)

let number = return
let concat = fun s1 -> fun s2 -> IdMonad (s1^s2)
let add = fun a1 -> fun a2 -> IdMonad (a1 + a2)

let id_monad_example2 = 
 bind (bind (bind (number 0) (fun x -> 
 concat "1" (string_of_int x))) (fun y ->
 add (int_of_string y) 1)) (fun z ->
 return z)

module type MONAD = sig
  type 'a m
  val bind: 'a m -> ('a -> 'b m) -> 'b m
  val return: 'a -> 'a m
end

module IDMONAD:MONAD = struct
  type 'a m = IdMonad of 'a
  let bind = fun (IdMonad a) -> fun (f:'a-> 'b m) -> f a
  let return = fun n -> IdMonad n
  let run = fun (IdMonad n) -> n
end

let id_monad_example3 = 
  IDMONAD.bind (IDMONAD.return 0) (fun x ->
  IDMONAD.return x)

let _ =
  print_endline (string_of_int (run id_monad_example2));
  

