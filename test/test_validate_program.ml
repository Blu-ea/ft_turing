module To_test = struct
  let check_alphabet_format = Program_validation.check_alphabet_format
  let has_duplicates = Program_validation.has_duplicates
end

let test_valid_alphabet_format () =
    Alcotest.(check (result bool string)) "same" (Ok true) (To_test.check_alphabet_format ["a"; "b"; "c"])

let test_invalid_alphabet_format_empty () =
    Alcotest.(check (result bool string)) "same" (Error "Alphabet contains invalid symbol: ") (To_test.check_alphabet_format ["a"; ""; "c"])

let test_invalid_alphabet_format_double () =
    Alcotest.(check (result bool string)) "same" (Error "Alphabet contains invalid symbol: dd") (To_test.check_alphabet_format ["a"; "dd"; "c"])

let test_has_duplicates_true () =
    Alcotest.(check bool) "same bool" true (To_test.has_duplicates ["a"; "b"; "c"; "a"])

let test_has_duplicates_false () =
    Alcotest.(check bool) "same bool" false (To_test.has_duplicates ["a"; "b"; "c"; "d"])

let () =
    Alcotest.run "validate_program"
        [
            ("validate_alphabet",
                [
                    Alcotest.test_case "valid alphabet" `Quick test_valid_alphabet_format;
                    Alcotest.test_case "valid alphabet" `Quick test_invalid_alphabet_format_empty;
                    Alcotest.test_case "valid alphabet" `Quick test_invalid_alphabet_format_double;
                ]);
            ("has_duplicates",
                [
                    Alcotest.test_case "has duplicates" `Quick test_has_duplicates_true;
                    Alcotest.test_case "has no duplicates" `Quick test_has_duplicates_false;
                ]);
        ]