module To_test = struct
    let check_alphabet_format = Program_validation.check_alphabet_format
    let has_duplicates = Program_validation.has_duplicates
    let string_in_list = Program_validation.string_in_list
    let list_in_list = Program_validation.list_in_list
end

(*
    Test check_alphabet_format function
*)
let test_valid_alphabet_format () =
    Alcotest.(check (result bool string)) "same" (Ok true) (To_test.check_alphabet_format ["a"; "b"; "c"])

let test_invalid_alphabet_format_empty_alphabet () =
    Alcotest.(check (result bool string)) "same" (Error "Alphabet is empty") (To_test.check_alphabet_format [])

let test_invalid_alphabet_format_empty_str () =
    Alcotest.(check (result bool string)) "same" (Error "Alphabet contains invalid symbol: ") (To_test.check_alphabet_format ["a"; ""; "c"])

let test_invalid_alphabet_format_long_str () =
    Alcotest.(check (result bool string)) "same" (Error "Alphabet contains invalid symbol: dd") (To_test.check_alphabet_format ["a"; "dd"; "c"])

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
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates ["a"; "b"; "c"; "d"])

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

(* Run all tests *)
let () =
    Alcotest.run "validate_program"
        [
            ("validate_alphabet",
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
            ("string_in_list",
                [
                    Alcotest.test_case "string in list true" `Quick test_string_in_list_true;
                    Alcotest.test_case "string in list true empty string" `Quick test_string_in_list_true_empt_string;
                    Alcotest.test_case "string in list false" `Quick test_string_in_list_false;
                    Alcotest.test_case "string in list false empty list" `Quick test_string_in_list_false_empty_list;
                    Alcotest.test_case "string in list false empty str" `Quick test_string_in_list_false_empty_str;
                    Alcotest.test_case "string in list false empty str in list" `Quick test_string_in_list_false_empty_str_in_list;
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
        ]