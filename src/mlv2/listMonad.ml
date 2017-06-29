type 'a m = ListMonadEmpty | ListMonadValue of 'a * 'a m
let empty = ListMonadEmpty
let return = fun x -> ListMonadValue (x, ListMonadEmpty)
let rec foldr = fun (f: 'a -> 'b -> 'b) -> fun (m:'a m) -> fun (b:'b) ->
			 match m with 
			 | ListMonadEmpty -> b
			 | ListMonadValue (a, ax) -> foldr f ax (f a b)
let rec append = fun (m1:'a m) -> fun (m2:'a m) ->
			   match m1 with
			       | ListMonadEmpty -> m2
			       | ListMonadValue (x,xs) -> ListMonadValue (x, append xs m2) 
let rec map = fun (f:'a -> 'b m) -> fun (m: 'a m) ->
		       match m with 
		       | ListMonadEmpty -> ListMonadEmpty 
		       | ListMonadValue (x,xs) -> ListMonadValue (f x, map f xs)
let rec concat = fun (m:'a m) -> foldr (fun a -> fun b -> append a b) m ListMonadEmpty
let bind = fun (m: 'a m) -> fun (f:'a -> 'b m) -> concat (map f m)
let run = function ListMonadValue (x, _) -> x | _ -> failwith "run: expect a value"
let rec duplicate = fun a -> ListMonadValue (a, ListMonadValue (a, ListMonadEmpty))
let rec replicate =  fun n -> fun a ->
			      match n with
			      | 0 -> ListMonadEmpty
			      | n -> ListMonadValue (a, replicate (n-1) a)
let rec string_of_monad = fun f -> fun m ->
				   match m with 
				   | ListMonadEmpty -> ""
				   | ListMonadValue (x, xs) -> (f x)^(string_of_monad f xs)
					    
let show = fun f -> fun m -> print_endline (string_of_monad f m)
