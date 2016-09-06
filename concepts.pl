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

kill(Hero,Monster).
ask(Mage).
steal(Hero,RareItem).
reach(City2).
reach(City3).

all_different([City,City2,City3]).

/* Hypotesis */

/*Cure a king*/
/*cure(King) :- ill(King), found(Medicine).
found(Medicine) :- kill(Hero,Monster).
found(Medicine) :- ask(Mage).
*/
/*The Hobbit */
/*
found(Treasure) :- found(Map),kill(Hero,Monster).
found(Map) :- ask(Mage),found(RareItem)
found(RareItem) :- kill(Hero,Monster).
*/
/*The Lord of the Ring */

destroy(RareItem) :-
    write('[1]'),
    found(RareItem),
    gain(Party),
    reach(City),
    ask(Mage),
    kill(Hero,Monster),
    betrayal(Hero).
reach(City) :-
    write('[2]'),
    reach(City2),
    kill(Hero,Monster),
    City!=City2.
reach(City) :-
    write('[3]'),
    reach(City2),
    reach(City3),
    City!=City2,City2!=City3.
found(RareItem) :-
    write('[4]'),
    ask(Mage).
gain(Party) :-
    write('[5]'),
    reach(City),
    reach(Tavern),
    ask(Hero).
betrayal(Hero) :-
    write('[6]'),
    steal(Hero,RareItem).


/* The sword of shannara */
/*
kill(Hero,Monster) :- found(RareItem), reach(City), gain(Party).
*/
