

print_board(Board) :-
    writeln(' - - - - - - - - - - - -'),
    write('| '), print_elem(Board, 1), write(' '), print_elem(Board, 2), write(' '), print_elem(Board, 3), write(' '), write('|'), write(' '), print_elem(Board, 4), write(' '), print_elem(Board, 5), write(' '), print_elem(Board, 6), write(' '), write('|'), write(' '), print_elem(Board, 7), write(' '), print_elem(Board, 8), write(' '), print_elem(Board, 9), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 10), write(' '), print_elem(Board, 11), write(' '), print_elem(Board, 12), write(' '), write('|'), write(' '), print_elem(Board, 13), write(' '), print_elem(Board, 14), write(' '), print_elem(Board, 15), write(' '), write('|'), write(' '), print_elem(Board, 16), write(' '), print_elem(Board, 17), write(' '), print_elem(Board, 18), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 19), write(' '), print_elem(Board, 20), write(' '), print_elem(Board, 21), write(' '), write('|'), write(' '), print_elem(Board, 22), write(' '), print_elem(Board, 23), write(' '), print_elem(Board, 24), write(' '), write('|'), write(' '), print_elem(Board, 25), write(' '), print_elem(Board, 26), write(' '), print_elem(Board, 27), write(' '), write('|'), nl,
    writeln(' - - - - - - - - - - - -'),
    write('| '), print_elem(Board, 28), write(' '), print_elem(Board, 29), write(' '), print_elem(Board, 30), write(' '), write('|'), write(' '), print_elem(Board, 31), write(' '), print_elem(Board, 32), write(' '), print_elem(Board, 33), write(' '), write('|'), write(' '), print_elem(Board, 34), write(' '), print_elem(Board, 35), write(' '), print_elem(Board, 36), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 37), write(' '), print_elem(Board, 38), write(' '), print_elem(Board, 39), write(' '), write('|'), write(' '), print_elem(Board, 40), write(' '), print_elem(Board, 41), write(' '), print_elem(Board, 42), write(' '), write('|'), write(' '), print_elem(Board, 43), write(' '), print_elem(Board, 44), write(' '), print_elem(Board, 45), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 46), write(' '), print_elem(Board, 47), write(' '), print_elem(Board, 48), write(' '), write('|'), write(' '), print_elem(Board, 49), write(' '), print_elem(Board, 50), write(' '), print_elem(Board, 51), write(' '), write('|'), write(' '), print_elem(Board, 52), write(' '), print_elem(Board, 53), write(' '), print_elem(Board, 54), write(' '), write('|'), nl,
    writeln(' - - - - - - - - - - - -'),
    write('| '), print_elem(Board, 55), write(' '), print_elem(Board, 56), write(' '), print_elem(Board, 57), write(' '), write('|'), write(' '), print_elem(Board, 58), write(' '), print_elem(Board, 59), write(' '), print_elem(Board, 60), write(' '), write('|'), write(' '), print_elem(Board, 61), write(' '), print_elem(Board, 62), write(' '), print_elem(Board, 63), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 64), write(' '), print_elem(Board, 65), write(' '), print_elem(Board, 66), write(' '), write('|'), write(' '), print_elem(Board, 67), write(' '), print_elem(Board, 68), write(' '), print_elem(Board, 69), write(' '), write('|'), write(' '), print_elem(Board, 70), write(' '), print_elem(Board, 71), write(' '), print_elem(Board, 72), write(' '), write('|'), nl,
    write('| '), print_elem(Board, 73), write(' '), print_elem(Board, 74), write(' '), print_elem(Board, 75), write(' '), write('|'), write(' '), print_elem(Board, 76), write(' '), print_elem(Board, 77), write(' '), print_elem(Board, 78), write(' '), write('|'), write(' '), print_elem(Board, 79), write(' '), print_elem(Board, 80), write(' '), print_elem(Board, 81), write(' '), write('|'), nl,
    writeln(' - - - - - - - - - - - -').

print_elem(Board, Index) :-
    index_into_pos(Index, X/Y),
    get_elem(Board, X/Y, Elem),
    write(Elem).

