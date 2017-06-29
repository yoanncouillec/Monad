type 'a m = MaybeMonadNothing | MaybeMonadValue of 'a
let bind = fun m -> fun (f:'a-> 'b m) -> match m with MaybeMonadNothing -> MaybeMonadNothing 
                                                    | MaybeMonadValue v -> f v
let return = fun n -> MaybeMonadValue n
let fail = MaybeMonadNothing
