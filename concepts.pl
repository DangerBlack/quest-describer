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
ill(_,_):-
    write('[-8 ill]').
destroy(_,city):-
    write('[-9 destroy]').
reach(_,dungeon):-
    write('[-10 reach]').
ask(_,princess):-
    write('[-11 ask]').
give(_,rareitem,princess):-
    write('[-12 give]').
destroy(_,rareitem):-
    write('[-12 destroy]').
give(_,medicine,_):-
    write('[-13 give]').
explore(_,dungeon):-
    write('[-14 explore]').
merge(D,rareitem,rareitem):-
    write('[-15 merge]').
ask(D,_):-
    write('[-16 ask]').


/* Hypotesis */

/*Cure a king*/

cure(D,P) :-
    D>0,
    write('[1 cure]'),
    ill(D-1,P),
    found(D-1,medicine),
    give(D-1,medicine,P).
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
    found(D-1,rareitem).
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
    betrayal(D-1,companion),
    reach(D-1,dungeon),
    destroy(D-1,rareitem).

found(D,rareitem) :-
    D>0,
    write('[8 found]'),
    ask(D-1,mage).
gain(D,party) :-
    D>0,
    write('[9 gain]'),
    reach(D-1,city),
    reach(D-1,tavern),
    join(D-1,companion).
betrayal(D,companion) :-
    D>0,
    write('[10 betrayal]'),
    steal(D-1,companion,rareitem).

kill(D,hero,monster) :-
    D>0,
    write('[11 kill]'),
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
    reach(D-1,dungeon),
    kill(D-1,hero,monster).

flee(D,city,monster):-
    D>0,
    write('[13 flee]'),
    destroy(D-1,city),
    reach(D-1,_).

train(D,hero):-
    D>0,
    write('[14 train]'),
    kill(D-1,hero,monster),
    kill(D-1,hero,monster).

train(D,hero):-
    D>0,
    write('[15 train]'),
    ask(D-1,mage),
    kill(D-1,hero,monster).

be(D,king):-
    D>0,
    write('[16 be]'),
    ask(D-1,mage),
    kill(D-1,hero,monster),
    reach(D-1,city).

rescue(D,princess):-
    D>0,
    write('[17 rescue]'),
    reach(D-1,dungeon),
    kill(D-1,hero,monster),
    reach(D-1,city).

found(D,love):-
    D>0,
    write('[18 found]'),
    ask(D-1,mage),
    rescue(D-1,princess),
    found(D-1,rareitem),
    give(D-1,rareitem,princess),
    ask(D-1,princess).

save(D,P):-
    D>0,
    write('[19 save]'),
    flee(D-1,city,monster),
    reach(D-1,city),
    ask(D-1,mage),
    reach(D-1,dungeon),
    kill(D-1,hero,monster).

save(D,princess):-
    D>0,
    write('[20 save]'),
    flee(D-1,city,monster),
    reach(D-1,city),
    found(D,love),
    reach(D-1,dungeon),
    kill(D-1,hero,monster).

found(D,rareitem):-
    D>0,
    write('[21 found]'),
    reach(D-1,dungeon).

escape(D,hero,dungeon):-
    D>0,
    write('[22 escape]'),
    kill(D-1,hero,monster),
    reach(D-1,city).
escape(D,_,dungeon):-
    D>0,
    write('[23 escape]'),
    found(D-1,secretPath),
    reach(D-1,city).

found(D,secretPath):-
  D>0,
    write('[24 found]'),
    explore(D-1,dungeon).

create(D,rareitem):-
    D>0,
    write('[25 create]'),
    ask(D-1,mage),
    found(D-1,rareitem),
    found(D-1,rareitem),
    merge(D-1,rareitem,rareitem).
awake(D,_):-
    D>0,
    write('[26 awake]'),
    create(D-1,rareitem),
    reach(D-1,dungeon).

awake(D,god):-
    D>0,
    write('[27 awake]'),
    create(D-1,rareitem),
    reach(D-1,city).

kill(D,hero,monster):-
    D>0,
    write('[28 kill]'),
    create(D-1,rareitem).

revolte(D,slave,monster):-
    D>0,
    write('[29 revolte]'),
    escape(D-1,slave,dungeon),
    kill(D-1,hero,monster).

kill(D,hero,monster):-
    D>0,
    write('[30 kill]'),
    kill(D-1,hero,monster),
    kill(D-1,hero,monster).

give(D,message,K):-
    D>0,
    write('[31 give]'),
    ask(D-1,mage),
    reach(D-1,city),
    ask(D-1,K).
