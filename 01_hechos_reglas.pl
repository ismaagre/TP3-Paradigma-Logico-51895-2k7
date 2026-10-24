% Autor: Ismael Arce
% Legajo: 51895
% Comision: 2K7
% Materia: Paradigmas de Programacion - Paradigma Logico

% ===== PARADIGMA LOGICO - HECHOS Y REGLAS =====

% 1. par(N): verdadero si N es par (sin usar mod)
par(0).
par(N) :- N > 1, M is N-2, par(M).

% 2. suma(N,S): S es la sumatoria de los primeros N numeros pares (2,4,...,2N)
suma(0,0).
suma(N,S) :- N > 0, M is N-1, suma(M,P), S is P + 2*N.

% 3. potencia(B,E,V): V es B elevado a la E
potencia(_,0,1).
potencia(B,E,V) :- E > 0, Y is E-1, potencia(B,Y,M), V is B*M.

% 4. fibonacci(N,R): R es el N-esimo termino (fib(0)=0, fib(1)=1)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,R) :- N > 1, A is N-1, B is N-2,
                  fibonacci(A,RA), fibonacci(B,RB), R is RA+RB.

% 5. Circuito logico
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

not(0,1).
not(1,0).

% Cada entrada pasa por un NOT y se combina con un AND con la otra entrada;
% las dos salidas de los AND entran a un OR (equivale a un XOR).
circuito(Q1,Q2,S) :- not(Q1,N1), not(Q2,N2),
                     and(N1,Q2,A1), and(Q1,N2,A2),
                     or(A1,A2,S).

% 6. Diagnostico
sintoma(juan,fiebre).
sintoma(juan,tos).
sintoma(juan,dolor_garganta).
sintoma(ana,fiebre).
sintoma(ana,dolor_cabeza).
sintoma(pedro,estornudos).

enfermedad(gripe,fiebre).
enfermedad(gripe,tos).
enfermedad(gripe,dolor_cabeza).
enfermedad(resfrio,estornudos).
enfermedad(resfrio,tos).
enfermedad(anginas,dolor_garganta).
enfermedad(anginas,fiebre).

% P tiene el sintoma S, y la enfermedad E presenta ese sintoma
diagnostico(P,S,E) :- sintoma(P,S), enfermedad(E,S).
