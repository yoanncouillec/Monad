type 'a list = 
  | List of 'a * 'a list
  | EmptyList
 
let rec foldr f i = function
  | List (hd, rest) -> foldr f (f hd i) rest
  | EmptyList -> i

module type FUNCTOR = sig
  type 'a f
  val fmap: ('a -> 'b) -> 'a f -> 'b f
end

module type APPLICATIVE = sig
  type 'a f
  val pure: 'a -> 'a f
  val amap: ('a -> 'b) f -> 'a f -> 'b f
end

module ListApplicative : APPLICATIVE = struct
  type 'a f = 'a list

  let pure e = List (e, EmptyList)

  let rec mappend l1 l2 =
    match l1 with
    | List (hd, rest) -> mappend rest (List (hd, l2))
    | EmptyList -> l2

  let rec fmap f = function
    | List (hd, rest) -> List ((f hd), (fmap f rest))
    | EmptyList -> EmptyList

  let rec amap fs l =
    match fs with
    | List (f, rest) -> mappend (fmap f l) (amap rest l)
    | EmptyList -> EmptyList
end
