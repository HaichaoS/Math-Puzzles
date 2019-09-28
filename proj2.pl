:- use_module(library(clpfd)).


puzzle_solution(Puzzle) :-
	digit(Puzzle),
	transpose(Puzzle, Puzzle_trans),
	repeat(Puzzle),
	repeat(Puzzle_trans),
	diagonal(Puzzle),
	heading(Puzzle),
	heading(Puzzle_trans).

% check numbers in Puzzle are all integer from 1 to 9
digit([_|Rows]) :- maplist(check_digit, Rows).

check_digit([_|Row]) :- Row ins 1..9.

% check if row has repeat numbers
repeat([_|Rows]) :- maplist(repeat_row, Rows).

repeat_row([_|Row]) :- all_distinct(Row).

% check diagonal value is same
diagonal([_|[Row|Rows]]) :-
	nth0(1, Row, Num),
	check_diagonal(2, Rows, Num).

check_diagonal(_,[],_).
check_diagonal(N, [Row|Rows], Num) :-
	nth0(N, Row, Num),
	N1 is N + 1,
	check_diagonal(N1, Rows, Num).
	
% check heading of rows
heading([_|Rows]) :- maplist(check_heading, Rows).

check_heading([Heading|Row]) :- sum(Row, #=, Heading).
check_heading([Heading|Row]) :- product(Row, Heading).

product([], 0).
product([N], N).
product([H,I|T], Product) :-
        product([I|T], Product1),
        Product is H * Product1.









