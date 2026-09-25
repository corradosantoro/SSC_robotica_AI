

% object(X) ---> X is an object
% table(X) ---> X is on the table
% upon(X,Y) ---> X is upon Y

:-
    assert(object(cube)),
    assert(object(cylinder)),
    assert(object(prism)),
    assert(object(ring)),
    assert(upon(cube, cylinder)),
    assert(table(cylinder)),
    assert(table(prism)),
    assert(table(ring)).

    % object X is free
    free(X) :- object(X), \+upon(_,X).

    % put object X upon object Y
    put(X, table) :- free(X), upon(X,Y), retract(upon(X, Y)), assert(table(X)).
    put(X, Y) :- free(X), free(Y), table(X), retract(table(X)), assert(upon(X, Y)).
    put(X, Y) :- free(X), free(Y), upon(X, Z), retract(upon(X, Z)), assert(upon(X, Y)).

