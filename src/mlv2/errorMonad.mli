type e
type 'a m
val bind: 'a m -> ('a -> 'b m) -> 'b m
val return: 'a -> 'a m
val throw: e -> 'a m
val catch: 'a m -> (e -> 'a m) -> 'a m
val error: 'a m
val error_message: string -> 'a m
val run: 'a m -> 'a
