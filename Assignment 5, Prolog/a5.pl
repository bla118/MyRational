fill(N, _, Lst) :-
   N =< 0,
   Lst = [].
fill(N,X,[H|T]) :-
   Iter = N - 1,
   H = X,
   fill(Iter, X, T).  

numlist2(Lo, Lo, [Lo]) :- !.
numlist2(Lo, Hi, [Lo|Rest]) :-
    Lo =< Hi,
    Z is Lo + 1,
    numlist2(Z, Hi, Rest).

% https://hpincket.com/prolog-exercise-min-and-max-of-a-list.html
minmax([A], A, A).
minmax([H|R], Min, Max):-
    minmax(R, RN, RX),
    Min is min(H, RN),
    Max is max(H, RX).


split([], [], []).
split([Head|Tail], [Head|List1], List2) :- Head<0, split(Tail, List1, List2).
split([Head|Tail], List1, [Head|List2]) :- Head>=0, split(Tail, List1, List2).

negpos(L, A, B) :-
   msort(L, Sorted),
   split(Sorted, A, B).

% https://tjd1234.github.io/cmpt383summer2022/languages/prolog/prolog_combinatorial.html
alpha([T, I, M, B, Y, U], Tim, Bit, Yumyum) :-
    between(1, 9, T),
    between(0, 9, I), T \= I,
    between(0, 9, M), \+ member(M, [T,I]),       
    between(1, 9, B), \+ member(B, [T,I,M]),
    between(1, 9, Y), \+ member(Y, [T,I,M,B]),
    between(0, 9, U), \+ member(U, [T,I,M,B,Y]),
    Tim  is           T*100 + I*10 + M,
    Bit  is           B*100 + I*10 + T,
    Yumyum is Y*100000 + U*10000 + M*1000 + Y*100 + U*10 + M,
    Yumyum is Tim * Bit.


list_sum([],0).
list_sum([Head|Tail], TotalSum):-
list_sum(Tail, Sum1),
TotalSum is Head+Sum1.

% https://stackoverflow.com/questions/10245405/prolog-finding-all-3x3-magic-squares-without-using-clpfd
magic(L9, Result, N) :-
    Result = [A, B, C,
         D, E, F,
         G, H, I],
    flatten(Result, LF),
    init(LF, L9),
    list_sum(L9, Sum),
    N is Sum / 3,
    N is A + B + C,
    N is D + E + F,
    N is G + H + I,
    N is A + D + G,
    N is B + E + H,
    N is C + F + I.

init([H|T], L) :-
    select(H, L, L1),
    init(T, L1).
init([], []).

mother(amy, paul).
mother(amy, susan).


twice(N, Result) :- Result is 2 * N.

len([], 0).
len([_|Xs], L) :-
    len(Xs, Rest_len),
    L is 1 + Rest_len.