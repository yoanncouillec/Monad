# Monad for dummies

If like me you think monad is a pain in the a** to understand, you
would like to understand it with code rather than with "for ever"
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
    putStrLn ("Hey " ++ name ++ ", you rock at " ++ age ++ !")
```

You think this Haskell code does the same thing as the following C code?

```c
void main() {
    printf("Hello, what's your name?\n");
    char name[16]; scanf("%s", name);
    printf("Your age?\n");
    int age; scanf("%d", &age);
    printf("Hey %s, you rock at %d!\n", name, age);
}
```

After knowing what a monad is and how it works you will be convinced that those
two codes have absolutely nothing in common.

## License

Monad is made under the terms of the MIT license.
