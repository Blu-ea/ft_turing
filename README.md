# ft_turing
A turning machine made with Ocaml

# Requirement

Make a program that takes 2 parameters 
1. A path to a json with all the rules 
2. The input/A tape where the rules will be run
   
## Json requirement

The json must contain the following;
 - `name`: The name of the program
 - `alphabet`: A list of all the possible character
 - `blank`: The blank character
 - `states`: A list of all the possible states
 - `initial`: The initial state  
 The Program will start with this state
 - `finals`: The final state  
   The Program will end when reaching this state
 - `transitions`: A dictionary, indexed by the possible state, containing a object representing what to do.  
    The object shall contain the following:
   - `read`: The current character at the cursor
   - `to_state`: The state of the machine at the next step 
   - `write`: The character that the cursor will write on the tape
   - `action`: Which side the cursor will go `RIGHT` or `LEFT`

### Example of input.json:


```json
{
  "name" : "unary_sub",
  "alphabet": [ "1", ".", "-", "=" ],
  "blank" : ".",
  "states" : [ "scanright", "eraseone", "subone", "skip", "HALT" ],
  "initial" : "scanright",
  "finals" : [ "HALT" ],
  "transitions" : {
    
    "scanright": [
      { "read" : ".", "to_state": "scanright", "write": ".", "action": "RIGHT"},
      { "read" : "1", "to_state": "scanright", "write": "1", "action": "RIGHT"},
      { "read" : "-", "to_state": "scanright", "write": "-", "action": "RIGHT"},
      { "read" : "=", "to_state": "eraseone" , "write": ".", "action": "LEFT" }
    ],

    "eraseone": [
      { "read" : "1", "to_state": "subone", "write": "=", "action": "LEFT"},
      { "read" : "-", "to_state": "HALT" , "write": ".", "action": "LEFT"}
    ],

    "subone": [
      { "read" : "1", "to_state": "subone", "write": "1", "action": "LEFT"},
      { "read" : "-", "to_state": "skip" , "write": "-", "action": "LEFT"}
    ],

    "skip": [
      { "read" : ".", "to_state": "skip" , "write": ".", "action": "LEFT"},
      { "read" : "1", "to_state": "scanright", "write": ".", "action": "RIGHT"}
    ]
  }
}
```

------

### Turing machime machine for unary_add.json

List of states needed (6) :
 - ScanRight
 - ScanPull
 - Subone
 - Complete
 - Addone
 - Skip

We can put the whole Instruction in `[]` to know if we are in them  
We can define the cursor as char right after `]`

so a possible tape could look like this : `11[<All the Instruction>]+1111=`

#### Specification

 - A `L` and `R` could define if we go `Left` or `Right`
 - We can put a `#` to the current state
 - We can split states with `,`
 - We can define a transition such as `1.SR` for `read 1 -> write 1 -> goto Skip -> Right`
 - We can have `<#| ><StateChar><Transition>,<Transition>`
 - So a full rull could `[#A..CA,+1sR| s.+SR| C..CR,+.HR]` could translate for 
 ```json
  "complete": [
    { "read" : ".", "to_state": "complete", "write": ".", "action": "LEFT"},
    { "read" : "+", "to_state": "HALT" , "write": ".", "action": "LEFT"}
  ],

  "addone": [
    { "read" : ".", "to_state": "addone", "write": ".", "action": "LEFT"},
    { "read" : "+", "to_state": "skip" , "write": "1", "action": "RIGHT"}
  ],

  "skip": [
    { "read" : ".", "to_state": "subone" , "write": "+", "action": "RIGHT"}
```
With `addone` being the current state  
