main =
    return 3 >>= \ c -> putStrLn(show c) >> return c


