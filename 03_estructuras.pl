% Autor: Ismael Arce
% Legajo: 51895
% Comision: 2K7
% Materia: Paradigmas de Programacion - Paradigma Logico

% ===== PARADIGMA LOGICO - ESTRUCTURAS DE DATOS =====

% ---------- 21. Arbol ----------
% Cada nodo es un functor persona(nombre, dni, edad)
per(r,persona(r,10000001,70)).
per(a,persona(a,10000002,50)).
per(b,persona(b,10000003,48)).
per(c,persona(c,10000004,45)).
per(d,persona(d,10000005,25)).
per(e,persona(e,10000006,27)).
per(f,persona(f,10000007,24)).
per(g,persona(g,10000008,22)).
per(h,persona(h,10000009,3)).
per(i,persona(i,10000010,2)).
per(j,persona(j,10000011,1)).
per(k,persona(k,10000012,4)).

% arco(Padre,Hijo)
arco(r,a). arco(r,b). arco(r,c).
arco(a,d). arco(a,e).
arco(e,h).
arco(b,f). arco(b,g).
arco(f,i). arco(f,j).
arco(g,k).

padre(P,H) :- arco(NP,NH), per(NP,P), per(NH,H).

descendiente(X,N) :- padre(N,X).
descendiente(X,N) :- padre(N,Y), descendiente(X,Y).

ascendiente(X,N) :- padre(X,N).
ascendiente(X,N) :- padre(Y,N), ascendiente(X,Y).

% Uso: mostrarDescendientes(a).  mostrarAscendientes(h).
mostrarDescendientes(Nombre) :- per(Nombre,N), descendiente(X,N), write(X), nl, fail.
mostrarDescendientes(_).

mostrarAscendientes(Nombre) :- per(Nombre,N), ascendiente(X,N), write(X), nl, fail.
mostrarAscendientes(_).

% ---------- 22. parejas ----------
% Falla si las listas tienen distinta longitud
parejas([],[],[]).
parejas([A|T1],[B|T2],[(A,B)|R]) :- parejas(T1,T2,R).

% ---------- 23. Base de datos de personas ----------
% persona(Nombre, Telefono, Sexo, Edad)   Sexo: m / f
persona(juan,'4251111',m,30).
persona(maria,'4252222',f,28).
persona(pedro,'4253333',m,19).
persona(ana,'4254444',f,45).
persona(luis,'4255555',m,50).
persona(laura,'4256666',f,17).

casado(juan,maria).
casado(luis,ana).

visita(maria,pedro).
visita(ana,juan).
visita(pedro,laura).

existe(N) :- persona(N,_,_,_).

mostrarPersonas :- persona(N,T,S,E), write(persona(N,T,S,E)), nl, fail.
mostrarPersonas.

mujeres :- persona(N,T,f,E), write(persona(N,T,f,E)), nl, fail.
mujeres.

varonesMayores21 :- persona(N,T,m,E), E > 21, write(persona(N,T,m,E)), nl, fail.
varonesMayores21.

% casado con telefono: telefono de X, casado con Y
casadoTel(X,Y,Tel) :- casado(X,Y), persona(X,Tel,_,_).

mostrarCasados :- casado(X,Y), write(X), write(' esta casado con '), write(Y), nl, fail.
mostrarCasados.

% c(X): X esta casado con alguien (Y) que visita a un varon (Z).
% Sirve para encontrar las personas cuyo conyuge visita a un hombre.
c(X) :- casado(X,Y), visita(Y,Z), persona(Z,_,m,_).

% ---------- 24. Grafo (dirigido) ----------
% conectado(Origen, Destino, Distancia)
conectado(mendoza,san_juan,160).
conectado(mendoza,san_luis,280).
conectado(san_juan,cordoba,480).
conectado(san_luis,buenos_aires,710).
conectado(cordoba,buenos_aires,540).
conectado(cordoba,misiones,950).
conectado(cordoba,san_luis,350).
conectado(cordoba,santa_fe,280).
conectado(misiones,santa_fe,570).

% Existe camino entre dos ciudades
camino(A,B) :- conectado(A,B,_).
camino(A,B) :- conectado(A,C,_), camino(C,B).

% Distancia total entre dos ciudades (una solucion por cada camino posible)
distancia(A,B,D) :- conectado(A,B,D).
distancia(A,B,D) :- conectado(A,C,D1), distancia(C,B,D2), D is D1+D2.

% Lista de ciudades por las que se pasa
ruta(A,B,[A,B]) :- conectado(A,B,_).
ruta(A,B,[A|R]) :- conectado(A,C,_), ruta(C,B,R).

% Muestra las ciudades del camino con write
mostrarCamino(A,B) :- ruta(A,B,R), escribirRuta(R), nl, fail.
mostrarCamino(_,_).

escribirRuta([X]) :- write(X).
escribirRuta([X,Y|T]) :- write(X), write(' -> '), escribirRuta([Y|T]).
