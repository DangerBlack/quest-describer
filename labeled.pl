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
dungeon
god
message

*/



/*MAIN ~ QUEST*/

/*

cure(5,king).
cure(5,child).
cure(5,princess).

found(5,treasure).

destroy(5,rareitem).

found(5,rareitem).

be(5,king).

rescue(5,princess).

found(5,love).

save(5,child).
save(5,king).
save(5,princess).

create(5,rareitem).

escape(5,hero,dungeon).

awake(5,monster).
awkake(5,god).
awake(5,_).

revolte(5,slave,monster).
*/

/*Facts*/

:-discontiguous(found/1).
:-discontiguous(kill/1).
:-discontiguous(kill/2).
:-discontiguous(reach/2).
:-discontiguous(ask/2).
:-discontiguous(destroy/2).
:-discontiguous(give/3).
:-discontiguous(found/2).
:-discontiguous(kill/3).


kill(_,hero,monster):-
    write('kill(hero,monster)').
ask(_,mage):-
    write('ask(mage)').
join(_,companion):-
    write('join(companion)').
steal(_,companion,rareitem):-
    write('steal(companion,rareitem)').
reach(_,city):-
    write('reach(city)').
reach(_,tavern):-
    write('reach(tavern)').
ill(_,X):-
    write('ill('),write(X),write(')').
destroy(_,city):-
    write('destroy(city)').
reach(_,dungeon):-
    write('reach(dungeon)').
ask(_,princess):-
    write('ask(princess)').
give(_,rareitem,princess):-
    write('give(rareitem,princess)').
destroy(_,rareitem):-
    write('destroy(rareitem)').
give(_,medicine,X):-
    write('give(medicine,'),write(X),write(')').
explore(_,dungeon):-
    write('explore(dungeon)').
merge(D,rareitem,rareitem):-
    write('merge(rareitem,rareitem)').
ask(D,X):-
    write('ask('),write(X),write(')').


/* Hypotesis */

/*Cure a king*/

cure(D,P) :-
    D>0,
    write('cure('),write(P),write(','),
    ill(D-1,P),
	write(','),
    found(D-1,medicine),
	write(','),
    give(D-1,medicine,P),
	write(')').
found(D,medicine) :-
    D>0,
    write('found(medicine,'),
    kill(D-1,hero,monster)
	write(')').
found(D,medicine) :-
    D>0,
    write('found(medicine,'),
    ask(D-1,mage),
	write(')').

/*The Hobbit */

found(D,treasure) :-
    D>0,
    write('found(treasure,'),
    found(D-1,map),
	write(','),
    kill(D-1,hero,monster),
	write(')').
found(D,map) :-
    D>0,
    write('found(map,'),
    ask(D-1,mage),
	write(','),
    found(D-1,rareitem),
	write(')').
found(D,rareitem):-
    D>0,
    write('found(rareitem,'),
    kill(D-1,hero,monster),
	write(')').

/*The Lord of the Ring */

destroy(D,rareitem) :-
    D>0,
    write('destroy(rareitem,'),
    found(D-1,rareitem),
	write(','),
    gain(D-1,party),
	write(','),
    reach(D-1,city),
	write(','),
    ask(D-1,mage),
	write(','),
    kill(D-1,hero,monster),
	write(','),
    betrayal(D-1,companion),
	write(','),
    reach(D-1,dungeon),
	write(','),
    destroy(D-1,rareitem),
	write(')').

found(D,rareitem) :-
    D>0,
    write('found(rareitem,'),
    ask(D-1,mage),
	write(')').
gain(D,party) :-
    D>0,
    write('gain(party,'),
    reach(D-1,city),
	write(','),
    reach(D-1,tavern),
	write(','),
    join(D-1,companion),
	write(')').
betrayal(D,companion) :-
    D>0,
    write('betrayal(companion,'),
    steal(D-1,companion,rareitem),
	write(')').

kill(D,hero,monster) :-
    D>0,
    write('kill(hero,monster,'),
    found(D-1,rareitem),
	write(','),
    reach(D-1,city),
	write(','),
    gain(D-1,party),
	write(')').

found(D,rareitem):-
    D>0,
    write('found(rareitem,'),
    join(D-1,companion),
	write(','),
    ask(D-1,mage),
	write(','),
    flee(D-1,city,monster),
	write(','),
    train(D-1,hero),
	write(','),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(')').

flee(D,city,monster):-
    D>0,
    write('flee('),
    destroy(D-1,city),
	write(','),
    reach(D-1,_),
	write(')').

train(D,hero):-
    D>0,
    write('train(hero,'),
    kill(D-1,hero,monster),
	write(','),
    kill(D-1,hero,monster),
	write(')').

train(D,hero):-
    D>0,
    write('train(hero,'),
    ask(D-1,mage),
	write(','),
    kill(D-1,hero,monster),
	write(')').

be(D,king):-
    D>0,
    write('be(king,'),
	write(','),
    ask(D-1,mage),
	write(','),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(')').

rescue(D,princess):-
    D>0,
    write('rescue(princess,'),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(')').

found(D,love):-
    D>0,
    write('found(love,'),
    ask(D-1,mage),
	write(','),
    rescue(D-1,princess),
	write(','),
    found(D-1,rareitem),
	write(','),
    give(D-1,rareitem,princess),
	write(','),
    ask(D-1,princess),
	write(')').

save(D,P):-
    D>0,
    write('save('),write(P),write(','),
    flee(D-1,city,monster),
	write(','),
    reach(D-1,city),
	write(','),
    ask(D-1,mage),
	write(','),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(')').

save(D,princess):-
    D>0,
    write('save(princess,'),
    flee(D-1,city,monster),
	write(','),
    reach(D-1,city),
	write(','),
    found(D,love),
	write(','),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(')').

found(D,rareitem):-
    D>0,
    write('found(rareitem,'),
    reach(D-1,dungeon),
	write(')').

escape(D,hero,dungeon):-
    D>0,
    write('escape(hero,dungeon,'),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(')').
escape(D,_,dungeon):-
    D>0,
    write('escape(dungeon,'),
    found(D-1,secretPath),
	write(','),
    reach(D-1,city),
	write(')').

found(D,secretPath):-
  D>0,
    write('found(secretPath,'),
    explore(D-1,dungeon),
	write(')').

create(D,rareitem):-
    D>0,
    write('create(rareitem,'),
    ask(D-1,mage),
	write(','),
    found(D-1,rareitem),
	write(','),
    found(D-1,rareitem),
	write(','),
    merge(D-1,rareitem,rareitem),
	write(')').
awake(D,P):-
    D>0,
    write('awake('),write(P),write(','),
    create(D-1,rareitem),
	write(','),
    reach(D-1,dungeon),
	write(')').

awake(D,god):-
    D>0,
    write('awake(god,'),
    create(D-1,rareitem),
	write(','),
    reach(D-1,city),
	write(')').

kill(D,hero,monster):-
    D>0,
    write('kill(hero,monster,'),
    create(D-1,rareitem),
	write(')').

revolte(D,slave,monster):-
    D>0,
    write('revolte(slave,monster,'),
    escape(D-1,slave,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(')').

kill(D,hero,monster):-
    D>0,
    write('kill(hero,monster,'),
    kill(D-1,hero,monster),
	write(','),
    kill(D-1,hero,monster),
	write(')').

give(D,message,K):-
    D>0,
    write('give(message,'),write(K),write(','),
    ask(D-1,mage),
	write(','),
    reach(D-1,city),
	write(','),
    ask(D-1,K),
	write(')').
