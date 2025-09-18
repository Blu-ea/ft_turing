open Parsing_turing
open Turing_load_machine
open Validate_program
open Run_machine
open Program_type

let () =
  (Array.to_list Sys.argv) |> List.tl |> check_arg 1 |> function 
  | Error -> Info_print.print_error Wrong_args;
  | HelpOption -> Info_print.print_help ();
  | Ok -> 
      match get_program_from_file Sys.argv.(1) with
      | Error str -> Printf.printf "%s" str; exit 1
      | Ok prog -> 
          match Validate_program.validate_program prog with
          | Error str -> Printf.printf "%s" str; exit 1
          | Ok () -> 
              Program.print_description prog;
              let tape = Sys.argv.(2) in
              match Run_machine.run_transition_loop prog tape 0 (Program.initial prog) with
              | Error str -> Printf.printf "%s" str; exit 1
              | Ok final_tape -> exit 0
