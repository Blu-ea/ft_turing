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
    Check if a string is in a list of strings
    Return true if the string is present in the list, false otherwise
*)
let rec string_in_list (s : string) (str_list : string list) =
    match str_list with
    | [] -> false
    | head::tail -> if head = s then true else string_in_list s tail


(*
    Check if all elements of a list are present in a second list
    Return true if all elements are present of list1 are present in list2, false otherwise
*)
let rec list_in_list (list1 : string list) (list2 : string list) =
    match list1 with
    | [] -> true
    | head::tail -> if string_in_list head list2 then list_in_list tail list2 else false


(*
    Check the validity of the alphabet
    Return Ok if the alphabet is valid, Error with message otherwise
*)
let validate_alphabet (alphabet : string list) = 
    match check_alphabet_format alphabet with
    | Error msg -> Error msg
    | Ok () ->
        match has_duplicates alphabet with
        | false -> Ok true
        | true -> Error "Alphabet contains duplicate symbols"


(*
    Check the validity of the states
    Return Ok if the states are valid, Error with message otherwise
*)
let check_states_names (states : string list) (initial_state : string) (final_states : string list) =
    match has_duplicates states with
    | false -> Error "States contain duplicate names"
    | true ->
        match string_in_list initial_state states with
        | false -> Error "Initial state is not in the list of states"
        | true ->
            match has_duplicates final_states with
            | true -> Error "Final states contain duplicate names"
            | false ->
                match list_in_list final_states states with
                | false -> Error "Some final states are not in the list of states"
                | true -> Ok ()

(*
    Check the validity of a transition
    Return Ok if the transition is valid, Error with message otherwise
*)
let check_transition (transition : Program_type.Transition.t) (states : string list) (alphabet : string list) =
    if string_in_list transition.read alphabet == false then
        Error ("Transition read symbol " ^ transition.read ^ " is not in the alphabet")
    else if string_in_list transition.write alphabet == false then
        Error ("Transition write symbol " ^ transition.write ^ " is not in the alphabet")
    else if string_in_list transition.to_state states == false then
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
    Check the validity of all states in the program
    Return Ok if all states are valid, Error with message otherwise
*)
let check_program_states (transistion : Program_type.Transitions.t) (states : string list) (alphabet : string list) =
    let all_transitions = Program_type.Transitions.M.bindings transistion in
    check_transition_list (List.flatten (List.map snd all_transitions)) states alphabet
