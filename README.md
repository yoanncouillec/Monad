# Monad for dummies

If like me you think monad is a pain in the a** to understand, you
would like to understand it with code rather than with "for ever"
explanations.

* **Explore:** monad in different languages.

* **Create:** our own monad and see it's like a wrapper for a context.

## Quick start

### Haskell or using monads without knowing it

* Go into `src/hs` and compile with `make` to generate the binary

Here is the code:

```haskell
main = do  
    putStrLn "Hello, what's your name?"  
    name <- getLine  
    putStrLn "Your age?"  
    age <- getLine  
    putStrLn ("Hey " ++ name ++ ", you rock at " ++ age ++ "!")
    return 0
```

You think this Haskell code does the same thing than the following C code?

```c
int main() {
    printf("Hello, what's your name?\n");
    char name[16]; scanf("%s", name);
    printf("Your age?\n");
    int age; scanf("%d", &age);
    printf("Hey %s, you rock at %d!\n", name, age);
    return 0;
}
```

After knowing what a monad is and how it works, you will be convinced that those
two codes have absolutely nothing in common.

### What happened in Haskell?

The ```do``` notation, assignement ```<-``` and ```return``` are all
implemented with monads. In other words, this is syntactic sugar.

```haskell
main =
    putStrLn "Hello, what's your name?" >>= \_ ->
    getLine  >>= \ name ->
    putStrLn "Your age?"   >>= \ _ ->
    getLine >>= \ age ->
    putStrLn ("Hey " ++ name ++ ", you rock at " ++ age ++ "!") >>
    return 0
```

Got it? Welcome to functional programming :)

You have noticed that ```return``` has not been desugared. Its type is
```Integer -> IO Integer``` here.

The IO monad is the way to communicate with the real world in a pure
functional programming language like Haskell.

### Back to comparison with C

* Sequence: is an ordered set of instructions. For instance:

```c
int c = 3 ; printf("%d\n",c) ; return c ;
```

The same in Haskell is:

```haskell
return 3 >>= \ c -> putStrLn(show c) >> return c
```

A sequence of instructions in C is equivalent to an expression in
Haskell.

Here, we are touching the basic, and very important, differences
between imperative programming and functional programming.

## License

Monad is made under the terms of the MIT license.
