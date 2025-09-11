module Action = struct
  type t = RIGHT | LEFT
  let assoc = ["RIGHT", RIGHT; "LEFT", LEFT]
  let jsont = Jsont.enum ~kind:"Action" assoc
end

module Transition = struct
  type t = {
    read : string;
    to_state : string;
    write : string;
    action : Action.t;
  }
(*  ==== Constructor ==== *)
  let make read to_state write action = 
    {read; to_state; write; action}
(*  ===== Getters ===== *)
    let read i = i.read
    let to_state i = i.to_state
    let write i = i.write
    let action i = i.action
(*  =====        ===== *)
    let jsont = Jsont.Object.map ~kind:"Transition" make
    |> Jsont.Object.mem "read" Jsont.string ~enc:read
    |> Jsont.Object.mem "to_state" Jsont.string ~enc:to_state
    |> Jsont.Object.mem "write" Jsont.string ~enc:read
    |> Jsont.Object.mem "action" Action.jsont ~enc:action
    |> Jsont.Object.finish
end

module Transitions = struct
  module M = Map.Make(String)

  type t = Transition.t list M.t

(*  ==== Constructor ==== *)
  let make () = M.empty
(* === Add a transition === *)
  let add state transition transitions = 
    let current = M.find_opt state transitions |> Option.value ~default:[] in
    M.add state (transition :: current) transitions

(* === Get a transition === *)
  let get state transitions = 
    M.find_opt state transitions |> Option.value ~default:[]

  
  let jsont =
    Jsont.Object.as_string_map
      ~kind:"Transitions"
      (Jsont.list Transition.jsont)

end

module Program = struct 
  type t = {
    name: string;
    alphabet : string list;
    blank : string;
    states : string list;
    initial : string;
    finals : string list;
    transitions : Transitions.t;
  }

(*  ==== Constructor ==== *)
  let make name alphabet blank states initial finals transitions= 
    {name; alphabet; blank; states; initial; finals; transitions}
(*  ===== Getters ===== *)
    let name i = i.name
  let alphabet i = i.alphabet
  let blank i = i.blank
  let states i = i.states
  let initial i = i.initial
  let finals i = i.finals
  let transitions i = i.transitions
(*  =====        ===== *)

  let jsont = 
    Jsont.Object.map ~kind:"Prog" make
    |> Jsont.Object.mem "name" Jsont.string ~enc:name 
    |> Jsont.Object.mem "alphabet" Jsont.(list string) ~enc:alphabet 
    |> Jsont.Object.mem "blank" Jsont.string ~enc:blank 
    |> Jsont.Object.mem "states" Jsont.(list string) ~enc:states 
    |> Jsont.Object.mem "initial" Jsont.string ~enc:initial 
    |> Jsont.Object.mem "finals" Jsont.(list string) ~enc:finals 
    |> Jsont.Object.mem "transitions" Transitions.jsont ~enc:transitions 
    |> Jsont.Object.finish

  end

