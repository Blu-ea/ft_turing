open Program_type

(*
    Print the tape with the head position indicated by angle brackets.
    If the head is out of bounds, print the tape as is.
*)
let print_tape_with_head (tape : string) (head : int) : unit =
    if head < 0 || head >= String.length tape then
        Printf.printf "%s" tape
    else
        let first_part = String.sub tape 0 head in
        let head_part = String.get tape head in
        let tail_part = String.sub tape (head + 1) (String.length tape - head - 1) in
        Printf.printf "[%s<%c>%s]" first_part head_part tail_part

(*
    Print the tape centered on the head position with a target width of 21 characters.
    Fill with blank symbols if necessary.
*)
let print_centered_tape_with_head (tape : string) (head : int) (blank : string) : unit =
    let tape_lenght = String.length tape in
    let first_part, new_head, remain = 
    if (head <= 10) then
        String.sub tape 0 (head + 1), head, (10 - head)
    else
        String.sub tape (head - 10) 11, 10, 0
    in
    let length_diff = tape_lenght - (head + 1) in
    let target_second_lenght = 10 + remain in
    let second_part =
        if (length_diff >= target_second_lenght) then
            String.sub tape (head + 1) target_second_lenght
        else
            String.sub tape (head + 1) (length_diff) ^ String.make (10 - length_diff + remain) blank.[0]
    in
    print_tape_with_head (first_part ^ second_part) new_head;

(*
    Get the transition from a transition list for a given symbol.
    Return the found transition or None if there is no transition for the given symbol.
*)
let get_transition_for_symbol (transitions : Transition.t list) (symbol : string) =
    List.find_opt (fun transition -> Transition.read transition = symbol) transitions

(*
    Run a single transition on the tape at the head position.
    Return the new tape, new head position and new state or an error message if any probleme occur.
*)
let run_transition (transition : Transition.t) (tape : string) (head : int) =
        if (head = 0 && transition.action = Action.LEFT) then
            Error "Head moved left out of bounds"
        else 
            let new_tape = String.mapi (fun i c -> if i = head then transition.write.[0] else c) tape in
            let new_head = match transition.action with
                | Action.LEFT -> head - 1
                | Action.RIGHT -> head + 1
            in
            Ok (new_tape, new_head, transition.to_state)

(*
    Extend the tape with blank symbols if the head is out of bounds on the right.
    Return the extended tape.
*)
let extend_tape (tape : string) (blank : char) (head : int) : string =
    let lenght = String.length tape in
    if head < 0 then
        tape
    else if head >= lenght then
        (tape ^ (String.make (head - (lenght - 1)) blank))
    else
        tape

(*
    Run the machine until it reaches an error or a final state.
    Return the final tape or an error message.
*)
let rec run_transition_loop (program : Program.t) (tape : string) (head : int) (current_state : string) =
    if not (List.mem current_state program.states) then
        Error ("Current state " ^ current_state ^ " is not in the list of states")
    else if List.mem current_state program.finals then
        Ok tape
    else
        let extended_tape = extend_tape tape (Program.blank program).[0] head in
        match get_transition_for_symbol (Transitions.get current_state program.transitions) (String.make 1 (String.get extended_tape head)) with
        | None -> Error "No valid transition found"
        | Some transition ->
            print_centered_tape_with_head extended_tape head (Program.blank program);
            Printf.printf " ";
            Transition.print_info current_state transition;
            match run_transition transition extended_tape head with
            | Error msg -> Error msg
            | Ok (new_tape, new_head, new_state) ->
                run_transition_loop program new_tape new_head new_state
