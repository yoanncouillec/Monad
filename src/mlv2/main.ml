let ex1 = IdMonad.run
  (IdMonad.bind (IdMonad.bind (IdMonad.return 0) (fun x ->
  IdMonad.return ((string_of_int x) ^ "0"))) (fun y ->
  IdMonad.return y))

let rec lookup (env:string list) (id:string) : 'a MaybeMonad.m = 
  match env with 
  | x::xs -> if x = id then MaybeMonad.return id else lookup xs id
  | [] -> MaybeMonad.fail
