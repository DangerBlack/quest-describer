# quest-describer
A First Order Logic as describer for RPG quest

We chose the power of backtracking in prolog in order to describe quest in a rpg world.
You can ask prolog to solve a quest for you and he can find the best path to solve the quest writing a story.
And on this story you can create a world full of drama and passion.

###Begin

You need some tools on your machine in order to run this program
```
install swipl
install python3
pip install yaml
```

###run

you can simply run **narrate.py**

```
python3 narrate.py -i "save(3,princess)"
```


some possible quest are the following:

- cure(5,king).
- cure(5,child).
- cure(5,princess).
- found(5,treasure).
- destroy(5,rareitem).
- found(5,rareitem).
- be(5,king).
- rescue(5,princess).
- found(5,love).
- save(5,child).
- save(5,king).
- save(5,princess).
- create(5,rareitem).
- escape(5,hero,dungeon).
- awake(5,monster).
- awkake(5,god).
- awake(5,_).
- revolte(5,slave,monster).

number 5 represent the deepest level in the graph, by now prolog return only the first possible solution of the quest (boring) but in future it can find all the possible quest.
