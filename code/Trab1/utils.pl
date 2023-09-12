less_or_equal(X,Value):-
    X==Value,!
    ;%or
    X<Value.

greater_or_equal(X,Value):-
    X==Value,!
    ;%or
    X>Value.

%ler input
read_move(X/Y):-
    write('Next move?'),nl,
    read(X/Y),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads the user input to determine the next move    %
% And saves it to a coordenate format X/Y            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
read_move(X/Y):-
    write('Next move coordenates? (Format: a/1)'),nl,
    read(X/Y),nl.
