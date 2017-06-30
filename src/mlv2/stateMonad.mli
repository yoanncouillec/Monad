type 'a m
val return: 'a -> 'a m
val bind: 'a m -> ('a -> 'b m) -> 'b m
val run: 'a m -> 'a
val getState: 'a m -> int
val (>>=): 'a m -> ('a -> 'b m) -> 'b m
val double: int -> int m
val tostring: ('a -> 'b) -> 'a -> 'b m

