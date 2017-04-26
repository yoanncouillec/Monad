import System.IO
main =
    putStrLn "Hello, what's your name?" >>
    getLine >>= \ name ->
    putStrLn "Your age?" >>
    getLine >>= \ age ->
    putStrLn ("Hey " ++ name ++ ", you rock at " ++ age ++ "!") >>
    return 0

