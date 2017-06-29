type 'a m
val empty: 'a m
val return: 'a -> 'a m
val bind: 'a m -> ('a -> 'b m) -> 'b m
val run: 'a m -> 'a
val map: ('a -> 'b m) -> 'a m -> 'b m m
val append: 'a m -> 'a m -> 'a m
val foldr: ('a -> 'b -> 'b) -> 'a m -> 'b -> 'b
val concat: 'a m m -> 'a m
val duplicate: 'a -> 'a m
val replicate: int -> 'a -> 'a m
val string_of_monad: ('a -> string) -> 'a m -> string
val show: ('a -> string) -> 'a m -> unit
val (>>=): 'a m -> ('a -> 'b m) -> 'b m
