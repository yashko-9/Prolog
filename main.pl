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
    initialPosition(S),
    write(S).

start:-
  id(S),
  write(S).

id(Sol):-
  maxDepth(D),
  initialPosition(S),
  length(_, L),
  L =< D,
  write("Depth is "), write(L), write("\n"),
  id_search(S, Sol, [S], L),
  write("\n"),
  write(Sol).

id_search(S, [], _, _):- 
  finalPosition(S).
id_search(S, [Action|OtherActions], VisitedNodes, N):-
  N>0,
  move(Action, S, NewS),
  \+member(NewS, VisitedNodes),
  N1 is N-1,
  id_search(NewS, OtherActions, [NewS|VisitedNodes], N1).
