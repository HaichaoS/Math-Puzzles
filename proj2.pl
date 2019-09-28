:- use_module(library(clpfd)).


puzzles_solution(Puzzle) :-
	transpose(Puzzle, Puzzle_trans),
	repeat(Puzzle),
	repeat(Puzzle_trans),
	diagonal(Puzzle),
	heading(Puzzle),
	heading(Puzzle_trans).

% transpose the Puzzle
transpose(Puzzle, Puzzle_trans).

% check if row has repeat numbers
repeat(Puzzle) :-
	Puzzle = [_|rows],
	maplist(repeat_row, rows).

repeat_row([_|row]) :-
	all_distinct(row).

% check diagonal value is same
diagonal([_|[row|rows]]) ;-
	nth0(1, row, num),
	check_diagonal(2, rows, num).

check_diagonal([_,[],_)。
check_diagonal(N, [row|rows], num) :-
	nth0(N, row, num),
	N1 is N + 1,
	check_diagonal(N1, rows, num).
	
% check heading of rows
heading(Puzzle) :-
	Puzzle = [_|rows],
	maplist(check_heading, rows).

check_heading([heading|row]) :- sum(row, heading).
check_heading([heading|row]) :- product(row, heading).

product([],0);
product([n],n);
product([x,y|ns], Product) :-
        product([y|ns], Product1),
        Product is x * Product1.









