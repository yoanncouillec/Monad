module type MAYBEMONAD = sig
  type 'a m
  val bind: 'a m -> ('a -> 'b m) -> 'b m
  val return: 'a -> 'a m
  val fail: 'a m
end

module MaybeMonad:MAYBEMONAD = struct
  type 'a m = MaybeMonadNothing | MaybeMonadValue of 'a
  let bind = fun m -> fun (f:'a-> 'b m) -> match m with MaybeMonadNothing -> MaybeMonadNothing 
                                                      | MaybeMonadValue v -> f v
  let return = fun n -> MaybeMonadValue n
  let fail = MaybeMonadNothing
end

let rec lookup (env:string list) (id:string) : 'a MaybeMonad.m = 
  match env with 
  | x::xs -> if x = id then MaybeMonad.return id else lookup xs id
  | [] -> MaybeMonad.fail

module MaybeMonadEssence = (MaybeMonad:MONAD)
