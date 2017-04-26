type 'a list = 
  | List of 'a * 'a list
  | EmptyList
 
let rec foldr f i = function
  | List (hd, rest) -> foldr f (f hd i) rest
  | EmptyList -> i

module type MONAD = sig
  type 'a m
  val return: 'a -> 'a m
  val bind: 'a m -> ('a -> 'b m) -> 'b m
  val run: 'a m -> 'a
  val pass: 'a m -> 'b m -> 'b m
end

module MonadList : MONAD = struct
  type 'a m = 'a list

  let mempty = EmptyList
		 
  let rec mappend l1 l2 =
    match l1 with
    | List (hd, rest) -> mappend rest (List (hd, l2))
    | EmptyList -> l2

  let rec mconcat l = foldr (fun x i -> mappend i x) EmptyList l

  let rec fmap f = function
    | List (hd, rest) -> List ((f hd), (fmap f rest))
    | EmptyList -> EmptyList

  let pure x = List (x, EmptyList)

  let rec amap fs l =
    match fs with
    | List (f, rest) -> mappend (fmap f l) (amap rest l)
    | EmptyList -> EmptyList

  let return = pure
		 
  let bind xs f = mconcat (fmap f xs)

  let run = function 
    | List (x, rest) -> x
    | EmptyList -> failwith "empty"

  let pass x y = bind x (fun _ -> y)

end
