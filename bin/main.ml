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
        | Error str -> Printf.printf "%s\n" str; exit 1
        | Ok prog -> 
            match Validate_program.validate_program prog with
            | Error str -> Printf.printf "%s\n" str; exit 1
            | Ok () -> 
                let tape =
                    if String.length (Sys.argv.(2)) < 20 then
                        (Sys.argv.(2)) ^ String.make (20 - String.length (Sys.argv.(2))) (Program.blank prog).[0]
                    else
                        (Sys.argv.(2))
                in
                match Validate_program.validate_tape tape (Program.alphabet prog) with
                | Error str -> Printf.printf "%s\n" str; exit 1
                | Ok () ->
                    Program.print_description prog;
                    match Run_machine.run_transition_loop prog tape 0 (Program.initial prog) with
                    | Error str -> Printf.printf "%s\n" str; exit 1
                    | Ok final_tape -> 
                        Printf.printf "[%s]\n" final_tape;
                        exit 0
