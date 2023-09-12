%     Test Board
%|-----------------------|
%| . 5 . | . 8 3 | . 1 7 |
%| . . . | 1 . . | 4 . . |
%| 3 . 4 | . . 5 | 6 . 8 |
%|-----------------------|
%| . . . | . 3 . | . . 9 |
%| . 9 . | 8 2 4 | 5 . . |
%| . . 6 | . . . | . 7 . |
%|-----------------------|
%| . . 9 | . . . | . 5 . |
%| . . 7 | 2 9 . | . 8 6 |
%| 1 . 3 | 6 . 7 | 2 . 4 |
%|-----------------------|

get_easy_board(Board) :-
    Board = [
        [1,.,.,.,.,6,8,3,.],
        [.,8,.,5,7,3,.,9,.],
        [.,.,.,.,2,8,.,.,.],
        [.,7,.,3,.,1,9,8,.],
        [5,4,9,.,8,7,6,1,.],
        [8,.,.,4,.,9,2,.,.],
        [.,.,.,.,.,2,3,.,.],
        [7,6,3,.,.,.,.,.,9],
        [9,2,8,7,.,.,5,.,.]
    ].

get_medium_board(Board) :-
    Board = [
        [5,3,.,.,.,4,2,.,.],
        [.,.,.,9,.,.,7,.,4],
        [.,.,.,.,1,2,6,.,5],
        [.,.,4,.,6,3,1,.,.],
        [9,.,3,.,4,7,.,6,.],
        [6,.,.,.,.,.,.,.,2],
        [.,.,.,.,.,.,.,.,.],
        [.,2,6,4,.,9,8,.,.],
        [.,9,1,5,.,.,.,.,.]
    ].

get_hard_board(Board) :-
    Board = [
        [.,.,3,2,.,.,1,.,.],
        [.,.,.,9,.,.,4,.,.],
        [2,.,9,8,.,.,.,6,.],
        [.,.,6,.,.,5,7,.,.],
        [.,7,.,.,.,3,.,4,.],
        [4,9,.,.,.,.,.,.,.],
        [.,.,2,.,.,1,6,.,.],
        [.,.,7,3,.,.,.,.,8],
        [.,.,.,.,.,.,.,.,.]
    ].

get_diabolic_board(Board) :-
    Board = [
        [6,.,.,7,9,.,2,.,8],
        [.,.,.,.,.,.,3,.,.],
        [.,4,.,6,.,.,.,.,.],
        [.,5,.,.,.,2,8,.,7],
        [8,.,.,.,.,.,.,3,.],
        [.,.,.,.,7,.,.,4,.],
        [4,.,.,.,2,.,6,.,9],
        [.,.,1,.,.,5,.,.,.],
        [.,.,.,.,.,.,.,7,.]
    ].

get_board(Board) :-
    Board = [
        [.,5,.,.,8,3,.,1,7],
        [.,.,.,1,.,.,4,.,.],
        [3,.,4,.,.,5,6,.,8],
        [.,.,.,.,3,.,.,.,9],
        [.,9,.,8,2,4,5,.,.],
        [.,.,6,.,.,.,.,7,.],
        [.,.,9,.,.,.,.,5,.],
        [.,.,7,2,9,.,.,8,6],
        [1,.,3,6,.,7,2,.,4]
    ].

get_test(Board) :-
    Board = [
        [.,8,.,.,.,7,6,.,.],
        [.,.,1,6,5,.,.,.,2],
        [5,.,.,.,.,3,.,.,.],
        [4,.,.,5,2,.,8,.,.],
        [.,.,7,.,.,.,.,4,.],
        [.,.,.,.,3,.,.,.,.],
        [.,.,.,.,.,6,.,.,.],
        [.,9,.,.,.,.,.,.,1],
        [7,.,.,8,4,.,2,.,.]
    ].

get_elem(Board, X/Y, Elem) :-
    nth1(X, Board, Row),
    nth1(Y, Row, Elem).

get_row(Board, RowIdx, Row) :-
    nth1(RowIdx, Board, Row).

get_column(Board, ColumnIdx, Column) :-
    length(Board, Lenght),
    length(Column, Lenght),
    findall(Elem,(
        nth1(RowIndex, Board, Row), 
        nth1(ColumnIdx, Row, Elem)),
        Column).

check_list(List) :-
    exclude(==('.'), List, Out),
    sort(Out, Sorted), 
    length(Out, Length), 
    length(Sorted, Length).

check_column(Board, ColIdx) :-
    get_column(Board, ColIdx, Col),
    check_list(Col).

check_row(Board, RowIdx) :-
    get_row(Board, RowIdx, Row),
    check_list(Row).

insert(Board, X/Y, Elem, NewBoard) :-
    nth1(X, Board, Row),
    replace_nth1(Y, Row, Elem, NewRow),
    replace_nth1(X, Board, NewRow, NewBoard).

replace_nth1(1, [_ | T], X, [X | T]).
replace_nth1(N, [H | T], X, [H | R]) :-
    N > 0,
    N1 is N - 1,
    replace_nth1(N1, T, X, R).

check_empty(Elem) :-
    Elem == '.'.

pos_into_index(X/Y, Index) :-
    NewX is X - 1,
    Index is NewX * 9 + Y.

index_into_pos(Index, X/Y) :-
    X is ((Index - 1) div 9) + 1,
    Y is ((Index - 1) mod 9) + 1.

empty_positions(Board, Positions) :-
    findall(
        Pos,(
            between(1, 9, Y), 
            between(1, 9, X),
            get_elem(Board, X/Y, Elem),
            check_empty(Elem),
            Pos = X/Y
        ), Positions).

first_empty_position(Board, X/Y) :-
    empty_positions(Board, EmptyIndexes),
    EmptyIndexes = [(X/Y) | _].

check_block(Board, X/Y) :-
    X1 is X + 1,
    X2 is X + 2,
    Y1 is Y + 1,
    Y2 is Y + 2,
    Pos0 = X/Y,
    Pos1 = X/Y1,
    Pos2 = X/Y2,
    Pos3 = X1/Y,
    Pos4 = X1/Y1,
    Pos5 = X1/Y2,
    Pos6 = X2/Y,
    Pos7 = X2/Y1,
    Pos8 = X2/Y2,
    Positions = [Pos0,Pos1,Pos2,Pos3,Pos4,Pos5,Pos6,Pos7,Pos8],
    maplist(get_elem(Board), Positions, Elements),
    check_list(Elements).

check_blocks(Board) :-
    BlockIndices = [1/1, 1/4, 1/7, 4/1, 4/4, 4/7, 7/1, 7/4, 7/7],
    forall(member(Index, BlockIndices), check_block(Board, Index)).

validate_move(Board, X/Y, Digit, NewBoard) :-
    insert(Board, X/Y, Digit, NewBoard),
    check_row(NewBoard, X),
    check_column(NewBoard, Y),
    check_blocks(NewBoard).


    
    


