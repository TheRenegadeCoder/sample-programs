:- initialization(main).

baklava(N, NE) :-
    forall(between(N, NE, X), baklava_line(X)).

baklava_line(N) :-
    NSP is abs(N),
    NST is 21 - 2 * NSP,
    output_repeat(" ", NSP),
    output_repeat("*", NST),
    nl.

output_repeat(S, N) :-
    forall(between(1, N, _), write(S)).

main() :-
    baklava(-10, 10),
    halt.
