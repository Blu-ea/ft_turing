type launch_option = 
  | HelpOption
  | Error
  | Ok

let rec check_arg i args = 
  match (i, args) with
    | _ , "-h" :: _ | _ , "--help" :: _ ->  HelpOption
  
    | 2 , _ :: [] -> Ok

    | _ , _ :: rest -> check_arg (i + 1) rest
    | _ , [] -> Error

