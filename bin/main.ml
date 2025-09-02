open Turing_load_machine
open Parsing_turing

let () =
  (Array.to_list Sys.argv) |> List.tl |> check_arg 1 |> function 
  | Error -> Info_print.print_error Wrong_args;
  | HelpOption -> Info_print.print_help ();
  | Ok -> Printf.printf "Ok :D\n";
