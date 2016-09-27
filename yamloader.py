import glob
import yaml
import random as R

class EntitiesName:

    names={}

    UNDEFINED = 'UNDEFINED'

    def __init__(self,entity_list):
        self.UNDEFINED = 'UNDEFINED'
        self.load_names(entity_list)

    def load_yaml_file(self,conf_file):
        config=[]

        try:
            stream = open(conf_file, 'r')
            config = yaml.load(stream)
        except IOError as e:
            print("'\033[1;38mError opening ["+conf_file+"]: "+str(e)+"\033[1;m\n")

        return config

    def load_names(self,entity_list):

        for entity in entity_list:
            self.names[entity] = self.load_yaml_file("src/fantasy/"+entity+".yaml")

    def getName(self, entity):
        try:
            return self.names[entity][R.randint(0,len(self.names[entity])-1)]
        except:
            print('\033[1;33mWARNING: UNDEFINED name for entity '+entity+'\033[1;m')
            return self.UNDEFINED
