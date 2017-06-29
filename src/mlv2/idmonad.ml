type 'a m = IdMonad of 'a
let bind = fun (IdMonad a) -> fun (f:'a-> 'b m) -> f a
let return = fun n -> IdMonad n
let run = fun (IdMonad n) -> n
