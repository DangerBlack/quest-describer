/*

how to run:
swipl concepts.pl

Hero
Monster
King
Child
Princess
Treasure
Medicine
Mage
Map
RareItem
City
Tavern
*/

/*Facts*/

:-discontiguous(found/1).
:-discontiguous(kill/1).
:-discontiguous(kill/2).

kill(_,hero,monster):-
    write('[-1 kill]').
ask(_,mage):-
    write('[-2 ask]').
join(_,companion):-
    write('[-3 join]').
steal(_,companion,rareitem):-
    write('[-4 steal]').
reach(_,city):-
    write('[-6 reach]').
reach(_,tavern):-
    write('[-7 reach]').
ill(_,king):-
    write('[-8 ill]').
destroy(_,city):-
    write('[-9 destroy]').

/* Hypotesis */

/*Cure a king*/

cure(D,king) :-
    D>0,
    write('[1 cure]'),
    ill(D-1,king),
    found(D-1,medicine).
found(D,medicine) :-
    D>0,
    write('[2 found]'),
    kill(D-1,hero,monster).
found(D,medicine) :-
    D>0,
    write('[3 found]'),
    ask(D-1,mage).

/*The Hobbit */

found(D,treasure) :-
    D>0,
    write('[4 found]'),
    found(D-1,map),
    kill(D-1,hero,monster).
found(D,map) :-
    D>0,
    write('[5 found]'),
    ask(D-1,mage),
    found(D-1rareitem).
found(D,rareitem):-
    D>0,
    write('[6 found]'),
    kill(D-1,hero,monster).

/*The Lord of the Ring */

destroy(D,rareitem) :-
    D>0,
    write('[7 destroy]'),
    found(D-1,rareitem),
    gain(D-1,party),
    reach(D-1,city),
    ask(D-1,mage),
    kill(D-1,hero,monster),
    betrayal(D-1,companion).
found(D,rareitem) :-
    D>0,
    write('[8 found]'+D),
    ask(D-1,mage).
gain(D,party) :-
    D>0,
    write('[9 gain]'+D),
    reach(D-1,city),
    reach(D-1,tavern),
    join(D-1,companion).
betrayal(D,companion) :-
    D>0,
    write('[10 betrayal]'+D),
    steal(D-1,companion,rareitem).

kill(D,hero,monster) :-
    D>0,
    write('[11 kill]'+D),
    found(D-1,rareitem),
    reach(D-1,city),
    gain(D-1,party).

found(D,rareitem):-
    D>0,
    write('[12 found]'),
    join(D-1,companion),
    ask(D-1,mage),
    flee(D-1,city,monster),
    train(D-1,hero),
    reach(D-1,city),
    kill(D-1,hero,monster).

flee(D,city,monster):-
    D>0,
    write('[13 flee]'),
    destroy(D-1,city),
    reach(D-1,_).

train(D-1,hero):-
    D>0,
    write('[14 train]'),
    kill(D-1,hero,monster),
    kill(D-1,hero,monster).

train(D-1,hero):-
    D>0,
    write('[15 train]'),
    ask(D-1,mage),
    kill(D-1,hero,monster).
