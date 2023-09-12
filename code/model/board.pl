:-consult('../view/view.pl').

generate_row(0, Init, Res) :- Res = Init.
generate_row(Size, Init, Res) :-
    Size > 0,
    NewSize is Size - 1,
    append(Init, ['.'], NewList),
    generate_row(NewSize, NewList, Res).

generate_matrix(Size, 0, Init, Result) :- Result = Init.
generate_matrix(Size, Idx, Init, Result) :-
    Idx > 0,
    NewIdx is Idx - 1,
    generate_row(Size, [], NewRow),
    append(Init, [NewRow], NewRes),
    generate_matrix(Size, NewIdx, NewRes, Result).

create_board(Size, Board) :-
    generate_matrix(Size, Size, [], Board).

replace_nth1(1, [_ | T], X, [X | T]).
replace_nth1(N, [H | T], X, [H | R]) :-
    N > 0,
    N1 is N - 1,
    replace_nth1(N1, T, X, R).

insert(Board, X/Y, Elem, NewBoard) :-
    nth1(X, Board, Row),
    replace_nth1(Y, Row, Elem, NewRow),
    replace_nth1(X, Board, NewRow, NewBoard).

get(Board, X/Y, Elem) :-
    nth1(X, Board, Rows),
    nth1(Y, Rows, Elem).
    

%check_is_empty(Board, X/Y):-
%  nth1(X,Board,Row),
%  nth1(Y,Row,'.').
% 

check_is_empty(Board, X/Y) :-
    nth1(X, Board, Row),
    nth1(Y, Row, '.').

in_bounds(Size, X/Y) :-
    X >= 1, X =< Size,
    Y >= 1, Y =< Size.

get_elem_board(Board, X/Y, Elem):-
    nth1(X,Board,Row),
    nth1(Y,Row,Elem).

check_same_player(Player, Char) :-
    Player == Char.

analyse_move(Board, X/Y):- 
    length(Board, Size),
    in_bounds(Size,X/Y),
    check_is_empty(Board,X/Y).

get_neighbours(Board, Player, X/Y, Neighbors) :-
    length(Board, Size),
    BoardSize is Size + 1,
    RowBelow is X + 1,
    RowAbove is X - 1,
    ColLeft is Y - 1,
    ColRight is Y + 1,
    findall(Neighbor, (
        between(ColLeft, ColRight, Col),
        between(RowAbove, RowBelow, Row),
        Row >= 1,
        Row < BoardSize,
        Col>= 1,
        Col < BoardSize,
        get_elem_board(Board, Row/Col, ResElem),
        check_same_player(Player, ResElem),
        \+ (Row =:= X, Col =:= Y),
        \+ (Row =:= X - 1, Col =:= Y - 1),
        \+ (Row =:= X + 1, Col =:= Y + 1),
        Neighbor = Row/Col
        ), Neighbors).
