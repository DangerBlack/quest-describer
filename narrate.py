#!/usr/bin/python

import sys, getopt
import json
import random as R
import glob



def load_yaml_file(conf_file):
    import yaml
    config=[]

    try:
        stream = open(conf_file, 'r')
        config = yaml.load(stream)
    except IOError as e:
        print("Error opening ["+conf_file+"]: "+str(e)+"\n")

    return config

monster = load_yaml_file("src/fantasy/monster.yaml")
city = load_yaml_file("src/fantasy/city.yaml")
rareitem = load_yaml_file("src/fantasy/rareitem.yaml")
companion = load_yaml_file("src/fantasy/companion.yaml")
tavern = load_yaml_file("src/fantasy/tavern.yaml")
dungeon = load_yaml_file("src/fantasy/dungeon.yaml")
mage = load_yaml_file("src/fantasy/mage.yaml")
hero = ["eroe","eroe"]

input = '{"action":"destroy","subject":["rareitem"],"quest":[{"action":"found","subject":["rareitem"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"gain","subject":["party"],"quest":[{"action":"reach","subject":["city"]},{"action":"reach","subject":["tavern"]},{"action":"join","subject":["companion"]}]},{"action":"reach","subject":["city"]},{"action":"ask","subject":["mage"]},{ "action":"kill","subject":["hero","monster"]},{"action":"betrayal","subject":["companion"],"quest":[{"action":"steal","subject":["companion","rareitem"]}]},{"action":"reach","subject":["dungeon"]}]}'

#input ='{"action":"create","subject":["rareitem"],"quest":[{"action":"ask","subject":["mage"]},{"action":"found","subject":["rareitem1"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"found","subject":["rareitem2"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"merge","subject":["rareitem1","rareitem2"]}]}'


def dbg_print(X):
    print(X)

def getOne(subject,binding):
    dbg_print("Questi sono i bind per subject: "+str(binding)+" "+subject)
    if subject in binding:
            return binding[subject]

    if(subject == 'mage'):
        return mage[R.randint(0,len(mage))]
    if(subject == 'monster'):
        return monster[R.randint(0,len(monster))]
    if(subject == 'city'):
        return city[R.randint(0,len(city))]
    if(subject == 'rareitem'):
        return rareitem[R.randint(0,len(rareitem))]
    if(subject == 'tavern'):
        return tavern[R.randint(0,len(tavern))]
    if(subject == 'companion'):
        return companion[R.randint(0,len(companion))]
    if(subject == 'dungeon'):
        return dungeon[R.randint(0,len(dungeon))]
    if(subject == 'hero'):
        return "eroe"


def bind(subject,name,quests):
    for quest in quests:
        dbg_print("Bindo soggetto-quest: "+subject+" "+quest['action'])
        if( subject in quest['subject']):
            if not 'bind' in quest.keys():
                quest['bind']={}
            quest['bind'][subject] = name;
    return quests

def bindAll(js):
    subjects = js.get('subject',[])
    binding = js.get('bind',{})
    quests = js.get('quest',[])
    action = js.get('action',"")
    for subject in subjects:
        dbg_print('Bindo soggetto: '+subject);
        name = getOne(subject,binding)
        binding[subject]=name
        if(subject == 'hero'):
            dbg_print("STO BINDANDO L'EROE: "+name)
        quests = bind(subject,name,quests)

    for i in range(0,len(quests)):
        dbg_print("La quest: "+str(quests[i]))
        quests[i] = bindAll(quests[i])

    if( 'hero' in binding.keys()):
        print("+++++++++++++++++++++++"+str(binding))
    return {"subject":subject,"bind":binding,"action":action,"quest":quests}

def narrate(data):
    js = json.loads(data)
    print(data)
    print(js['action'])
    print(js['subject'])
    ret = bindAll(js)
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

    narrate(input)








if __name__ == "__main__":
    main(sys.argv[1:])
