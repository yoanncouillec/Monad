class realworld =
object (self)
  method read ()  =
    read_line()
  method print (c:string) =
    let _ = print_string c in
    ((), self)
end

type 'a io = realworld -> ('a * realworld)

let return (a:'a) : 'a io = 
  fun w -> (a, w)
  
let bind (f:'a io) (g:'a -> 'b io) : 'b io = 
  fun world -> let (v, world') = f world in g v world'

let run (m: 'a io) w : 'a = 
  fst (m w)


let readImpure : string io =
  fun rw -> let s = rw#read() in (s, rw)

let printImpure (c:string) : unit io =
  fun rw -> rw#print(c)

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
  run main3 (new realworld)
