type world = int
type 'a action = world -> ('a * world)
type ('a, 'b) action_input = ('a * world) -> ('b * world)

let bind a1 a2 w0 =
    match a1 w0 with
    | (_, w1) -> a2 w1

let bindeq a1 a2 w0 = 
    match a1 w0 with
    | (x, w1) -> a2 x w1

let read w0 = 
  (read_line(), w0+1)

let print s w0 = 
  print_endline s ;
  (s, w0 + 1)

(*******************************************************)

module type MONAD = sig
  type 'a mon
  val bind: 'a mon -> 'b mon -> 'b mon
  val bindeq: 'a mon -> ('a -> 'b mon) -> 'b mon
end

module Io = struct
  let bind m1 m2 w0 = 
    match m1 w0 with
    | (_,w1) -> m2 w1
  let bindeq m1 m2 w0 = 
    match m1 w0 with
    | (x, w1) -> m2 x w1
end

let read2 w = 
  (read_line(), w+1)

let print2 s w = 
  print_endline s ;
  (s, w+1)

let _ = 
  let w = 0 in
  Io.bindeq
    (fun w ->  Io.bind (fun w -> print2 "Your name ?" w) read2 w)
    (fun a w ->
      Io.bindeq
	(fun w -> Io.bind (fun w -> print2 "How old?" w) read2 w)
	(fun b w -> ((a, b), w))
	w)
    w

(* let _ = *)
(*   let w = 0 in *)
(*   bindeq *)
(*     (fun w -> bind (fun w -> print "What is your name?" w) read w) *)
(*     (fun a w ->  *)
(*       bindeq  *)
(* 	(fun w -> bind (fun w -> print "How old are you?" w) read w) *)
(* 	(fun b w -> ((a, b), w)) *)
(* 	w) *)
(*     w ; *)
