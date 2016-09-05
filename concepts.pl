Hero
Monster
King
Child
Princess
Treasure
Medicine
Mage /*A wise man or woman, like Mage, Witch, Old Elf, Father, Grandfather */
Map
RareItem
City
Tavern

/*Cure a king*/
cure(King) :- ill(King), found(Medicine).
found(Medicine) :- kill(Hero,Monster).
found(Medicine) :- ask(Mage).

/*The Hobbit */

found(Treasure) :- found(Map),kill(Hero,Monster).
found(Map) :- ask(Mage),found(RareItem)
found(RareItem) :- kill(Hero,Monster).

/*The Lord of the Ring */

destroy(RareItem) :- found(RareItem),gain(Party),reach(City),ask(Mage),kill(Hero,Monster),betrayal(Hero).
reach(City) :- reach(City),kill(Hero,Monster).
reach(City) :- reach(City),reach(City).
found(RareItem) :- ask(Mage).
gain(Party) :- reach(City),reach(Tavern),ask(Hero).
betrayal(Hero) :- kill(Hero,Hero).
betrayal(Hero) :- steal(Hero,RareItem).

/* The sword of shannara */

kill(Hero,Monster) :- found(RareItem), reach(City), gain(Party).




/*Things that can be done! yeah!*/
ill(King).
kill(Hero,Monster).
ask(Mage).
