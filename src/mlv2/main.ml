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

let err = ErrorMonad.run
  (ErrorMonad.bind (ErrorMonad.bind (ErrorMonad.return 1) (fun x ->
   (divide x x))) (fun y ->
   ErrorMonad.return y))

let list = ListMonad.show (fun x -> x)
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
  (match err with _ as n -> print_endline (string_of_int n));
  print_endline list
			   
