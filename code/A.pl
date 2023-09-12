:- consult('./algos/iterative_deepening/depth_first_iterative_deepening.pl').
:- consult('./model/board_matrix.pl').
:- consult('./model/visuals.pl').

%Tambem pode ter contador que conta posiões que faltam
goal(Board) :-
    empty_positions(Board, List),
    List == [].

% Passar contador
% Generate the next state of the puzzle by filling in a cell with a valid value
s(Board, NextBoard) :-
    first_empty_position(Board, X/Y),
    member(Num, [1,2,3,4,5,6,7,8,9]),
    validate_move(Board, X/Y, Num, NextBoard),
    write("[DEBUG] -> "), writeln(NextBoard).
    
%--------------------------------------------------------------
%----------------------- Main Function ------------------------
%--------------------------------------------------------------

main :-
    get_diabolical_board(Board),
    statistics(walltime, [Start|_]),
    depth_first_iterative_deepening(Board, [Solution| _]),
    statistics(walltime, [End|_]),
    print_board(Solution),
    Time is End - Start,
    write("Execution time= "), writeln(Time).

depthfirst(Path, Node, [Node | Path]) :-
    goal(Node).

depthfirst(Path, Node, Sol) :-
    s(Node, Node1),
    \+ member(Node1, Path),           % Prevent a cycle
    depthfirst([Node | Path], Node1, Sol).

    %///////////////////////////////////////////////////////

%--------------------------------------------------------------
%------------------- Auxiliary Functions ----------------------
%--------------------------------------------------------------
