/*

how to run:
swipl labeled.pl

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

/*
   Materials
   https://en.wikipedia.org/wiki/The_Seven_Basic_Plots
   http://larc.unt.edu/techreports/LARC-2011-02.pdf
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
    write('{ "action":"kill","subject":["hero","monster"]}').
ask(_,mage):-
    write('{"action":"ask","subject":["mage"]}').
join(_,companion):-
    write('{"action":"join","subject":["companion"]}').
steal(_,companion,rareitem):-
    write('{"action":"steal","subject":["companion,rareitem"]}').
reach(_,city):-
    write('{"action":"reach","subject":["city"]}').
reach(_,tavern):-
    write('{"action":"reach","subject":["tavern"]}').
ill(_,X):-
    write('{"action":"ill":"subject":["'),write(X),write('"]}').
destroy(_,city):-
    write('{"action":"destroy","subject":["city"]}').
reach(_,dungeon):-
    write('{"action":"reach","subject":["dungeon"]}').
ask(_,princess):-
    write('{"action":"ask","subject":["princess"]}').
give(_,rareitem,princess):-
    write('{"action":"give","subject":["rareitem","princess"]}').
destroy(_,rareitem):-
    write('{"action":"destroy","subject":["rareitem"]}').
give(_,medicine,X):-
    write('{"action":"give","subject":["medicine","'),write(X),write('"]}').
explore(_,dungeon):-
    write('{"action":"explore","subject":["dungeon"]}').
merge(D,rareitem1,rareitem2):-
    write('{"action":"merge","subject":["rareitem1","rareitem2"]}').
ask(D,X):-
    write('{"action":"ask","subject":["'),write(X),write('"]}').


/* Hypotesis */

/*Cure a king*/

cure(D,P) :-
    D>0,
    write('{"action":"cure","subject":["'),write(P),write('"],"quest":['),
    found(D-1,medicine),
	write(','),
    give(D-1,medicine,P),
	write(']}').
found(D,medicine) :-
    D>0,
    write('{"action":"found","subject":"medicine","quest":['),
    kill(D-1,hero,monster)
	write(']}').
found(D,medicine) :-
    D>0,
    write('{"action":"found","subject":"medicine","quest":['),
    ask(D-1,mage),
	write(']}').

/*The Hobbit */

found(D,treasure) :-
    D>0,
    write('{"action":"found","subject":"treasure","quest":['),
    found(D-1,map),
	write(','),
    kill(D-1,hero,monster),
	write(']}').
found(D,map) :-
    D>0,
    write('{"action":"found","subject":"map","quest":['),
    ask(D-1,mage),
	write(','),
    found(D-1,rareitem),
	write(']}').
found(D,R):-
    D>0,
    write('{"action":"found","subject":["'),write(R),write('"],"quest":['),
    kill(D-1,hero,monster),
	write(']}').

/*The Lord of the Ring */

destroy(D,rareitem) :-
    D>0,
    write('{"action":"destroy","subject":"rareitem","quest":['),
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
	write(']}').

found(D,R) :-
    D>0,
    write('{"action":"found","subject":["'),write(R),write('"],"quest":['),
    ask(D-1,mage),
	write(']}').
gain(D,party) :-
    D>0,
    write('{"action":"gain","subject":"party","quest":['),
    reach(D-1,city),
	write(','),
    reach(D-1,tavern),
	write(','),
    join(D-1,companion),
	write(']}').
betrayal(D,companion) :-
    D>0,
    write('{"action":"betrayal","subject":"companion","quest":['),
    steal(D-1,companion,rareitem),
	write(']}').

kill(D,hero,monster) :-
    D>0,
    write('{"action":"kill","subject":["hero","monster"],"quest":['),
    found(D-1,rareitem),
	write(','),
    reach(D-1,city),
	write(','),
    gain(D-1,party),
	write(']}').

found(D,R):-
    D>0,
    write('{"action":"found","subject":["'),write(R),write('"],"quest":['),
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
	write(']}').

flee(D,city,monster):-
    D>0,
    write('{"action":"flee","subject":["city","monster"],"quest":['),
    destroy(D-1,city),
	write(','),
    reach(D-1,_),
	write(']}').

train(D,hero):-
    D>0,
    write('{"action":"train","subject":["hero"],"quest":['),
    kill(D-1,hero,monster),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

train(D,hero):-
    D>0,
    write('{"action":"train","subject":["hero"],"quest":['),
    write('train(hero,'),
    ask(D-1,mage),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

be(D,king):-
    D>0,
    write('{"action":"be","subject":["king"],"quest":['),
    ask(D-1,mage),
	write(','),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(']}').

rescue(D,princess):-
    D>0,
    write('{"action":"rescue","subject":["princess"],"quest":['),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(']}').

found(D,love):-
    D>0,
    write('{"action":"found","subject":["love"],"quest":['),
    ask(D-1,mage),
	write(','),
    rescue(D-1,princess),
	write(','),
    found(D-1,rareitem),
	write(','),
    give(D-1,rareitem,princess),
	write(','),
    ask(D-1,princess),
	write(']}').

save(D,P):-
    D>0,
    write('{"action":"save","subject":["',write(P),write('"],"quest":['),
    flee(D-1,city,monster),
	write(','),
    reach(D-1,city),
	write(','),
    ask(D-1,mage),
	write(','),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

save(D,princess):-
    D>0,
    write('{"action":"save","subject":["princess"],"quest":['),
    flee(D-1,city,monster),
	write(','),
    reach(D-1,city),
	write(','),
    found(D,love),
	write(','),
    reach(D-1,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

found(D,R):-
    D>0,
    write('{"action":"found","subject":["'),write(R),write('"],"quest":['),
    reach(D-1,dungeon),
	write(']}').

escape(D,hero,dungeon):-
    D>0,
    write('{"action":"escape","subject":["hero","dungeon"],"quest":['),
    kill(D-1,hero,monster),
	write(','),
    reach(D-1,city),
	write(']}').
escape(D,P,dungeon):-
    D>0,
    write('{"action":"escape","subject":["',write(P),write('","dungeon"],"quest":['),
    found(D-1,secretPath),
	write(','),
    reach(D-1,city),
	write(']}').

found(D,secretPath):-
  D>0,
    write('{"action":"found","subject":["secretPath"],"quest":['),
    write('found(secretPath,'),
    explore(D-1,dungeon),
	write(']}').

create(D,rareitem):-
    D>0,
    write('{"action":"create","subject":["rareitem"],"quest":['),
    ask(D-1,mage),
	write(','),
    found(D-1,rareitem1),
	write(','),
    found(D-1,rareitem2),
	write(','),
    merge(D-1,rareitem1,rareitem2),
	write(']}').
awake(D,P):-
    D>0,
    write('{"action":"awake","subject":["',write(P),write('"],"quest":['),
    create(D-1,rareitem),
	write(','),
    reach(D-1,dungeon),
	write(']}').

awake(D,god):-
    D>0,
    write('{"action":"awake","subject":["god"],"quest":['),
    create(D-1,rareitem),
	write(','),
    reach(D-1,city),
	write(']}').

kill(D,hero,monster):-
    D>0,
    write('{"action":"kill","subject":["hero","monster"],"quest":['),
    create(D-1,rareitem),
	write(']}').

revolte(D,slave,monster):-
    D>0,
    write('{"action":"revolte","subject":["slave","monster"],"quest":['),
    escape(D-1,slave,dungeon),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

kill(D,hero,monster):-
    D>0,
    write('{"action":"kill","subject":["hero","monster"],"quest":['),
    kill(D-1,hero,monster),
	write(','),
    kill(D-1,hero,monster),
	write(']}').

give(D,message,K):-
    D>0,
    write('{"action":"give","subject":["message","',write(K),write('"],"quest":['),
    ask(D-1,mage),
	write(','),
    reach(D-1,city),
	write(','),
    ask(D-1,K),
	write(']}').
