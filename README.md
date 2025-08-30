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