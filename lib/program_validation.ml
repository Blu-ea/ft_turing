(*
    Check if alphabet is not empty and is a list of strings, each one of size 1
    Return Ok if true, Error with message if false
*)
let check_alphabet_format (alphabet : string list) = 
    match alphabet with
    | [] -> Error "Alphabet is empty"
    | _ ->
        let rec check_all_str_size (str_list : string list) =
            match str_list with
            | [] -> Ok ()
            | head::tail ->
                if String.length head = 1 then
                    check_all_str_size tail
                else
                    Error ("Alphabet contains invalid symbol: " ^ head)
        in
        check_all_str_size alphabet


(* 
    Check if a string list contain duplicate
    Return true if duplicates are found, false otherwise
*)
let rec has_duplicates (str_list : string list) =
    match str_list with
    | [] -> false
    | head::tail ->
        if List.mem head tail then
            true
        else
            has_duplicates tail

(*
    Check if all elements of a list are present in a second list
    Return true if all elements are present of list1 are present in list2, false otherwise
*)
let list_in_list (needles : string list) (haystack : string list) =
    List.for_all (fun needle -> List.mem needle haystack) needles

(*
    Check the validity of the alphabet
    Return Ok if the alphabet is valid, Error with message otherwise
*)
let validate_alphabet (alphabet : string list) = 
    match check_alphabet_format alphabet with
    | Error msg -> Error msg
    | Ok () ->
        match has_duplicates alphabet with
        | false -> Ok ()
        | true -> Error "Alphabet contains duplicate symbols"


(*
    Check the validity of the states
    Return Ok if the states are valid, Error with message otherwise
*)
let check_states_names (states : string list) (initial_state : string) (final_states : string list) =
    if List.length states == 0 then
        Error ("States list is empty")
    else if List.length final_states == 0 then
        Error ("Final states list is empty")
    else if String.length initial_state == 0 then 
        Error ("Initial state is empty")
    else if has_duplicates states then 
        Error ("States contain duplicate names")
    else if not (List.mem initial_state states) then 
        Error ("Initial state " ^ initial_state ^ " is not in the list of states")
    else if has_duplicates final_states then 
        Error ("Final states contain duplicate names")
    else if not (list_in_list final_states states) then 
        Error ("Some final states are not in the list of states")
    else
        Ok ()

(*
    Check the validity of a transition
    Return Ok if the transition is valid, Error with message otherwise
*)
let check_transition (transition : Program_type.Transition.t) (states : string list) (alphabet : string list) =
    if List.mem transition.read alphabet == false then
        Error ("Transition read symbol " ^ transition.read ^ " is not in the alphabet")
    else if List.mem transition.write alphabet == false then
        Error ("Transition write symbol " ^ transition.write ^ " is not in the alphabet")
    else if List.mem transition.to_state states == false then
        Error ("Transition to_state " ^ transition.to_state ^ " is not in the list of states")
    else
        Ok ()

(*
    Check the validity of a list of transitions
    Return Ok if list is not empty and all transitions are valid, Error with message otherwise
*)
let check_transition_list (transitions : Program_type.Transition.t list) (states : string list) (alphabet : string list) =
    match transitions with
    | [] -> Error "No transitions defined"
    | _ ->
        let rec check_all_transitions transitions =
            match transitions with
            | [] -> Ok ()
            | head::tail ->
                match check_transition head states alphabet with
                | Error msg -> Error msg
                | Ok () -> check_all_transitions tail
        in
            check_all_transitions transitions

(*
    Check the validity of all states and transition in the program
    Return Ok if all states are valid, Error with message otherwise
*)
let check_program_transitions (transistion : Program_type.Transitions.t) (states : string list) (alphabet : string list) =
    let all_transitions = Program_type.Transitions.M.bindings transistion in
    let keys = List.map fst all_transitions in
    if not (list_in_list keys states) then
        Error "A machine state is not in the list of states"
    else
        check_transition_list (List.flatten (List.map snd all_transitions)) states alphabet
