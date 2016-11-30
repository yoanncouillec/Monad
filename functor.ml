type 'a mylist = 
  | MyList of 'a * 'a mylist
  | MyEmptyList
 
let rec myfoldr f i = function
  | MyList (hd, rest) -> myfoldr f (f hd i) rest
  | MyEmptyList -> i

module type MYMONOID = sig
  type m
  val mempty: m
  val mappend: m -> m -> m
  val mconcat: m mylist -> m
end

module type MYFUNCTOR = sig
  type 'a f
  val myfmap: ('a -> 'b) -> 'a f -> 'b f
end

module type MYAPPLICATIVE = sig
  type 'a f
  val mypure: 'a -> 'a f
  val myamap: ('a -> 'b) f -> 'a f -> 'b f
end

module type MYMONAD = sig
  type 'a m
  val return: 'a -> 'a m
  val bind: 'a m -> ('a -> 'b m) -> 'b m
  val run: 'a m -> 'a
  val pass: 'a m -> 'b m -> 'b m
end

module MyList = struct
  type 'a f = 'a list

  let mempty = MyEmptyList
		 
  let rec mappend l1 l2 =
    match l1 with
    | MyList (hd, rest) -> mappend rest (MyList (hd, l2))
    | MyEmptyList -> l2

  let rec mconcat = myfoldr (fun x i -> mappend i x) MyEmptyList

  let rec myfmap f = function
    | MyList (hd, rest) -> MyList ((f hd), (myfmap f rest))
    | MyEmptyList -> MyEmptyList

  let mypure x = MyList (x, MyEmptyList)

  let rec myamap fs l =
    match fs with
    | MyList (f, rest) -> mappend (myfmap f l) (myamap rest l)
    | MyEmptyList -> MyEmptyList

  let return = mypure
		 
  let bind xs f = mconcat (myfmap f xs)

  (*let run = function 
    | MyList (x, rest) -> x *)

  let pass x y = bind x (fun _ -> y)

end

module State = struct
  type 'a mon = string mylist -> 'a * string mylist
  let return x = fun v -> (x, v)
  let bind x f = fun v -> let (x', v') = x v in f x' v'
end
