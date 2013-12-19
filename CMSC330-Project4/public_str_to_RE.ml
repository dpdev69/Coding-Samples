(* test parsing string to RE *)
#use "nfa.ml"

let test_parser str =
  try
    let r = (Nfa.string_to_regexp str) in
    print_endline (Nfa.regexp_to_string r)
  with Nfa.IllegalExpression s ->
    print_endline ("IllegalExpression " ^ str);;
    
test_parser "ab";;
test_parser "c|d";;
test_parser "e*";;
test_parser "f|";;
