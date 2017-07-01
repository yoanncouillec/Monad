type s = int
type 'a m = StateMonad of (s -> 'a * s)

let return = fun x -> StateMonad (fun n -> (x, n))
let bind = fun (StateMonad fstate: 'a m) -> fun (f:'a -> 'b m) ->
					    StateMonad (fun s -> 
							(match fstate s with
							  (v, s') -> 
							   (match f v with
							      StateMonad fstate' ->
							      fstate' (s' + 1))))
let run = fun (StateMonad fstate) -> fst (fstate 0)
let getState = fun (StateMonad fstate) -> snd (fstate 0)
let (>>=) = bind
let double = fun n -> StateMonad (fun s -> (n*2, s))
let tostring = fun f -> fun a -> StateMonad (fun s -> (f a, s))
