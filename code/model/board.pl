%".5..83.17...1..4..3.4..56.8....3...9.9.8245....6....7...9....5...729..861.36.72.4"
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

get_board(Board) :-
    Board = [
        [.,5,.,.,8,3,.,1,7],
        [.,.,.,1,.,.,4,.,.],
        [3,.,4,.,.,5,6,.,8],
        [.,.,.,.,3,.,.,.,9],
        [.,9,.,8,2,4,5,.,.],
        
    ].


create_board(Board) :-
    length(Board, 81),
    maplist(=(.), Board).
    
string_to_list(String, List) :-
    atom_chars(String, Chars),
    maplist(char_to_num, Chars, List).

char_to_num('.', '.') :- !.
char_to_num(Char, Num) :-
    atom_number(Char, Num).

generate_sudoku_board(String, List) :-
    string_to_list(String, List).

get_pos(Board, X/Y, Elem) :-
    pos_into_index(X/Y, Index),
    nth1(Index, Board, Elem).

pos_into_index(X/Y, Index) :-
    NewX is X - 1,
    X =< 9,
    Y =< 9,
    Index is NewX * 9 + Y.

index_into_pos(Index, X/Y) :-
    X is ((Index - 1) div 9) + 1,
    Y is ((Index - 1) mod 9) + 1.

get_index(Board, Index, Elem) :-
    nth1(Index, Board, Elem).

get_column_elems(Board, 10, Index, List, Res) :- Res = List.
get_column_elems(Board, N, Index, List, Res) :-
    NextN is N + 1,
    NextIndex is Index + 9,
    get_index(Board, Index, Elem),
    get_column_elems(Board, NextN, NextIndex, [Elem | List], Res).

get_row(Board, RowIndex, Row) :-
    RowIndex >= 1, RowIndex =< 9,  % Check that the RowIndex is in the range 1..9
    Offset is (RowIndex - 1) * 9,  % Calculate the offset of the first element of the row in the list
    OffSet1 is Offset + 1,
    OffSet2 is Offset + 2,               
    OffSet3 is Offset + 3, 
    OffSet4 is Offset + 4, 
    OffSet5 is Offset + 5, 
    OffSet6 is Offset + 6, 
    OffSet7 is Offset + 7, 
    OffSet8 is Offset + 8, 
    OffSet9 is Offset + 9, 
    nth1(OffSet1, Board, Row1),   % Get the first element of the row from the board
    nth1(OffSet2, Board, Row2),   % Get the second element of the row from the board
    nth1(OffSet3, Board, Row3),   % ...
    nth1(OffSet4, Board, Row4),
    nth1(OffSet5, Board, Row5),
    nth1(OffSet6, Board, Row6),
    nth1(OffSet7, Board, Row7),
    nth1(OffSet8, Board, Row8),
    nth1(OffSet9, Board, Row9),
    append([Row1,Row2,Row3,Row4,Row5,Row6,Row7,Row8,Row9], Row).

check_repeats(List) :-
    exclude(==(.), List, R),
    sort(R, Sorted), % remove os duplicados
    length(R, Length), % se a lista sorted for de tamanho diferente da List significa que existiam duplicados
    length(Sorted, Length).

check_column(Board, Column) :-
    get_column_elems(Board, 1, Column, [], Res),
    check_repeats(Res).

check_row(Board, Row) :-
    RowsValues = [1,10,19,28,37,46,55,64,73],
    nth1(Row, RowsValues, Index),
    get_row_elems(Board, 1, Index, [], Res),
    check_repeats(Res).

check_block(Board, StartIndex) :-
    Idx1 is StartIndex,
    Idx2 is StartIndex + 1,
    Idx3 is StartIndex + 2,
    Idx4 is StartIndex + 9,
    Idx5 is StartIndex + 10,
    Idx6 is StartIndex + 11,
    Idx7 is StartIndex + 18,
    Idx8 is StartIndex + 19,
    Idx9 is StartIndex + 20,
    
    Indices = [Idx1,Idx2,Idx3,Idx4,Idx5,Idx6,Idx7,Idx8,Idx9],

    maplist(get_index(Board), Indices, Values),

    check_repeats(Values).

check_blocks(Board) :-
    BlockIndices = [1,4,7,28,31,34,55,58,61],
    forall(member(Index, BlockIndices), check_block(Board, Index)).

count_empty_spaces(Board, Count) :-
    include(=(.), Board, EmptySpaces),
    length(EmptySpaces, Count).

% check if a move is valid by checking if it violates the Sudoku rules
valid_move(Board, Index, Num, NextBoard) :-
    %Implementar recurssividade até conseguir inserir de 1 a 9
    index_into_pos(Index, X/Y),
    block_index(Index, BlockIndex),
    get_index(Board, Index, Elem),
    Elem == '.',
    set_pos(Board,Index,Num,TestBoard),
    %check_row(TestBoard, X),
    check_column(TestBoard, Y),
    check_block(TestBoard, BlockIndex),
    NextBoard = TestBoard.

find_empty_positions(Board, List) :-
    findall(Index, (
        nth1(Index, Board, '.')
        ), List).

find_empty_position(Board, Index) :-
    index_of_dot(Board, 1, Index).

index_of_dot([H|_], Index, Index) :-
    H = '.', !.

index_of_dot([_|T], Position, Index) :-
    NextPosition is Position + 1,
    index_of_dot(T, NextPosition, Index).

set_pos(Board, Index, Num, NextBoard) :-
    nth1(Index, Board, Elem, TempBoard),
    nth1(Index, NextBoard, Num, TempBoard).

block_index(Index, BlockIndex) :-
    Index > 0,
    Index =< 81,
    BlockSize is 3,
    RowIndex is (Index - 1) // 9 + 1,
    ColIndex is (Index - 1) mod 9 + 1,
    BlockRow is (RowIndex - 1) // BlockSize,
    BlockCol is (ColIndex - 1) // BlockSize,
    BlockIndex is BlockSize * BlockRow + BlockCol + 1.






