type launch_option =
  | HelpLog
  | LaunchExec
  | ErrorInput


let print_usage() =
  Printf.printf
"Usage :
  ft_turing [-h] jsonfile input

Positionnal arguments:
 - jsonfile     : Json file that describe the states of the machine

 - input        : The input tape of the machine


Optional arguements:
    -h, --help    : Show this help
"


let print_error() = 
  print_endline("this Is the Error Text ! >:( ")


let rec check_args (pos: int) (args: string list): launch_option = 
  match (pos, args) with
  | (1, "-h" :: []) | (1, "--help" :: []) -> HelpLog
  | (1, "-h" :: _) | (1, "--help" :: _) -> HelpLog
  | (1, _ :: rest) -> check_args(pos + 1) rest
  | (1, []) -> ErrorInput
  
  | (2, _ :: rest) -> check_args(pos + 1) rest
  | (2, []) -> ErrorInput
  
  | (3, _ :: _) -> ErrorInput
  | (3, []) -> LaunchExec
  
  | (_, _) -> ErrorInput


let launch_option (opt: string list) =
  let file = List.hd opt in
  let input = List.hd (List.tl opt) in
  Printf.printf "File is %s, Input string is %s\n" file input;
  Parse_json.read_file file input


let () =
  let check = (List.tl (Array.to_list Sys.argv)) in
  match check_args 1 check with 
  | HelpLog -> print_usage()
  | ErrorInput -> print_error()
  | LaunchExec -> 
    match launch_option check with 
    | None -> print_error()
    | Some(injson) -> Printf.printf("This file is OKAY Json")
