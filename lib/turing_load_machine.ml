open In_channel
open Program_type
open FileUtil

let get_program_from_file infile : (Program.t, string) result =
  if test (And (Is_file, Is_readable)) infile then
    let input = with_open_bin infile input_all in
    let prog_decripter = Program.jsont in
    Jsont_bytesrw.decode_string prog_decripter input ~file:infile
  else
    Error "File not found"
