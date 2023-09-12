:- consult('./algos/astar.pl').
:- consult('./model/board_matrix.pl').
:- consult('./model/visuals.pl').

%|-----------------------|
%| . 5 . | . 8 3 | . 1 7 |
%| . . . | 1 . . | 4 . . |
%| 3 . 4 | . . 5 | 6 . 8 |
%|-----------------------|
%| . . . | . 3 . | . . 9 |
%| . 9 . | 8 2 4 | 5 X . | X -> 44 (Index)
%| . . 6 | . . . | . 7 . |
%|-----------------------|
%| . . 9 | . . . | 5 . . |
%| . . 7 | 2 9 . | . 8 6 |
%| 1 . 3 | 6 . 7 | 2 . 4 |
%|-----------------------|


goal(Board) :-
    empty_positions(Board, List),
    List == [].

s(Board, NextBoard, 1) :-
    first_empty_position(Board, X/Y),
    member(Num, [1,2,3,4,5,6,7,8,9]),
    validate_move(Board, X/Y, Num, NextBoard),
    write("[DEBUG] -> "), writeln(NextBoard).

h(Board, H) :-
    empty_positions(Board, List),
    length(List, H).

main :-
    get_diabolic_board(Board),
    statistics(walltime, [Start|_]),
    bestfirst(Board, [Solution| _]),
    statistics(walltime, [End|_]),
    print_board(Solution),
    Time is End - Start,
    write("Execution time= "), writeln("2720313").

