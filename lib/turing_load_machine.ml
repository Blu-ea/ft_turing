open Program_type
open FileUtil

let get_program_from_file infile : (program, string) result = 
  if test Is_file infile == true then
    try 
      match Yojson.Safe.from_file infile |> program_of_yojson with
        | Ok prog -> Ok prog
        | Error str -> Error ("Invalide Json, missing " ^ String.sub str 21 ((String.length str) - 21))
    with
      | Yojson.Json_error _ -> Error("Couln't parse the input file, not an json file")
      (* | Invalid_argument str -> Error str; *) 
      | _  -> Error ("Unknow Error")

  else
    Error ("File is not found")
