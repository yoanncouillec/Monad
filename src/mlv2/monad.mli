type 'a m
val bind: 'a m -> ('a -> 'b m) -> 'b m
val return: 'a -> 'a m
