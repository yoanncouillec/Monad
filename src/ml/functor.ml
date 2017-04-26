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

module ListFunctor : FUNCTOR = struct
  type 'a f = 'a list
  let rec fmap f = function
    | List (hd, rest) -> List ((f hd), (fmap f rest))
    | EmptyList -> EmptyList
end

type 'a tree = 
  | Leaf of 'a
  | Branch of 'a tree * 'a tree

module TreeFunctor : FUNCTOR = struct
  type 'a f = 'a tree
  let rec fmap f = function
    | Branch (l, r) -> Branch ((fmap f l), (fmap f r))
    | Leaf e -> Leaf (f e)
end

type 'a maybe =
  | Just of 'a
  | Nothing

module MaybeFunctor : FUNCTOR = struct
  type 'a f = 'a maybe
  let rec fmap f = function
    | Just e -> Just (f e)
    | Nothing -> Nothing
end
