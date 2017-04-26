# Monad for dummies

If like me you think monad is a pain in the a** to understand, you
would like to understand it with code rather than for ever
explanations.

* **Explore:** We will explore monad in different languages.

* **Create:** We will create our own monad and you will see that it's nothing more than a wrapper...

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
    putStrLn ("Hey " ++ name ++ ", you rock!")
```

## License

Monad is made under the terms of the MIT license.
