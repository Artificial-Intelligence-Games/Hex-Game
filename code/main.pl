:-consult('utils.pl').
:-consult('./model/board.pl').
:-consult('./model/player.pl').
:-consult('./view/view.pl').
:-consult('./algos/minimax.pl').
:-consult('./algos/alpha_beta.pl').

%Entry point fot the game
play :-
    nl, 
    write('------------------------------'),nl,
    write('Welcome to the Prolog Hex Game!'),nl,
    gamemode.


%Predicate to choose the gamemode
gamemode :-
    repeat,
    write(' Please choose the game mode  '), nl,
    write('------------------------------'), nl, nl,
    write('PvP (Player Vs Player) -->  1'), nl, nl,
    write('PvAI (Player Vs AI)    -->  2'), nl,
    read(Mode), nl,
    mode(Mode).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Makes the Player1 able to choose the color he wants %
% to play with when Player vs Player mode is choosen  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mode(1):-
    repeat,
    nl, write('Color for Player1? (w -> White, b -> Black)'), nl,
    write('PS: White goes first'), nl,
    read(Player), nl,
    (Player == 'w'; Player == 'b'),
    create_board(3, Board),
    playPvP(Board,'w').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Makes the Player able to choose the color he wants %
% to play with when Player vs AI mode is choosen     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mode(2):-
    repeat,
    nl, write('Algorithm for the AI? (1 -> Minimax, 2 -> AlphaBeta)'), nl,
    read(Algorithm),
    (   Algorithm =:= 1 -> AlgorithmName = "Minimax";
        Algorithm =:= 2 -> AlgorithmName = "AlphaBeta";
        write('Incorrect number for Algorithm, please select it again'),nl, mode(2)
    ),
    nl, write(AlgorithmName), write(' Selected.'), nl,
    write('You are playing as Black Pieces. Good Luck and Have Fun!'), nl, nl,
    create_board(3, Board),
    playPvAI(Algorithm, Board,'w').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recursive Predicate that queries the next play,    %
% analyses it, and inserts it.                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
playPvP(Board, Player):-
    player_to_string(Player,PlayerString),
    write(PlayerString), write('''s Turn'), nl,
    print_board(Board),
    read_move(X/Y),
    ( analyse_move(Board,X/Y) 
    -> %If Move is Valid% 
    insert(Board, X/Y, Player, NewBoard),
    ( 
        is_game_over(NewBoard,Player) -> 
        print_board(NewBoard), 
        winner(Player) 
        ;
        next_player(Player, NextPlayer),
        playPvP(NewBoard, NextPlayer)
    )
    ; %If Move is Invalid% 
      write('Invalid Move, please check the required coordenate format.'),nl,
      playPvP(Board, Player)
    ).

playPvAI(Algorithm, Board, Player):-
    next_player(Player, NextPlayer),
    print_board(Board),
    makeMoveAI(Algorithm, Board, Player, NewPos),
    NewPos = (B1, P1),
    print_board(B1),
    (is_game_over(B1, Player) -> winner(Player) ; 
    read_move(B1, X/Y),
    insert(B1, X/Y, NextPlayer, NewBoard),
    (is_game_over(NewBoard, NextPlayer) -> print_board(NewBoard), winner(NextPlayer) ;
        playPvAI(Algorithm, NewBoard, Player)
    )
    ).
    
makeMoveAI(Algorithm, Board, Player, NewPos):-
    write('Computer is playing ... '), nl,
    Pos = (Board, Player),
    statistics(runtime, [Start|_]),
    (Algorithm = 1 -> minimax(Pos, NewPos, _) ; alphabeta(Pos, -inf, +inf, NewPos, _)),
    statistics(runtime, [End|_]),
    Time is End - Start,
    NewTime = Time / 1000,
    format('Execution time: ~3f seconds', [NewTime]),nl.

%%%%%%%%%%%%%
% UTILITIES %
%%%%%%%%%%%%%
player_to_string(Player,PlayerString):-
    (Player == 'w' -> PlayerString = 'White' ; PlayerString = 'Black').

path_start(Board, 'b', StartingPosList) :-
    length(Board, Size),
    findall(Pos, (
        between(1, Size, X),
        get_elem_board(Board, X/1, ResElem),
        check_same_player('b', ResElem),
        Pos = X/1
        ), StartingPosList),
        \+ StartingPosList = [].

path_start(Board, 'w', StartingPosList) :-
    length(Board, Size),
    findall(Pos, (
        between(1, Size, Y),
        get_elem_board(Board, 1/Y, ResElem),
        check_same_player('w', ResElem),
        Pos = 1/Y
        ), StartingPosList),
        \+ StartingPosList = [].

dfs_full_board(Board, Player, X/Y, Visited) :-
    length(Board, Size),
    \+ member(X/Y, Visited),
    get_neighbours(Board, Player, X/Y, NeighbourList),
    member(Pos, NeighbourList),
    (
        other_side(Size, Pos, Player)
        ;
        dfs_full_board(Board, Player, Pos, [X/Y | Visited])
    ).

other_side(Size, Size/_, 'w').
other_side(Size, _/Size, 'b').

is_game_over(Board, Player) :-
    path_start(Board, Player, Pos_List),
    member(Pos, Pos_List),
    dfs_full_board(Board, Player, Pos, []), !.
    

simulated_play(Board, Player, NewBoard) :-
    length(Board, Size),
    between(1, Size, X),
    between(1, Size, Y),
    get_elem_board(Board, X/Y, Elem),
    Elem == '.', % Empty position
    insert(Board, X/Y, Player, NewBoard).

terminal_node(Board) :-
    is_game_over(Board, 'w'), !;
    is_game_over(Board, 'b'), !.

moves(Pos, PosList):-
    Pos = (Board, Player),
    length(Board, Size),
    next_player(Player, NextPlayer),
    \+ terminal_node(Board),
    findall(CurrElem, (
        simulated_play(Board, Player, NewBoard),
        CurrElem = (NewBoard, NextPlayer)
    ), PosList),
    \+ PosList = [], !
    ;
    fail.

 staticval(Pos, Val) :-
    Pos = (Board, Player),
       (is_game_over(Board, 'w'), Val = 1,! % Black Won
        ; 
        Val = -1). % White Won

 min_to_move(Pos) :-
    Pos = (Board, Player),
    Player == 'b'.
 
 max_to_move(Pos) :-
    Pos = (Board, Player),
    Player == 'w'.
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads the user input to determine the next move    %
% And saves it to a coordenate format X/Y            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
letter_position(Letter, Position) :-
    alphabet(Alphabet),
    nth1(Position, Alphabet, Letter).

alphabet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).

read_move(Board, X/Y) :-
    repeat,
    write('Next move coordinates? (Format: 1/a)'), nl,
    read(X/Letter), nl,
    letter_position(Letter, Y),
    (analyse_move(Board, X/Y) ->
        true
    ; 
        write('Invalid Move, please check the required coordinate format.'), nl,
        fail
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

winner(Player):-
    (Player == 'b' -> (write('Black Player Won'),nl) ; (write('White Player Won'),nl)).
