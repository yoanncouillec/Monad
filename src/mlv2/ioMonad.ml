type 'a m = IoMonad of 'a
let return = fun x -> IoMonad x
let bind = fun (IoMonad x: 'a m) -> fun (f:'a -> 'b m) -> f x
let run = fun (IoMonad x) -> x
let getLine = fun () -> IoMonad(read_line())
let put = fun s -> IoMonad(print_string s)
let (>>=) = bind
