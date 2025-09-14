open Program_validation
open Program_type

(*
    Check the validity of the entire program
    Return Ok if the program is valid, Error with message otherwise
*)
let validate_program (program : Program.t) =
    if String.length program.name == 0 then Error "The program name is empty"
    else
        match validate_alphabet program.alphabet with
        | Error msg -> Error msg
        | Ok () ->
            match List.mem program.blank program.alphabet with
            | false -> Error ("Blank symbol " ^ program.blank ^ " is not in the alphabet")
            | true ->
                match check_states_names program.states program.initial program.finals with
                | Error msg -> Error msg
                | Ok () ->
                    check_program_transitions program.transitions program.states program.alphabet
