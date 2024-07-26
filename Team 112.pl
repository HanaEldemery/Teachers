%e

ta(Name,Load).

ta_slot_assignment([ta(Name,Y)|T],[ta(Name,Y1)|T],Name):-
Y>0,
Y1 is Y-1.

ta_slot_assignment([ta(X,Y)|T],[ta(X,Y)|T1],Name):-
X\=Name,
ta_slot_assignment(T,T1,Name).

%c

%count counts the number of occurences of an element in a list 

count(_,[],0).

count(Ta,[H|T],X):-
dif(Ta,H),
count(Ta,T,X).

count(Ta,[H|T],X):-
Ta=H, 
count(Ta,T,X1), 
X is X1+1.

max_slots_per_day([],_).

max_slots_per_day([[]|T],Max):-
max_slots_per_day(T,Max),
!.

max_slots_per_day([H|T],Max):-
flatten([H|T],L),
L=[H1|T1],
count(H1,L,X),
X=<Max,
max_slots_per_day(T,Max),
!.

%d

comb(0,_,[]).
comb(N,[H|T],[H|T1]):-
N>0,
N1 is N-1,
comb(N1,T,T1).
comb(N,[_|T],R):-
N>0,
comb(N,T,R).

comb_perm(N,L,R2):-
comb(N,L,R),
permutation(R,R2).

try([],[]).
try([ta(Name,_)|[]],[Name]):-!.
try([ta(Name,_)|T],Assignment):-
append([Name],R,Assignment),
try(T,R).

app(T,P,R):-
subtract(T,P,R1),
append(P,R1,R).

slot_assignment(LabsNum,TAs,RemTAs,Assignment):-
comb_perm(LabsNum,TAs,P),
try(P,Assignment),
app(TAs,P,PermRem),
final(PermRem,RemTAs,Assignment).

final(X,X,[]).

final(X,Y,[H|T]):-
ta_slot_assignment(X,Y1,H),
final(Y1,Y,T).

%b

day_schedule([],X,X,[]).

day_schedule([H|T],TAs,RemTAs,[H1|T1]):-
slot_assignment(H,TAs,RemTAs1,H1),
day_schedule(T,RemTAs1,RemTAs,T1).

%a

week_schedule([],_,_,[]).

week_schedule([H|T],TAs,DayMax,[H1|T1]):-
day_schedule(H,TAs,RemTAs,H1),
max_slots_per_day(H1,DayMax),
week_schedule(T,RemTAs,DayMax,T1).

%RemTAs hateb2a makan el TAs fe c we b we a fe kol recursive call ashan afdal a minus aleha heya shakhseyan










