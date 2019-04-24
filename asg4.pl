%(* /*
%* CSCI3180 Principles of Programming Languages
% *
% * --- Declaration ---
%*
% * I declare that the assignment here submitted is original except for source
% * material explicitly acknowledged. I also acknowledge that I am aware of
% * University policy and regulations on honesty in academic work, and of the
% * disciplinary guidelines and procedures applicable to breaches of such policy
% * and regulations, as contained in the website
% * http://www.cuhk.edu.hk/policy/academichonesty/
% *
% * Assignment 4
% * Name : Rustami Ubaydullo
% * Student ID : 1155102622
% * Email Addr : 1155102622@link.cuhk.edu.hk
% */ *)


sum(0,X,X).
sum(s(X),Y,s(Z)) :- sum(X,Y,Z).

% 1.a Rules
natNum(0).
natNum(s(X)) :- natNum(X).

% 1.b Rules
lt(0,s(_)).
lt(s(X),s(Y)) :- lt(X,Y).

% 1.c Query
% ?- lt(X,s(s(s(0)))).

% 1.d Rules
geq(T, T).
geq(_,0).
geq(X,Y) :- lt(Y,X).

% 1.e Rules
max(X,Y,Z) :- geq(X,Y), X=Z.
max(X,Y,Z) :- geq(Y,X), Y=Z.

% 1.f Rules
difference(X,Y,Z) :- sum(Z,Y,X), geq(X,Y).

% 1.g Rules Credit: Huzeyfe Kiran
mod(X,Y,Z) :- lt(Z,Y), geq(X,Z), difference(X,Z,D), multiple(Y,D).
multiple(X,0) :- X=s(_).
multiple(X,Y) :- X=s(_), Y=s(_), geq(Y,X), difference(Y,X,D), multiple(X,D).

% 2.a Rules
% bt(a,bt(b,nil,bt(d,nil,nil)),bt(c,bt(e,bt(f,nil,nil),bt(g,nil,nil)),nil)).

% 2.b Rules
isTree(nil).
isTree(bt(_,L,R)) :- isTree(L), isTree(R).

% 2.c Rules
isLeaf(E,bt(E,nil,nil)).
isLeaf(E,bt(Rt,L,R)) :- isTree(bt(Rt,L,R)),isLeaf(E,L).
isLeaf(E,bt(Rt,L,R)) :- isTree(bt(Rt,L,R)),isLeaf(E,R).

% 2.d Rules Credit: Huzeyfe Kiran
numberOfLeaf(nil,N) :- N=0.
numberOfLeaf(bt(E,nil,nil),N) :- isTree(bt(E,nil,nil)), N=s(0).
numberOfLeaf(bt(Rt,L,R),N) :- isTree(bt(Rt,L,R)), numberOfLeaf(L,LN), numberOfLeaf(R,RN), sum(LN,RN,N).

% 2.e Rules Credit: Huzeyfe Kiran
height(nil,N) :- N=0.
height(bt(_Rt,nil,nil),N) :- N=s(0).
height(bt(Rt,L,R),N) :- isTree(bt(Rt,L,R)), height(L,LH), height(R,RH), max(RH,LH,M), sum(s(0),M,N).
