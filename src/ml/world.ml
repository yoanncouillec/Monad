type screen = string list
type keyboard = string list
type world = screen * keyboard
type 'a io = world -> ('a * world)

let getChar : string io = function
  | (c::input, output) -> (c, (input, output))
  | ([], _) -> failwith "empty input"
			      
let putChar (c:string) : unit io = function
  | (input, output) -> ((), (input, c::output))

let addInt (a:int) (b:int) : int io = function
  | (input, output) -> (a+b, (input, output))

let return (a:'a) : 'a io = function
  | (_, _) as w -> (a, w)
  
let bind (f:'a io) (g:'a -> 'b io) : 'b io = 
  fun world -> let (v, world') = f world in g v world'

let run (m: 'a io) w : 'a = 
  fst (m w)

let main : unit io = 
  bind (getChar)
       (fun x -> bind (putChar x) 
		      (fun _ -> return ()))

let main2 : int io = 
  bind (addInt 1 2)
       (fun x -> bind (addInt x 3)
		      (fun y -> return y))

let readImpure : string io =
  fun rw -> (read_line(), rw)

let printImpure (c:string) : unit io =
    fun rw -> let _ = print_string(c) in ((), rw)

let concat (s1:string) (s2:string) : string io = 
  fun rw -> (s1^s2, rw)

let main3 : unit io = 
  bind (printImpure "What is your name? ")
       (fun _ -> 
	bind readImpure
	     (fun name ->
	      bind (concat "Your name is " name)
		   (fun s -> 
		    bind (concat s "\n")
			 (fun t -> 
			  bind (printImpure t)
			       (fun _ -> return ())))))

let _ = 
  run main3 ([],[])
