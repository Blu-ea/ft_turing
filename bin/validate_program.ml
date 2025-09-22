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


(*
    Check the validity of the tape
    Return Ok if the tape is valid, Error with message otherwise
*)
let validate_tape (tape : string) (alphabet : string list) =
    let tape_chars = List.init (String.length tape) (String.get tape) in
    let tape_strs = List.map (String.make 1) tape_chars in
    if list_in_list tape_strs alphabet then
        Ok ()
    else
        Error "Tape contains symbols not present in the alphabet"
