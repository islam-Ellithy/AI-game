alphabetamax(State,Depth,_,_,Ret,_):-
        (isTerminal(State,_);Depth=0),!,
        getHeuristic(State,Ret)/*,write(State), write(Ret),nl*/.

alphabetamax5x5(State,Depth,_,_,Ret,_):-
        (isTerminal(State,_);Depth=0),!,
        getHeuristic(State,Ret)/*,write(State), write(Ret),nl*/.

alphabetamin(State,Depth,_,_,Ret,_):-
        (isTerminal(State,_);Depth=0),!,
        getHeuristic(State,Ret)/*,write(State), write(Ret),nl*/.

alphabetamin5x5(State,Depth,_,_,Ret,_):-
        (isTerminal(State,_);Depth=0),!,
        getHeuristic(State,Ret)/*,write(State), write(Ret),nl*/.

alphabetamax(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren(State,Children),
        selectChildmax(Children,State,Depth,Alpha,Beta,Ret,_,Next).

alphabetamax5x5(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren5x5(State,Children),
        selectChildmax5x5(Children,State,Depth,Alpha,Beta,Ret,_,Next).

alphabetamin(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren(State,Children),
        selectChildmin(Children,State,Depth,Alpha,Beta,Ret,_,Next).

alphabetamin5x5(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren5x5(State,Children),
        selectChildmin5x5(Children,State,Depth,Alpha,Beta,Ret,_,Next).
	
min(A,B,A,VA,_,VA):-
        B>=A,!.
min(_,B,B,_,VB,VB).

max(A,B,A,VA,_,VA):-
        A>=B,!.
max(_,B,B,_,VB,VB).


selectChildmax(_,_,A,B,A,_,_):-
        B=<A,!.

selectChildmax5x5(_,_,A,B,A,_,_):-
        B=<A,!.

selectChildmin(_,_,A,B,B,_,_):-
        B=<A,!.

selectChildmin5x5(_,_,A,B,B,_,_):-
        B=<A,!.

		/*traverse children list to get best*/

selectChildmax([],_,_,Alpha,_,Alpha,BestTillNow,BestTillNow).

selectChildmax5x5([],_,_,Alpha,_,Alpha,BestTillNow,BestTillNow).

selectChildmin([],_,_,_,Beta,Beta,BestTillNow,BestTillNow).

selectChildmin5x5([],_,_,_,Beta,Beta,BestTillNow,BestTillNow).

selectChildmax([s(Turn,S)|T],s(Turn,V),Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
		!,
        NDepth is Depth -1,
        alphabetamax(s(Turn,S),NDepth,Alpha,Beta,NRet,_),
        max(Alpha,NRet,UpdetedAlpha,BestTillNow,s(Turn,S),NewBest),
        selectChildmax(T,s(Turn,V),Depth,UpdetedAlpha,Beta,Ret,NewBest,SelectChild).

selectChildmax5x5([s(Turn,S)|T],s(Turn,V),Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
		!,
        NDepth is Depth -1,
        alphabetamax5x5(s(Turn,S),NDepth,Alpha,Beta,NRet,_),
        max(Alpha,NRet,UpdetedAlpha,BestTillNow,s(Turn,S),NewBest),
        selectChildmax5x5(T,s(Turn,V),Depth,UpdetedAlpha,Beta,Ret,NewBest,SelectChild).
        
selectChildmin([s(Turn,S)|T],s(Turn,V),Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
		!,
        NDepth is Depth -1,
        alphabetamin(s(Turn,S),NDepth,Alpha,Beta,NRet,_),
        min(Beta,NRet,UpdetedBeta,BestTillNow,s(Turn,S),NewBest),
        selectChildmin(T,s(Turn,V),Depth,Alpha,UpdetedBeta,Ret,NewBest,SelectChild).

selectChildmin5x5([s(Turn,S)|T],s(Turn,V),Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
		!,
        NDepth is Depth -1,
        alphabetamin5x5(s(Turn,S),NDepth,Alpha,Beta,NRet,_),
        min(Beta,NRet,UpdetedBeta,BestTillNow,s(Turn,S),NewBest),
        selectChildmin5x5(T,s(Turn,V),Depth,Alpha,UpdetedBeta,Ret,NewBest,SelectChild).


selectChildmax([H|T],State,Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamin(H,NDepth,Alpha,Beta,NRet,_),
        max(Alpha,NRet,UpdetedAlpha,BestTillNow,H,NewBest),
        selectChildmax(T,State,Depth,UpdetedAlpha,Beta,Ret,NewBest,SelectChild).

selectChildmax5x5([H|T],State,Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamin5x5(H,NDepth,Alpha,Beta,NRet,_),
        max(Alpha,NRet,UpdetedAlpha,BestTillNow,H,NewBest),
        selectChildmax5x5(T,State,Depth,UpdetedAlpha,Beta,Ret,NewBest,SelectChild).
        
selectChildmin([H|T],State,Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamax(H,NDepth,Alpha,Beta,NRet,_),
        min(Beta,NRet,UpdetedBeta,BestTillNow,H,NewBest),
        selectChildmin(T,State,Depth,Alpha,UpdetedBeta,Ret,NewBest,SelectChild).
		
selectChildmin5x5([H|T],State,Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamax5x5(H,NDepth,Alpha,Beta,NRet,_),
        min(Beta,NRet,UpdetedBeta,BestTillNow,H,NewBest),
        selectChildmin5x5(T,State,Depth,Alpha,UpdetedBeta,Ret,NewBest,SelectChild).

		
getChildren(S,Ch):-
        bagof(X,move(S,X),Ch),!.
getChildren(_,[]).

getChildren5x5(S,Ch):-
        bagof(X,move5x5(S,X),Ch),!.
getChildren5x5(_,[]).

getNumOfSqrs(L,5,1):-
	N is 6,
	B is 8,
	NB is 9,
	\+members([5,B],L),
	\+members([5,N],L),
	\+members([N,NB],L),
	\+members([B,NB],L),!.

getNumOfSqrs5x5(L,29,1):-
	N is 30,
	B is 35,
	NB is 36,
	\+members([29,B],L),
	\+members([29,N],L),
	\+members([N,NB],L),
	\+members([B,NB],L),!.

	
getNumOfSqrs(_,5,0):-!.

getNumOfSqrs5x5(_,29,0):-!.
        
getNumOfSqrs(L,C,Num):-
	\+C mod 3 =:= 0,
	N is C + 1,
	B is C + 3,
	NB is C + 4,
	\+members([C,B],L),
	\+members([C,N],L),
	\+members([N,NB],L),
	\+members([B,NB],L),
	getNumOfSqrs(L,N,Nu),
	Num is Nu + 1,!.

getNumOfSqrs5x5(L,C,Num):-
	\+C mod 6 =:= 0,
	N is C + 1,
	B is C + 6,
	NB is C + 7,
	\+members([C,B],L),
	\+members([C,N],L),
	\+members([N,NB],L),
	\+members([B,NB],L),
	getNumOfSqrs5x5(L,N,Nu),
	Num is Nu + 1,!.
	
getNumOfSqrs(L,C,Num):-
	N is C + 1,
	getNumOfSqrs(L,N,Num).

getNumOfSqrs5x5(L,C,Num):-
	N is C + 1,
	getNumOfSqrs5x5(L,N,Num).

/* problem dependant part */

/* generate childrens (moves) of a state  */
/* generate children of a state  */
move(s(x,[V,Us,As]),s(x,[NV,NUs,As])):-
        play(V,NV),
        getNumOfSqrs(NV,1,N),
        N > Us + As,
        NUs is Us + 1.

move5x5(s(x,[V,Us,As]),s(x,[NV,NUs,As])):-
        play(V,NV),
        getNumOfSqrs5x5(NV,1,N),
        N > Us + As,
        NUs is Us + 1.

        
move(s(o,[V,Us,As]),s(o,[NV,Us,NAs])):-
        play(V,NV),
        getNumOfSqrs(NV,1,N),
        N > Us + As,
        NAs is As + 1.

move5x5(s(o,[V,Us,As]),s(o,[NV,Us,NAs])):-
        play(V,NV),
        getNumOfSqrs5x5(NV,1,N),
        N > Us + As,
        NAs is As + 1.

        
move(s(x,[V,Us,As]),s(o,[NV,Us,As])):-
        play(V,NV),
        getNumOfSqrs(NV,1,N),
        N is Us + As.

move5x5(s(x,[V,Us,As]),s(o,[NV,Us,As])):-
        play(V,NV),
        getNumOfSqrs5x5(NV,1,N),
        N is Us + As.

move(s(o,[V,Us,As]),s(x,[NV,Us,As])):-
        play(V,NV),
        getNumOfSqrs(NV,1,N),
        N is Us + As.

move5x5(s(o,[V,Us,As]),s(x,[NV,Us,As])):-
        play(V,NV),
        getNumOfSqrs5x5(NV,1,N),
        N is Us + As.


play([_|T],T).
play([H|T],[H|NT]):-
        play(T,NT).

members(X,[X|_]).
members(X,[_|T]):-
        members(X,T).
        
remove(X,[X|T],T).
remove(X,[H|T],[H|NT]):-
		remove(X,T,NT).
/* get utility function of a state  if it is terminal*/
getHeuristic(s(_,[_,Us,As]),H):-
		H is As-Us .
		
/* get utility function of a state */
/*  count all possible when of a state if i want to count wins of x 
    then T term should be o to check against o  and vice versa 

    assuming that n wins = 8 (max possible wins )untill i found opponnent letter 
	then decrease number of wins by 1 through remove element from R list or C list or D1 list or D2 list
 using Row list and Column  list and diagonal1 list and diagonal2 list */

/* check if  a state is terminal */
isTerminal(s(_,[[],US,AS]),A):-
		US > AS,!,
		A = 'Win'.
isTerminal(s(_,[[],US,AS]),A):-
		AS > US,!,
		A = 'Lose'.
isTerminal(s(_,[[],_,_]),A):-
		A = 'Draw'.



playerMove([L,U,A],C,s(T,[NL,NU,NA])):-
		remove(C,L,NL),
		move(s(x,[L,U,A]),s(T,[NL,NU,NA])).
        
playerMove5x5([L,U,A],C,s(T,[NL,NU,NA])):-
		remove(C,L,NL),
		move5x5(s(x,[L,U,A]),s(T,[NL,NU,NA])).

run(S,D):-
        isTerminal(S,Win),!,
        write('Game over you '),
        write(Win),nl.
        
run(s(o,S),D):-
        alphabetamax(s(o,S),D,-30,30,_,NS),
        run(NS,D).

run(s(x,S),D):-
        write(S),nl,write('Select the cell number you want to play in and write its number followed by .'),
        read(C),
        playerMove(S,C,NS),
        run(NS,D).
run5x5(S,D):-
        isTerminal(S,Win),!,
        write('Game over you '),
        write(Win),nl.
        
run5x5(s(o,S),D):-
        alphabetamax5x5(s(o,S),D,-30,30,_,NS),
        run5x5(NS,D).

run5x5(s(x,S),D):-
        write(S),nl,write('Select the cell number you want to play in and write its number followed by .'),
        read(C),
        playerMove5x5(S,C,NS),
        run5x5(NS,D).


runeasy:-
        run(s(x,[[[1,2],[2,3],[4,5],[5,6],[7,8],[8,9],[1,4],[2,5],[3,6],[4,7],[5,8],[6,9]],0,0]),1).
        
        
runmedium:-
        run(s(x,[[[1,2],[2,3],[4,5],[5,6],[7,8],[8,9],[1,4],[2,5],[3,6],[4,7],[5,8],[6,9]],0,0]),3).
        
runhard:-
        run(s(x,[[[1,2],[2,3],[4,5],[5,6],[7,8],[8,9],[1,4],[2,5],[3,6],[4,7],[5,8],[6,9]],0,0]),5).

runeasy5x5:-
        run5x5(s(x,[[[1,2],[2,3],[3,4],[4,5],[5,6],[7,8],[8,9],[9,10],[10,11],[11,12]
        		,[13,14],[14,15],[15,16],[16,17],[17,18],[19,20],[20,21],[21,22],[22,23],[23,24],
        		[25,26],[26,27],[27,28],[28,29],[29,30],[31,32],[32,33],[33,34],[34,35],[35,36],[1,7],[2,8]
        		,[3,9],[4,10],[5,11],[6,12],[7,13],[8,14],[9,15],[10,16],[11,17],[12,18],[13,19],[14,20]
        		,[15,21],[16,22],[17,23],[18,24],[19,25],[20,26],[21,27],[22,28],[23,29],[24,30],[25,31],
        		[26,32],[27,33],[28,34],[29,35],[30,36]],0,0]),1).
        
        
runmedium5x5:-
        run5x5(s(x,[[[1,2],[2,3],[3,4],[4,5],[5,6],[7,8],[8,9],[9,10],[10,11],[11,12]
        		,[13,14],[14,15],[15,16],[16,17],[17,18],[19,20],[20,21],[21,22],[22,23],[23,24],
        		[25,26],[26,27],[27,28],[28,29],[29,30],[31,32],[32,33],[33,34],[34,35],[35,36],[1,7],[2,8]
        		,[3,9],[4,10],[5,11],[6,12],[7,13],[8,14],[9,15],[10,16],[11,17],[12,18],[13,19],[14,20]
        		,[15,21],[16,22],[17,23],[18,24],[19,25],[20,26],[21,27],[22,28],[23,29],[24,30],[25,31],
        		[26,32],[27,33],[28,34],[29,35],[30,36]],0,0]),3).
        
runhard5x5:-
        run5x5(s(x,[[[1,2],[2,3],[3,4],[4,5],[5,6],[7,8],[8,9],[9,10],[10,11],[11,12]
        		,[13,14],[14,15],[15,16],[16,17],[17,18],[19,20],[20,21],[21,22],[22,23],[23,24],
        		[25,26],[26,27],[27,28],[28,29],[29,30],[31,32],[32,33],[33,34],[34,35],[35,36],[1,7],[2,8]
        		,[3,9],[4,10],[5,11],[6,12],[7,13],[8,14],[9,15],[10,16],[11,17],[12,18],[13,19],[14,20]
        		,[15,21],[16,22],[17,23],[18,24],[19,25],[20,26],[21,27],[22,28],[23,29],[24,30],[25,31],
        		[26,32],[27,33],[28,34],[29,35],[30,36]],0,0]),5).
 
       