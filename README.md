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
    putStrLn ("Hey " ++ name ++ ", you rock at " ++ age ++ !")
    return 0
```

You think this Haskell code does the same thing as the following C code?

```c
#include <stdio.h>
int main() {
    printf("Hello, what's your name?\n");
    char name[16]; scanf("%s", name);
    printf("Your age?\n");
    int age; scanf("%d", &age);
    printf("Hey %s, you rock at %d!\n", name, age);
    return 0;
}
```

After knowing what a monad is and how it works you will be convinced that those
two codes have absolutely nothing in common.

### What happened in Haskell?

The ```do``` notation, the assignement and the ```return``` are all
implemented with a monad.

## License

Monad is made under the terms of the MIT license.
