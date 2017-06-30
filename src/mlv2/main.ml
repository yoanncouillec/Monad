let ex1 = IdMonad.run
  (IdMonad.bind (IdMonad.bind (IdMonad.return 0) (fun x ->
  IdMonad.return ((string_of_int x) ^ "0"))) (fun y ->
  IdMonad.return y))

let rec lookup (env:string list) (id:string) : 'a MaybeMonad.m = 
  match env with 
  | x::xs -> if x = id then MaybeMonad.return id else lookup xs id
  | [] -> MaybeMonad.fail

let divide (a:int) (b:int) : 'a ErrorMonad.m =
  match b with
  | 0 -> ErrorMonad.error_message "Division by 0"
  | _ -> ErrorMonad.return (a/b)

let _ = 
  ErrorMonad.show string_of_int
  (ErrorMonad.bind (ErrorMonad.bind (ErrorMonad.return 1) (fun x ->
   (divide x x))) (fun y ->
   ErrorMonad.return y))

let _ =
  ListMonad.show (fun x -> x)
  (ListMonad.bind 
  (ListMonad.bind 
  (ListMonad.bind 
  (ListMonad.bind 
  (ListMonad.return "bunny") (fun x -> 
   ListMonad.duplicate x)) (fun y ->
   ListMonad.replicate 3 y)) (fun z ->
   ListMonad.replicate 4 z)) (fun t ->
   ListMonad.return t))

let _ =
  let (>>=) = ListMonad.(>>=) in
  let return = ListMonad.return in
  let show = ListMonad.show (fun x -> x) in
  let duplicate = ListMonad.duplicate in
  let replicate = ListMonad.replicate in
  let result =
    ((return "duck") >>= (fun x -> 
      duplicate x) >>= (fun y ->
      replicate 3 y) >>= (fun z ->
      return z)) 
  in show result

let _ = 
  let (>>=) = StateMonad.(>>=) in
  let return = StateMonad.return in
  let double = StateMonad.double in
  let tostring = StateMonad.tostring in
  let run = StateMonad.run in
  let result = run
  (return 4 >>= (fun x -> 
   double x >>= (fun y ->
   tostring string_of_int y >>= (fun z ->
   return z)))) in
  print_endline result
