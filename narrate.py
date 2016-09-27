#!/usr/bin/python

import sys, getopt
import argparse
import json
import random as R
import glob
from yamloader import EntitiesName
from questBinder import QuestBinder
from prolog import PrologQuest

SAVE_FOLDER = 'plot/'

input = '{"action":"destroy","subject":["rareitem"],"quest":[{"action":"found","subject":["rareitem"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"gain","subject":["party"],"quest":[{"action":"reach","subject":["city"]},{"action":"reach","subject":["tavern"]},{"action":"join","subject":["companion"]}]},{"action":"reach","subject":["city"]},{"action":"ask","subject":["mage"]},{ "action":"kill","subject":["hero","monster"]},{"action":"betrayal","subject":["companion"],"quest":[{"action":"steal","subject":["companion","rareitem"]}]},{"action":"reach","subject":["dungeon"]}]}'

qb=QuestBinder(EntitiesName(['monster','city','rareitem','tavern','dungeon','mage','hero','party','companion']));

def narrate_quest(data):
    js = json.loads(data)
    ret = qb.bindAll(js)
    return ret


def save_file(filename,js):
    file = open(SAVE_FOLDER+filename,'w')
    txt = str(js).replace("'",'"')
    file.write(txt)
    file.close()

def main(argv):

    parser = argparse.ArgumentParser(description='Generate quest with python and prolog.')
    parser.add_argument('-i', help='a string representi an open quest')

    parser.add_argument('-o', help='the output, can be file or stdout (default)', default="stdout")

    args = parser.parse_args()
    quest = args.i
    output = args.o

    R.seed(123)

    p = PrologQuest(quest)
    res = p.generateQuest()
    res = narrate_quest(res)

    if(output == 'stdout'):
        print('The quest binded with names:')
        txt = str(res).replace("'",'"')
        print(txt)
    else:
        print('save on file '+SAVE_FOLDER+output)
        save_file(output,res)

if __name__ == "__main__":
    main(sys.argv[1:])
