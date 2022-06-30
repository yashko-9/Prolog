initialPosition([4,2,1,v,6,3,7,8,5]).
finalPosition([1,2,3,4,5,6,7,8,v]).
dim(3).

maxDepth(Max) :-
    dim(N),
    Max is N*100.

replace_nth0(List, Index, OldElem, NewElem, NewList) :-
   nth0(Index,List,OldElem,Transfer),
   nth0(Index,NewList,NewElem,Transfer).

swap(List, Index, NewIndex, NewList) :-
    nth0(Index, List, A),
   	nth0(NewIndex, List, B),
    replace_nth0(List, Index, A, B, TmpList),
    replace_nth0(TmpList, NewIndex, B, A, NewList).

list_member(X,[X|_]).
list_member(X,[_|TAIL]) :- list_member(X,TAIL).

range(Low, Low, High).
range(Out,Low,High) :-
    NewLow is Low+1,
    NewLow =< High,
    range(Out, NewLow, High).

move(up, State, NewState) :-
    dim(N),
    nth0(P, State, v),
    P < (N * N) - N,
    NewPos is P + N,
	swap(State, P, NewPos, NewState).

move(down, State, NewState) :-
    dim(N),
    nth0(P, State, v),
    P >= N,
    NewPos is P - N,
	swap(State, P, NewPos, NewState).

move(left, State, NewState) :-
    dim(N),
    nth0(P, State, v),
    mod(P + 1, N) =\= 0,
    NewPos is P + 1,
    swap(State, P, NewPos, NewState).

move(right, State, NewState) :-
    dim(N),
    nth0(P, State, v),
    mod(P, N) =\= 0,
    NewPos is P - 1,
    swap(State, P, NewPos, NewState).

main :-
    search(Sol),
    write(Sol),
    nl,
    search_2(Sol),
    write(Sol),
    nl,
    search_3(Sol),
    write(Sol).

search(Sol) :-
    maxDepth(Max),
    length(_, D),
    D =< Max,
    write("Depth is "), write(D), write("\n"),
    initialPosition(S),
    id_search(S, Sol, [S], D).

id_search(State, [], _, _) :-
    finalPosition(State).
id_search(State, [Action|OtherActions], VisitedNodes, N) :-
    N > 0,
    move(Action, State, NewState),
    \+list_member(NewState, VisitedNodes),
    N1 is N - 1,
    id_search(NewState, OtherActions, [NewState|VisitedNodes], N1).

search_2(Sol) :-
    maxDepth(M),
    between(0, M, N),
    write("Depth is "), write(N), write("\n"),
    initialPosition(S),
    id_search(S, Sol, [S], N).

search_3(Sol) :-
    maxDepth(M),
    range(N, 0, M),
    write("Depth is "), write(N), write("\n"),
    initialPosition(S),
    id_search(S, Sol, [S], N).
