% Created by Haichao Song 854035
% Solve Math_puzzle for COMP30020 Declarative Programming Project 2

% ----------------------------------------------------------------------------

% Library used 

% transpose/2 used to transpose puzzle from horizontal to vertical
% all_distinct/1 are used to check row has no repeat numbers
% ins/2 are used to check row only has digits from 0-9
% label/1 are used to try all values in finite domain until ground
% sum/3 are used to check if the heading is the num of the row
:- use_module(library(clpfd)).

% maplist/2 are used to map check for puzzle to each row
:- use_module(library(apply)).

% ----------------------------------------------------------------------------

% puzzle_solution/1 get the 2d array of a math puzzle with certain heading and
% numbers, eventually get all possibile answers to solve  the puzzle
% First, all numbers in the puzzle should be integer from 1 to 9
% Then the diagonal of the puzzle should be same number
% After that for all puzzle and transpose puzzle:
% 	rows do not have repeat numbers
% 	heading is sum or product of the row
% Eventually chack the all values in domain are checked
puzzle_solution(Puzzle) :-
	digit(Puzzle),
	diagonal(Puzzle),
	transpose(Puzzle, Puzzle_trans),
	repeat(Puzzle),
	repeat(Puzzle_trans),
	heading(Puzzle),
	heading(Puzzle_trans),
	check_ground(Puzzle).

% ----------------------------------------------------------------------------

% each to be filled in with a single digit 1–9
% digit/1 map puzzle to rows to check numbers in Puzzle are all integer from 
% 1-9 check_digit/1 check all numbers in one row are integer from 1-9

digit([_|Rows]) :- maplist(check_digit, Rows).

check_digit([_|Row]) :- Row ins 1..9.

% ----------------------------------------------------------------------------

% each row and each column contains no repeated digits
% repeat/1 map puzzle to rows to check if row has repeat numbers
% check_repeat/1 check all numbers in one row have no repeatation

repeat([_|Rows]) :- maplist(check_repeat, Rows).

check_repeat([_|Row]) :- all_distinct(Row).

% ----------------------------------------------------------------------------

% all squares on the diagonal line from upper left to lower right contain
% the same value
% diagonal/1 use get the first corner value and start tail recursion
% check_diagonal/3 use tail recursion to bound diagonal with same value

diagonal([_|[Row|Rows]]) :-
	nth0(1, Row, Num),
	check_diagonal(2, Rows, Num).

check_diagonal(_,[],_).
check_diagonal(N, [Row|Rows], Num) :-
	nth0(N, Row, Num),
	N1 is N + 1,
	check_diagonal(N1, Rows, Num).

% ----------------------------------------------------------------------------
	
% the heading of reach row and column (leftmost square in a row and 
% topmost square in a column) holds either the sum or the product of 
% all the digits in that row or column
% heading/1 map puzzle to rows to check if heading is sum or product
% of numbers in the row
% check_heading/1 check each row if heading is sum or product of the row
% product/2 use tail recursion to check the product of a list

heading([_|Rows]) :- maplist(check_heading, Rows).

check_heading([Heading|Row]) :- sum(Row, #=, Heading).
check_heading([Heading|Row]) :- product(Row, Heading).

product([], 0).
product([N], N).
product([N,N1|Ns], Product) :-
        product([N1|Ns], Product1),
        Product #= N * Product1.

% ----------------------------------------------------------------------------

% its argument must be ground
% check_ground/1 check all values in a finite domain is checked

check_ground([_|Rows]) :- maplist(label, Rows).









