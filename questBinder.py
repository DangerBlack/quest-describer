import sys, getopt
import json
import random as R
import glob
from yamloader import EntitiesName


class QuestBinder:
    en = EntitiesName(['monster','city','rareitem','tavern','dungeon','mage','hero','party','companion'])

    def __init__(self,en):
        self.en = en


    #input ='{"action":"create","subject":["rareitem"],"quest":[{"action":"ask","subject":["mage"]},{"action":"found","subject":["rareitem1"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"found","subject":["rareitem2"],"quest":[{ "action":"kill","subject":["hero","monster"]}]},{"action":"merge","subject":["rareitem1","rareitem2"]}]}'


    def dbg_print(self,X):
        pass
        #print(X)

    def getOne(self,subject,binding):
        self.dbg_print("Questi sono i bind per subject: "+str(binding)+" "+subject)
        if subject in binding:
                return binding[subject]
        return self.en.getName(subject)


    def bind(self,subject,name,quests):
        for quest in quests:
            self.dbg_print("Bindo soggetto-quest: "+subject+" "+quest['action'])
            if( subject in quest['subject']):
                if not 'bind' in quest.keys():
                    quest['bind']={}
                quest['bind'][subject] = name;
        return quests

    def bindAll(self,js):
        subjects = js.get('subject',[])
        binding = js.get('bind',{})
        quests = js.get('quest',[])
        action = js.get('action',"")
        for subject in subjects:
            self.dbg_print('Bindo soggetto: '+subject);
            name = self.getOne(subject,binding)
            binding[subject]=name
            if(subject == 'hero'):
                self.dbg_print("STO BINDANDO L'EROE: "+name)
            quests = self.bind(subject,name,quests)

        for i in range(0,len(quests)):
            self.dbg_print("La quest: "+str(quests[i]))
            quests[i] = self.bindAll(quests[i])

        return {"subject":subject,"bind":binding,"action":action,"quest":quests}
