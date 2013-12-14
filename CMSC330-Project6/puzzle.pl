/*--------------------------------------------------------------*/
/* HELPER FUNCTIONS */

/* len - find length of list */

len([],0).
len([_|T],Result) :-
	len(T,R),
	Result is R+1.
	
/* is_sorted - whether elements of list are in sorted order */

is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|Z]) :- 
	(X<Y),
	is_sorted([Y|Z]).

/* find_board_size - find height/width of board in list form */

find_board_size(B,Result) :- 
	len(B,L),
	fHelper(L,Result).
fHelper(4,2).
fHelper(9,3).
fHelper(16,4).
fHelper(25,5).
fHelper(36,6).
fHelper(49,7).
fHelper(64,8).

/* pos_of_xy */

pos_of_xy(X,Y,S,Result) :-
	T1 is X*S,
	Result is T1+Y.
	
/* xy_of_pos */

xy_of_pos(P,S,X,Y) :-
	X is P div S,
	Y is P mod S.

/*--------------------------------------------------------------*/
/* PROJECT FUNCTIONS */

/* get_val - return N'th element of list L, or fail if not found */

get_val([M|_], 0, M).

get_val([_|A], N, R) :-
	N1 is N - 1,
	get_val(A, N1, R).
	
/* get_vals - return list of values in L at list of indices N */

get_vals(X, [], []).

get_vals(X, [M|A], R) :-
	get_val(X, M, Y1),
	get_vals(X, A, Y2),
	R = [Y1|Y2].

/* set_n - set N'th element of list N to value V, return result */
set_n([], _, _, []).

set_n([M|A], 0, V, R) :-
	R = [V|A].
	
set_n([M|A], N, V, R) :-
	N > 0,
	N1 is N - 1,
	set_n(A, N1, V, List),
	R = [M|List].

/* list_swap_val - swap values U, V in list B */
list_swap_val([], _, _, []).

list_swap_val([U|A], U, V, Result) :-
	list_swap_val(A, U, V, Result1),
	Result = [V|Result1].
	
list_swap_val([V|A], U, V, Result) :-
	list_swap_val(A, U, V, Result2),
	Result = [U|Result2].
	
list_swap_val([M|A], U, V, Result) :-
	M \= U,
	M \= V,
	list_swap_val(A, U, V, Result3),
	Result = [M|Result3].

/* returns index of value V in list X, if found */
index_helper([M|A], V, R, B) :-
	M = V,
	R = B.
	
index_helper([M|A], V, R, B) :-
	B1 is B + 1,
	index_helper(A, V, R, B1).
	
index(X, V, R) :-
	index_helper(X, V, R, 0).

/* list of positions in board B that can move to space */
move_pos_helper(Boardsize, X, Y, Result) :-
	X1 is X - 1;
	X1 >= 0,
	pos_of_xy(X1, Y, Boardsize, Result1),
	Result = Result1.

move_pos_helper(Boardsize, X, Y, Result) :-
	Y1 is Y - 1;
	Y1 >= 0,
	pos_of_xy(X, Y1, Boardsize, Result3),
	Result = Result3.
	
move_pos_helper(Boardsize, X, Y, Result) :-
	Y2 is Y + 1;
	Y2 < Boardsize,
	pos_of_xy(X, Y2, Boardsize, Result4),
	Result = Result4.

move_pos_helper(Boardsize, X, Y, Result) :-
	X2 is X + 1;
	X2 < Boardsize,
	pos_of_xy(X2, Y, Boardsize, Result2),
	Result = Result2.
	
move_pos(B, R) :-
	find_board_size(B, Size),
	index(B, 0, Zero),
	xy_of_pos(Zero, Size, X, Y),
	move_pos_helper(Size, X, Y, R1),
	R = R1.

/* make move given board B and position X of value to be moved */

make_move(B, X, R) :-
	get_val(B, X, Value),
	list_swap_val(B, 0, Value, R1),
	R = R1.

/* make all possible moves for given board B, return resulting boards */

make_moves(B,R) :-
	move_pos(B, Move),
	make_move(B, Move, R1),
	R = R1.
	
/* find solutions for board B within N steps */

solve_board_helper([M|A], N, R) :-
	is_sorted(M),
	R = [M|A].

solve_board_helper([M|A], N, R) :-
	L = [M|A],
	N > 0,
	make_moves(M, Move),
	\+index(A, Move, R2),
	L1 = [Move|L],
	N1 is N - 1,
	solve_board_helper(L1, N1, R).
	
solve_board([], _, []).

solve_board(B, N, R) :-
	solve_board_helper([B], N, R).
