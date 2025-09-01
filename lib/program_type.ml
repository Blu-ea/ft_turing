(* open Ppx_deriving_yojson_runtime *)

type action =
  | LEFT
  | RIGHT
[@@deriving of_yojson]

type transition = {
  read : char;
  to_state : string;
  write : string;
  action : string;
} [@@deriving of_yojson]


module StringMap = struct
  module M = Map.Make(String)

  type 'a t = 'a M.t

  let of_yojson of_yojson = function
    | `Assoc xs ->
        let add map (k, vjson) =
          match of_yojson vjson with
          | Ok v -> Ok (M.add k v map)
          | Error e -> Error e
        in
        List.fold_left (fun acc kv ->
          match acc with
          | Error e -> Error e
          | Ok map -> add map kv
        ) (Ok M.empty) xs
    | _ -> Error "Expected JSON object"
          
  (* let yojson_of_t to_yojson map =
    `Assoc (M.bindings map |> List.map (fun (k, v) -> (k, to_yojson v))) *)
    (* `to_yojson` is not needed since we do not convert it back to json *)
end


type program = {
  name : string;
  alphabet : char list;
  blank : char;
  states : string list;
  initial : string;
  finals : string list;
  transitions : transition list StringMap.t;
} [@@deriving of_yojson]


(* 
match machine with 
| Ok x -> x.name
| _ -> ":<";;
- : string = "unary_sub"
*)