% Autor: Ismael Arce
% Legajo: 51895
% Comision: 2K7
% Materia: Paradigmas de Programacion - Paradigma Logico

% ===== PARADIGMA LOGICO - TRATAMIENTO DE LISTAS =====

% Auxiliares
conc([],L,L).
conc([H|T],L,[H|R]) :- conc(T,L,R).

pertenece(X,[X|_]).
pertenece(X,[Y|T]) :- X \= Y, pertenece(X,T).

% 7. predecesor(L,R): elementos de L >= a su predecesor (el primero siempre va)
predecesor([],[]).
predecesor([X|T],[X|R]) :- predAux(X,T,R).

predAux(_,[],[]).
predAux(P,[X|T],[X|R]) :- X >= P, predAux(X,T,R).
predAux(P,[X|T],R)     :- X < P,  predAux(X,T,R).

% 8. rotada(L,N,P): L rotada N posiciones a la izquierda
rotada(L,N,P) :- rotarIzq(L,N,P).

% 9. suma(S,L)
suma(0,[]).
suma(S,[C|Q]) :- suma(P,Q), S is P+C.

% 10. cantidad(L,N)
cantidad([],0).
cantidad([_|T],N) :- cantidad(T,M), N is M+1.

% 11. ultimo(L,U)
ultimo([U],U).
ultimo([_|T],U) :- ultimo(T,U).

% 12. inversa(L,I)
inversa(L,I) :- inversaAux(L,[],I).
inversaAux([],Acc,Acc).
inversaAux([H|T],Acc,I) :- inversaAux(T,[H|Acc],I).

% 13. sacar(P,L,R): R es L sin el elemento de la posicion P (1 = primero)
sacar(1,[_|T],T).
sacar(P,[H|T],[H|R]) :- P > 1, Q is P-1, sacar(Q,T,R).

% 14. eliminar(L,E,R): elimina E (una sola ocurrencia)
eliminar([E|T],E,T).
eliminar([H|T],E,[H|R]) :- H \= E, eliminar(T,E,R).

% 15. eliminarTodos(L,E,R): elimina todas las instancias de E
% (se llama distinto de eliminar/3 para que no se mezclen las clausulas)
eliminarTodos([],_,[]).
eliminarTodos([E|T],E,R) :- eliminarTodos(T,E,R).
eliminarTodos([H|T],E,[H|R]) :- H \= E, eliminarTodos(T,E,R).

% 16. intersec(L1,L2,L3)
intersec([],_,[]).
intersec([H|T],L2,[H|R]) :- pertenece(H,L2), intersec(T,L2,R).
intersec([H|T],L2,R)     :- \+ pertenece(H,L2), intersec(T,L2,R).

% 17. rotarIzq(L,N,R)
rotarIzq(L,N,L) :- N =:= 0.
rotarIzq([],N,[]) :- N > 0.
rotarIzq([H|T],N,R) :- N > 0, M is N-1, conc(T,[H],L2), rotarIzq(L2,M,R).

% 18. insertarEn(E,L,P,R): inserta E en la posicion P (1 = al principio)
insertarEn(E,L,1,[E|L]).
insertarEn(E,[H|T],P,[H|R]) :- P > 1, Q is P-1, insertarEn(E,T,Q,R).

% 19. insOrden(E,O,D): inserta E en la lista ordenada O
insOrden(E,[],[E]).
insOrden(E,[H|T],[E,H|T]) :- E =< H.
insOrden(E,[H|T],[H|R])   :- E > H, insOrden(E,T,R).

% 20. ordenada(L,O): O es L ordenada (usa insOrden)
ordenada([],[]).
ordenada([H|T],O) :- ordenada(T,O1), insOrden(H,O1,O).
