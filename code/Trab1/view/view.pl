%:-consult('../utils.pl').
%:-consult('../model/board.pl').
%:-consult('../model/player.pl').

print_board([], _).
print_board([H | T], N) :-
       write(N), write(' '), write(H), write(' '),write(N), nl,
    N1 is N + 1,
    print_board(T, N1).

print_board(Board) :-
  length(Board, Size),
  write(' '),
  generate_board_letters(Size, 'A', ''),
  print_rows(Board, 1, ' '),
  write('  '),
  generate_board_letters(Size, 'A', '').

generate_board_letters(0, Char, Sequence) :- write(Sequence), nl.
generate_board_letters(Size, Char, Sequence) :-
  string_concat('', Char, Base),
  string_concat(Base, ' ', FinalChar),
  string_concat(Sequence, FinalChar, NewSequence),
  char_code(Char, CharCode),
  Size > 0,
  NewCharCode is CharCode + 1,
  NewSize is Size - 1,
  char_code(NewChar, NewCharCode),
  generate_board_letters(NewSize, NewChar, NewSequence).


add_space(Space, NewSpace) :-
  write(Space),
  string_concat(Space, ' ', NewSpace).

print_rows([], _, Space).
print_rows([H | T], N, Space) :-
  write(N),
  write(' '),
  print_row(H),
  write(N),
  nl,
  add_space(Space, NewSpace),
  Idx is N + 1,
  print_rows(T, Idx, NewSpace).

print_row([]).
print_row(['b'| T]) :-
    write('\u2b21 '),
    print_row(T).
print_row(['w'| T]) :-
    write('\u2b22 '),
    print_row(T).
print_row(['.' | T]):-
    write('. '),
    print_row(T).
