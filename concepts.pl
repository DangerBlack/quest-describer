/*
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

kill(hero,monster).
ask(mage).
ask(hero).
steal(hero,rareitem).
reach(city).
reach(city2).
reach(tavern).
ill(king).

/* Hypotesis */

/*Cure a king*/

cure(king) :-
    write('[1 ill]'),
    ill(king),
    write('[1 found]'),
    found(medicine).
found(medicine) :-
    write('[2 kill]'),
    kill(hero,monster).
found(medicine) :-
    write('[3 ask]'),
    ask(mage).

/*The Hobbit */

found(treasure) :-
    write('[4 found]'),
    found(map),
    write('[4 kill]'),
    kill(hero,monster).
found(map) :-
    write('[5 ask]'),
    ask(mage),
    write('[5 found]'),
    found(rareitem).
found(rareitem) :-
    write('[6 kill]'),
    kill(hero,monster).

/*The Lord of the Ring */

destroy(rareitem) :-
    write('[7 found]'),
    found(rareitem),
    write('[7 gain]'),
    gain(party),
    write('[7 reach]'),
    reach(city2),
    write('[7 ask]'),
    ask(mage),
    write('[7 kill]'),
    kill(hero,monster),
    write('[7 betrayal]'),
    betrayal(hero).
found(rareitem) :-
    write('[8 ask]'),
    ask(mage).
gain(party) :-
    write('[9 reach]'),
    reach(city),
    write('[9 reach]'),
    reach(tavern),
    write('[9 ask]'),
    ask(hero).
betrayal(hero) :-
    write('[10 steal]'),
    steal(hero,rareitem).

kill(hero,monster) :-
    write('[11 found]'),
    found(rareitem),
    write('[11 reach]'),
    reach(city),
    write('[11 gain]'),
    gain(party).
