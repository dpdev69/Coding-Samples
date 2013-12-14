(* CMSC 330 / Fall 2013 / Project 4 *)
(* Name: Emmanuel Taylor *)

#load "str.cma"

(* ------------------------------------------------- *)
(* MODULE SIGNATURE *)
(* ------------------------------------------------- *)

module type NFA =
  sig
    (* You may NOT change this signature *)

    (* ------------------------------------------------- *)
    (* PART 1: NFA IMPLEMENTATION *)
    (* ------------------------------------------------- *)

    (* ------------------------------------------------- *)
    (* Abstract type for NFAs *)
    type nfa

    (* Type of an NFA transition.

       (s0, Some c, s1) represents a transition from state s0 to state s1
       on character c

       (s0, None, s1) represents an epsilon transition from s0 to s1
     *)
    type transition = int * char option * int 

    (* ------------------------------------------------- *)
    (* Returns a new NFA.  make_nfa s fs ts returns an NFA with start
       state s, final states fs, and transitions ts.
     *)
    val make_nfa : int -> int list -> transition list -> nfa

    (* ------------------------------------------------- *)
    (*  Calculates epsilon closure in an NFA.  

	e_closure m ss returns a list of states that m could 
	be in, starting from any state in ss and making 0 or 
	more epsilon transitions.

       There should be no duplicates in the output list of states.
     *)

    val e_closure : nfa -> int list -> int list

    (* ------------------------------------------------- *)
    (*  Calculates move in an NFA.  

	move m ss c returns a list of states that m could 
	be in, starting from any state in ss and making 1
	transition on c.

       There should be no duplicates in the output list of states.
     *)

    val move : nfa -> int list -> char -> int list

    (* ------------------------------------------------- *)
    (* Returns true if the NFA accepts the string, and false otherwise *)
    val accept : nfa -> string -> bool

    (* ------------------------------------------------- *)
    (* PART 2: REGULAR EXPRESSION IMPLEMENTATION *)
    (* ------------------------------------------------- *)

    (* ------------------------------------------------- *)
    type regexp =
	Empty_String
      | Char of char
      | Union of regexp * regexp
      | Concat of regexp * regexp
      | Star of regexp

    (* ------------------------------------------------- *)
    (* Given a regular expression, print it as a regular expression in 
       postfix notation (as in project 2).  Always print the first regexp 
       operand first, so output string will always be same for each regexp.
     *)
    val regexp_to_string : regexp -> string 

    (* ------------------------------------------------- *)
    (* Given a regular expression, return an nfa that accepts the same
       language as the regexp
     *)
    val regexp_to_nfa : regexp -> nfa

    (* ------------------------------------------------- *)
    (* PART 3: REGULAR EXPRESSION PARSER *)
    (* ------------------------------------------------- *)

    (* ------------------------------------------------- *)
    (* Given a regular expression as string, parses it and returns the
       equivalent regular expression represented as the type regexp.    
     *)
    val string_to_regexp : string -> regexp

    (* ------------------------------------------------- *)
    (* Given a regular expression as string, parses it and returns 
       the equivalent nfa 
     *)
    val string_to_nfa: string -> nfa

    (* ------------------------------------------------- *)
    (* Throw IllegalExpression expression when regular
       expression syntax is illegal
     *)
    exception IllegalExpression of string

end

(* ------------------------------------------------- *)
(* MODULE IMPLEMENTATION *)
(* ------------------------------------------------- *)

    (* Make all your code changes past this point *)
    (* You may add/delete/reorder code as you wish *)

module NfaImpl =

struct

type transition = int * char option * int

type nfa = Nfa of int * int list * transition list

let make_nfa ss fs ts = Nfa (ss, fs, ts) 
;;

let get_transition ts s sym =
	let valid_transition t =
		match t with (src, letter, dest) ->
			if s = src && sym = letter then
				true
			else
				false
	in let extract_dest t = 
			match t with (src, letter, dest) ->
				dest
		in List.map extract_dest (List.filter valid_transition ts)
;;

let e_closure m ss =
	let rec e_closure_help ws vs =
		match ws with
			[] -> vs
		    | (h :: t) -> 
				match m with Nfa (start, final, trans_list) ->
					if List.mem h vs = false then
						e_closure_help (t @ (get_transition trans_list h None)) (vs@[h])
					else
						e_closure_help t vs
	in List.sort compare (e_closure_help ss [])
;;

let move m ss c =
	let rec move_help ws ns =
		match ws with
			[] -> ns
		    | (h :: t) -> 
				match m with Nfa (start, final, trans_list) ->
					move_help t (ns @ (get_transition trans_list h) (Some c))
	in let rec uniq sorted_list = 
		match sorted_list with
			[] -> []
		    | (h :: t) -> 
				if List.mem h t then
					uniq t
				else
					h :: uniq t
		in uniq(List.sort compare (move_help ss []))
;;

let accept m s =
	match m with Nfa (start, final, trans_list) ->
		let rec accept_help ss n =
			if n < String.length s then
				let letter = String.get s n in
					accept_help(e_closure m (move m ss letter)) (n + 1)
			else
				let rec check_final l =
					match l with
						[] -> false
					  | (h :: t) ->
							if List.mem h final then
								true
							else
								check_final t
				in check_final ss
		in accept_help(e_closure m [start]) 0
;;
		
let next =
	let count = ref 0 in
		function () ->
			let temp = !count in
				count := (!count) + 1;
				temp
;;	
		
type regexp =
	  Empty_String
	| Char of char
	| Union of regexp * regexp
	| Concat of regexp * regexp
	| Star of regexp

let rec regexp_to_string r =
	match r with
		Empty_String -> "E"
	    | Char c -> Char.escaped c
	    | Union (r1, r2) -> (regexp_to_string r1) ^ " " ^ (regexp_to_string r2) ^ " |"
	    | Concat (r1, r2) -> (regexp_to_string r1) ^ " " ^ (regexp_to_string r2) ^ " ."
	    | Star r1 -> (regexp_to_string r1) ^ " *"
;;

let rec add_e_transitions src_list dest =
	match src_list with
		[] -> []
	    | (h :: t) -> [(h, None, dest)] @ (add_e_transitions t dest)
;;

let rec regexp_to_nfa r = 
	match r with
		Empty_String ->
			let s0 = next () in
			let s1 = next () in
				make_nfa s0 [s1] [(s0, None, s1)]
	    | Char c -> 
			let s0 = next () in
			let s1 = next () in
				make_nfa s0 [s1] [(s0, Some c, s1)]
	    | Union (r1, r2) ->
			let s0 = next () in
			let s1 = next () in
			let Nfa (start1, final1, trans_list1) = regexp_to_nfa r1 in
			let Nfa (start2, final2, trans_list2) = regexp_to_nfa r2 in
				make_nfa s0 [s1] ([(s0, None, start1); (s0, None, start2)]
									@ (add_e_transitions final1 s1) @ (add_e_transitions final2 s1)
									@ trans_list1 @ trans_list2)
	    | Concat (r1, r2) ->
	        let Nfa (start1, final1, trans_list1) = regexp_to_nfa r1 in
			let Nfa (start2, final2, trans_list2) = regexp_to_nfa r2 in
				make_nfa start1 final2 ((add_e_transitions final1 start2)
										@ trans_list1 @ trans_list2)
	    | Star r1 -> 
			let s0 = next () in
			let s1 = next () in
			let Nfa (start1, final1, trans_list1) = regexp_to_nfa r1 in
				make_nfa s0 [s1] ([(s0, None, s1); (s1, None, s0)]
									@ [(s0, None, start1)] @ (add_e_transitions final1 s1)
									@ trans_list1)
;;

exception IllegalExpression of string

(************************************************************************)

(* Scanner code provided to turn string into a list of tokens *)

type token =
   Tok_Char of char
 | Tok_Epsilon
 | Tok_Union
 | Tok_Star
 | Tok_LParen
 | Tok_RParen
 | Tok_END

let re_var = Str.regexp "[a-z]"
let re_epsilon = Str.regexp "E"
let re_union = Str.regexp "|"
let re_star = Str.regexp "*"
let re_lparen = Str.regexp "("
let re_rparen = Str.regexp ")"

let tokenize str =
 let rec tok pos s =
   if pos >= String.length s then
     [Tok_END]
   else begin
     if (Str.string_match re_var s pos) then
       let token = Str.matched_string s in
       (Tok_Char token.[0])::(tok (pos+1) s)
	 else if (Str.string_match re_epsilon s pos) then
       Tok_Epsilon::(tok (pos+1) s)
	 else if (Str.string_match re_union s pos) then
       Tok_Union::(tok (pos+1) s)
	 else if (Str.string_match re_star s pos) then
       Tok_Star::(tok (pos+1) s)
     else if (Str.string_match re_lparen s pos) then
       Tok_LParen::(tok (pos+1) s)
     else if (Str.string_match re_rparen s pos) then
       Tok_RParen::(tok (pos+1) s)
     else
       raise (IllegalExpression "tokenize")
   end
 in
 tok 0 str

(************************************************************************)

let lookahead token_list = match token_list with
        [] -> raise (IllegalExpression "lookahead")
        | (h :: t) -> (h, t)

let rec parse_S l = 
	let (a1, l1) = (parse_A l) in
        let (t, n) = lookahead l1 in
			match t with
                Tok_Union -> 
					(let (a2,l2) = (parse_S n) in (Union (a1, a2), l2))
                | _ -> (a1, l1)				

and parse_A l =
	let (a1, l1) = (parse_B l) in
        let (t, n) = lookahead l1 in
			match t with 
				Tok_Char c ->				
					(let (a2,l2) = (parse_A l1) in (Concat (a1, a2), l2))
			    | Tok_Epsilon -> (let (a2,l2) = (parse_A l1) in (Concat (a1, a2), l2))
			    | Tok_LParen ->(let (a2,l2) = (parse_A l1) in (Concat (a1, a2), l2))
			    |  _ -> (a1, l1)				

and parse_B l =
	let (a1, l1) =  (parse_C l) in
        let (t, n) = lookahead l1 in
			match t with 
                Tok_Star -> (Star a1, n)		
                | _ -> (a1, l1)					
				
and parse_C l =
	let (t, n) = lookahead l in
		match t with
			Tok_Char c -> (Char c, n)			
		    | Tok_Epsilon -> (Empty_String, n)	
		    | Tok_LParen ->		  				
				(let (a2,l2) = (parse_S n) in 
				 let (t2,n2) = lookahead l2 in 
					if (t2 = Tok_RParen) then
						(a2,n2)
					else
						raise (IllegalExpression "parse_C"))
		    | _ -> raise (IllegalExpression "parse_C")
;;
  
let string_to_regexp s =
	let token_list = tokenize s in
		let (a, t) = (parse_S token_list) in
			if t <> [Tok_END] then raise (IllegalExpression "parse_S") ;
			a
;;

let string_to_nfa s =
	regexp_to_nfa (string_to_regexp s)
;;

end

module Nfa : NFA = NfaImpl;;
