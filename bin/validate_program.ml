open Program_validation

(* Alphabet validation *)
let validate_alphabet (alphabet : string list) = 
    match check_alphabet_format alphabet with
    | Error msg -> Error msg
    | Ok true ->
        match has_duplicates alphabet with
        | false -> Ok true
        | true -> Error "Alphabet contains duplicate symbols"

let check_states (states : string list) (initial_state : string) (final_states : string list) =
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
                | true -> Ok true