type e = Error | ErrorMessage of string
type 'a m = ErrorMonadValue of 'a | ErrorMonadError of e
let bind = fun m -> fun (f:'a-> 'b m) -> match m with ErrorMonadValue a -> f a
						    | ErrorMonadError e -> ErrorMonadError e
let return = fun n -> ErrorMonadValue n
let throw = fun e -> ErrorMonadError e
let catch = fun m -> fun f -> match m with ErrorMonadValue v -> ErrorMonadValue v
					 | ErrorMonadError e -> f e
let error = throw Error
let error_message s = throw (ErrorMessage s)
let run = fun m -> match m with ErrorMonadValue v -> v
			      | ErrorMonadError e -> (match e with Error -> failwith "Error"
								 | ErrorMessage s -> failwith s)
let string_of_error = function Error -> "Error" | ErrorMessage s -> "Error: "^s
let string_of_monad = fun f -> fun m ->
			       match m with
			       | ErrorMonadValue v -> f v
			       | ErrorMonadError e -> string_of_error e
let show = fun f -> fun m -> print_endline (string_of_monad f m)
