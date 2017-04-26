type 'a list = 
  | List of 'a * 'a list
  | EmptyList
 
let rec foldr f i = function
  | List (hd, rest) -> foldr f (f hd i) rest
  | EmptyList -> i

module type MONOID = sig
  type 'a m
  val mempty: 'a m
  val mappend: 'a m -> 'a m -> 'a m
  val mconcat: ('a m) list -> 'a m
end

module ListMonoid : MONOID = struct
  type 'a m = 'a list
  let mempty = EmptyList
		 
  let rec mappend l1 l2 =
    match l1 with
    | List (hd, rest) -> mappend rest (List (hd, l2))
    | EmptyList -> l2

  let rec mconcat l = foldr (fun x i -> mappend i x) EmptyList l
end

module AddMonoid : MONOID = struct
  type 'a m = int
  let mempty = 0
  let mappend n1 n2 = n1 + n2
  let rec mconcat l = foldr (fun e acc -> mappend acc e) 0 l
end

module MulMonoid : MONOID = struct
  type 'a m = int
  let mempty = 1
  let mappend n1 n2 = n1 * n2
  let rec mconcat l = foldr (fun e acc -> mappend acc e) 1 l
end
