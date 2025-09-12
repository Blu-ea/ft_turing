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
            | [] -> Ok true
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