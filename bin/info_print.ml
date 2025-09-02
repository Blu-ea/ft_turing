open Printf

type error_type = 
  | Wrong_args

let print_error error = 
  eprintf "Ft_turring: Error: %s\n" (
    match error with 
    | Wrong_args -> "Wrong input - use `-h` to see usage."
    );
    exit 1


let print_help () = printf 
"Usage :
  ft_turing [-h] jsonfile input


Positionnal arguments:
 - jsonfile     : Json file that describe the states of the machine

 - input        : The input tape of the machine


Optional arguements:
    -h, --help  : Show this help
"