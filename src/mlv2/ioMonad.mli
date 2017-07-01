type 'a m
val return: 'a -> 'a m
val bind: 'a m -> ('a -> 'b m) -> 'b m
val run: 'a m -> 'a
val (>>=): 'a m -> ('a -> 'b m) -> 'b m

val getLine: unit -> string m
val put: string -> unit m
