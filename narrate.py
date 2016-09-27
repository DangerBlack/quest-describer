#!/usr/bin/python

import sys, getopt
import json
import random as R
import glob
from yamloader import EntitiesName
from questBinder import QuestBinder
from prolog import PrologQuest

input = '{"action":"destroy","subject":["rareitem"],"quest":[{"action":"found","subject":["rareitem"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"gain","subject":["party"],"quest":[{"action":"reach","subject":["city"]},{"action":"reach","subject":["tavern"]},{"action":"join","subject":["companion"]}]},{"action":"reach","subject":["city"]},{"action":"ask","subject":["mage"]},{ "action":"kill","subject":["hero","monster"]},{"action":"betrayal","subject":["companion"],"quest":[{"action":"steal","subject":["companion","rareitem"]}]},{"action":"reach","subject":["dungeon"]}]}'

qb=QuestBinder(EntitiesName(['monster','city','rareitem','tavern','dungeon','mage','hero','party','companion']));

def narrate_quest(data):
    js = json.loads(data)
    ret = qb.bindAll(js)
    print('The quest binded with names:')
    print(ret)

def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print('narrate.py -i <inline> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('narrate.py -i <inputfile> -o <outputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
    #narrate(inputfile)
    R.seed(123)

    p = PrologQuest('cure(3,king)')
    res = p.generateQuest()
    narrate_quest(res)


if __name__ == "__main__":
    main(sys.argv[1:])
