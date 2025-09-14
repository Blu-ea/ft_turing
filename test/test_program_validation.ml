module To_test = struct
    let check_alphabet_format = Program_validation.check_alphabet_format
    let has_duplicates = Program_validation.has_duplicates
    let string_in_list = Program_validation.string_in_list
    let list_in_list = Program_validation.list_in_list
    let validate_alphabet = Program_validation.validate_alphabet
    let check_states_names = Program_validation.check_states_names
    let check_program_transitions = Program_validation.check_program_transitions
end

(*
    Test check_alphabet_format function
*)
let test_valid_alphabet_format () =
    Alcotest.(check (result unit string)) "same" (Ok ()) (To_test.check_alphabet_format ["a"; "b"; "c"])

let test_invalid_alphabet_format_empty_alphabet () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet is empty") (To_test.check_alphabet_format [])

let test_invalid_alphabet_format_empty_str () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet contains invalid symbol: ") (To_test.check_alphabet_format ["a"; ""; "c"])

let test_invalid_alphabet_format_long_str () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet contains invalid symbol: dd") (To_test.check_alphabet_format ["a"; "dd"; "c"])

(*
    Test has_duplicates function
*)
let test_has_duplicates_true () =
    Alcotest.(check bool) "same bool" true (To_test.has_duplicates ["a"; "b"; "c"; "a"])

let test_has_duplicates_true_long_str () =
    Alcotest.(check bool) "same bool" true (To_test.has_duplicates ["abcdefghijk"; "foobar"; "abcdefghijk"; ""])

let test_has_duplicates_true_empty_str () =
    Alcotest.(check bool) "same bool" true (To_test.has_duplicates ["a"; ""; ""; "b"])

let test_has_duplicates_empty_list () =
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates [])

let test_has_duplicates_false () =
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates ["q0"; "q1"; "q2"; "HALT"])

let test_has_duplicates_single_element () =
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates ["a"])

let test_has_duplicates_false_empty_str () =
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates ["a"; ""; "c"; "d"])

(*
    Test string_in_list function
*)
let test_string_in_list_true () =
    Alcotest.(check bool) "same bool" true (To_test.string_in_list "foobar" ["a"; "b"; "foobar"])

let test_string_in_list_true_empt_string () =
    Alcotest.(check bool) "same bool" true (To_test.string_in_list "" ["a"; ""; "c"])

let test_string_in_list_false () =
    Alcotest.(check bool) "same bool" false (To_test.string_in_list "foobar" ["a"; "b"; "c"])

let test_string_in_list_false_empty_list () =
    Alcotest.(check bool) "same bool" false (To_test.string_in_list "foobar" [])

let test_string_in_list_false_empty_str () =
    Alcotest.(check bool) "same bool" false (To_test.string_in_list "" ["a"; "b"; "c"])

let test_string_in_list_false_empty_str_in_list () =
    Alcotest.(check bool) "same bool" false (To_test.string_in_list "foobar" [""; "b"; "c"])

(*
    Test list_in_list function
*)
let test_list_in_list_true () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list ["a"; "b"] ["a"; "b"; "c"; "d"])

let test_list_in_list_true_long_str () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list ["abcdefghijk"; "foobar"] ["foofghj"; "wdrftbar"; "mplokiju"; "d"; "abcdefghijk"; "foobar"])

let test_list_in_list_true_same_elements () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list ["a"; "b"; "c"; "d"] ["a"; "b"; "c"; "d"])

let test_list_in_list_true_empty_str () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list ["a"; ""] ["a"; "b"; ""; "d"])

let test_list_in_list_true_empty_list () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list [] ["a"; "b"; "c"; "d"])

let test_list_in_list_true_single_element () =
    Alcotest.(check bool) "same bool" true (To_test.list_in_list ["a"] ["a"; "b"; "c"; "d"])

let test_list_in_list_false () =
    Alcotest.(check bool) "same bool" false (To_test.list_in_list ["a"; "e"] ["a"; "b"; "c"; "d"])

let test_list_in_list_false_long_str () =
    Alcotest.(check bool) "same bool" false (To_test.list_in_list ["abcdefghijk"; "foobar"] ["foofghj"; "wdrftbar"; "mplokiju"; "dfghjklm"; "abcdefghijk"])

let test_list_in_list_false_empty_second_list () =
    Alcotest.(check bool) "same bool" false (To_test.list_in_list ["a"; "b"] [])

let test_list_in_list_false_empty_str () =
    Alcotest.(check bool) "same bool" false (To_test.list_in_list ["a"; ""] ["a"; "b"; "c"; "d"])

let test_list_in_list_false_single_element () =
    Alcotest.(check bool) "same bool" false (To_test.list_in_list ["e"] ["a"; "b"; "c"; "d"])

(*
    Test validate_alphabet function
*)
let test_validate_alphabet_valid () =
    Alcotest.(check (result unit string)) "same" (Ok ()) (To_test.validate_alphabet ["a"; "b"; "c"])

let test_validate_alphabet_valid_single_string () =
    Alcotest.(check (result unit string)) "same" (Ok ()) (To_test.validate_alphabet ["a"])

let test_validate_alphabet_invalid_empty_alphabet () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet is empty") (To_test.validate_alphabet [])

let test_validate_alphabet_invalid_duplicate () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet contains duplicate symbols") (To_test.validate_alphabet ["a"; "b"; "c"; "a"])

let test_validate_alphabet_invalid_format () =
    Alcotest.(check (result unit string)) "same" (Error "Alphabet contains invalid symbol: dd") (To_test.validate_alphabet ["a"; "dd"; "c"])

(*
    Test check_states_names function
*)
let test_check_states_names_valid () =
    Alcotest.(check (result unit string)) "same" (Ok ()) (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "q0" ["HALT"; "q2"])

let test_check_states_names_invalid_states_duplicate () =
    Alcotest.(check (result unit string)) "same" (Error "States contain duplicate names") (To_test.check_states_names ["q0"; "q1"; "q2"; "q1"] "q0" ["HALT"; "q2"])

let test_check_states_names_invalid_initial () =
    Alcotest.(check (result unit string)) "same" (Error "Initial state q_start is not in the list of states") (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "q_start" ["HALT"; "q2"])

let test_check_states_names_invalid_final_duplicate () =
    Alcotest.(check (result unit string)) "same" (Error "Final states contain duplicate names") (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "q0" ["HALT"; "q2"; "q2"])

let test_check_states_names_invalid_final_not_in_states () =
    Alcotest.(check (result unit string)) "same" (Error "Some final states are not in the list of states") (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "q0" ["HALT"; "q3"])

let test_check_states_names_invalid_empty_states () =
    Alcotest.(check (result unit string)) "same" (Error "States list is empty") (To_test.check_states_names [] "q0" ["HALT"; "q2"])

let test_check_states_names_invalid_empty_let () =
    Alcotest.(check (result unit string)) "same" (Error "Initial state is empty") (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "" ["HALT"; "q2"])

let test_check_states_names_invalid_empty_final () =
    Alcotest.(check (result unit string)) "same" (Error "Final states list is empty") (To_test.check_states_names ["q0"; "q1"; "q2"; "HALT"] "q0" [])


(*
    Test check_program_transitions function
*)
let test_check_program_transitions_valid () =
    let open Program_type in
    let transitions = Transitions.M.empty
        |> Transitions.M.add "q0" [
            Transition.make "a" "q1" "b" Action.RIGHT;
            Transition.make "b" "q0" "a" Action.LEFT;
        ]
        |> Transitions.M.add "q1" [
            Transition.make "a" "q2" "a" Action.RIGHT;
            Transition.make "b" "q1" "b" Action.RIGHT;
        ]
        |> Transitions.M.add "q2" [
            Transition.make "a" "q0" "a" Action.RIGHT;
            Transition.make "b" "q2" "b" Action.RIGHT;
        ]
    in
    let states = ["q0"; "q1"; "q2"] in
    let alphabet = ["a"; "b"] in
    Alcotest.(check (result unit string)) "same" (Ok ()) (To_test.check_program_transitions transitions states alphabet)

let test_check_program_transitions_invalid_wrong_read () =
    let open Program_type in
    let transitions = Transitions.M.empty
        |> Transitions.M.add "q0" [
            Transition.make "a" "q1" "b" Action.RIGHT;
            Transition.make "b" "q0" "a" Action.LEFT;
        ]
        |> Transitions.M.add "q1" [
            Transition.make "c" "q2" "a" Action.RIGHT;
            Transition.make "b" "q1" "b" Action.RIGHT;
        ]
        |> Transitions.M.add "q2" [
            Transition.make "a" "q0" "a" Action.RIGHT;
            Transition.make "b" "q2" "b" Action.RIGHT;
        ]
    in
    let states = ["q0"; "q1"; "q2"] in
    let alphabet = ["a"; "b"] in
    Alcotest.(check (result unit string)) "same" (Error "Transition read symbol c is not in the alphabet") (To_test.check_program_transitions transitions states alphabet)

let test_check_program_transitions_invalid_wrong_write () =
    let open Program_type in
    let transitions = Transitions.M.empty
        |> Transitions.M.add "q0" [
            Transition.make "a" "q1" "b" Action.RIGHT;
            Transition.make "b" "q0" "a" Action.LEFT;
        ]
        |> Transitions.M.add "q1" [
            Transition.make "a" "q2" "b" Action.RIGHT;
            Transition.make "b" "q1" "b" Action.RIGHT;
        ]
        |> Transitions.M.add "q2" [
            Transition.make "a" "q0" "a" Action.RIGHT;
            Transition.make "b" "q2" "c" Action.RIGHT;
        ]
    in
    let states = ["q0"; "q1"; "q2"] in
    let alphabet = ["a"; "b"] in
    Alcotest.(check (result unit string)) "same" (Error "Transition write symbol c is not in the alphabet") (To_test.check_program_transitions transitions states alphabet)

let test_check_program_transitions_invalid_state_name () =
    let open Program_type in
    let transitions = Transitions.M.empty
        |> Transitions.M.add "q0" [
            Transition.make "a" "q1" "b" Action.RIGHT;
            Transition.make "b" "q0" "a" Action.LEFT;
        ]
        |> Transitions.M.add "q1" [
            Transition.make "a" "q2" "b" Action.RIGHT;
            Transition.make "b" "q1" "b" Action.RIGHT;
        ]
        |> Transitions.M.add "foo" [
            Transition.make "a" "q0" "a" Action.RIGHT;
            Transition.make "b" "q2" "b" Action.RIGHT;
        ]
    in
    let states = ["q0"; "q1"; "q2"] in
    let alphabet = ["a"; "b"] in
    Alcotest.(check (result unit string)) "same" (Error "A machine state is not in the list of states") (To_test.check_program_transitions transitions states alphabet)


(* Run all tests *)
let () =
    Alcotest.run "validate_program"
        [
            ("check alphabet format",
                [
                    Alcotest.test_case "valid alphabet" `Quick test_valid_alphabet_format;
                    Alcotest.test_case "invalid alphabet empty list" `Quick test_invalid_alphabet_format_empty_alphabet;
                    Alcotest.test_case "invalid alphabet empty string" `Quick test_invalid_alphabet_format_empty_str;
                    Alcotest.test_case "invalid alphabet long str" `Quick test_invalid_alphabet_format_long_str;
                ]);
            ("has_duplicates",
                [
                    Alcotest.test_case "has duplicates true" `Quick test_has_duplicates_true;
                    Alcotest.test_case "has duplicates true long str" `Quick test_has_duplicates_true_long_str;
                    Alcotest.test_case "has duplicates true empty str" `Quick test_has_duplicates_true_empty_str;
                    Alcotest.test_case "has duplicates empty list" `Quick test_has_duplicates_empty_list;
                    Alcotest.test_case "has duplicates false" `Quick test_has_duplicates_false;
                    Alcotest.test_case "has duplicates single element" `Quick test_has_duplicates_single_element;
                    Alcotest.test_case "has duplicates false empty str" `Quick test_has_duplicates_false_empty_str;
                ]);
            ("list_in_list", 
                [
                    Alcotest.test_case "list in list true" `Quick test_list_in_list_true;
                    Alcotest.test_case "list in list true long str" `Quick test_list_in_list_true_long_str;
                    Alcotest.test_case "list in list true same elements" `Quick test_list_in_list_true_same_elements;
                    Alcotest.test_case "list in list true empty str" `Quick test_list_in_list_true_empty_str;
                    Alcotest.test_case "list in list true empty list" `Quick test_list_in_list_true_empty_list;
                    Alcotest.test_case "list in list true single element" `Quick test_list_in_list_true_single_element;
                    Alcotest.test_case "list in list false" `Quick test_list_in_list_false;
                    Alcotest.test_case "list in list false long str" `Quick test_list_in_list_false_long_str;
                    Alcotest.test_case "list in list false empty second list" `Quick test_list_in_list_false_empty_second_list;
                    Alcotest.test_case "list in list false empty str" `Quick test_list_in_list_false_empty_str;
                    Alcotest.test_case "list in list false single element" `Quick test_list_in_list_false_single_element;
                ]);
            ("validate_alphabet",
                [
                    Alcotest.test_case "validate alphabet valid" `Quick test_validate_alphabet_valid;
                    Alcotest.test_case "validate alphabet valid single string" `Quick test_validate_alphabet_valid_single_string;
                    Alcotest.test_case "validate alphabet invalid empty alphabet" `Quick test_validate_alphabet_invalid_empty_alphabet;
                    Alcotest.test_case "validate alphabet invalid duplicate" `Quick test_validate_alphabet_invalid_duplicate;
                    Alcotest.test_case "validate alphabet invalid format" `Quick test_validate_alphabet_invalid_format;
                ]);
            ("check_states_names",
                [
                    Alcotest.test_case "check states names valid" `Quick test_check_states_names_valid;
                    Alcotest.test_case "check states names invalid states duplicate" `Quick test_check_states_names_invalid_states_duplicate;
                    Alcotest.test_case "check states names invalid initial" `Quick test_check_states_names_invalid_initial;
                    Alcotest.test_case "check states names invalid final duplicate" `Quick test_check_states_names_invalid_final_duplicate;
                    Alcotest.test_case "check states names invalid final not in states" `Quick test_check_states_names_invalid_final_not_in_states;
                    Alcotest.test_case "check states names invalid empty states" `Quick test_check_states_names_invalid_empty_states;
                    Alcotest.test_case "check states names invalid empty initial" `Quick test_check_states_names_invalid_empty_let;
                    Alcotest.test_case "check states names invalid empty final" `Quick test_check_states_names_invalid_empty_final;
                ]);
            ("check_program_transitions",
                [
                    Alcotest.test_case "check program transitions valid" `Quick test_check_program_transitions_valid;
                    Alcotest.test_case "check program transitions invalid wrong read" `Quick test_check_program_transitions_invalid_wrong_read;
                    Alcotest.test_case "check program transitions invalid wrong write" `Quick test_check_program_transitions_invalid_wrong_write;
                    Alcotest.test_case "check program transitions invalid state name" `Quick test_check_program_transitions_invalid_state_name;
                ]);
        ]