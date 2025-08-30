let rec fibo = function 
    | 0 -> 0
    | 1 -> 1
    | x -> fibo (x - 1) + fibo (x - 2)
