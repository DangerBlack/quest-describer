from subprocess import Popen, PIPE, STDOUT
import json


class PrologQuest:

    quest = 'cure(3,king)'

    def __init__(self,quest):
        self.quest = quest

    def dbg_print(self,X):
        pass
        #print(X)

    def generateQuest(self):
        self.dbg_print('the input quest:')
        self.dbg_print(self.quest)

        cmd = 'swipl -g "'+self.quest+',nl,halt" -f -s labeled.pl'
        p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
        res = p.stdout.read()
        res = res.decode("utf-8")
        res = res.split("\n")[1]

        self.dbg_print('The oputquest: ')
        self.dbg_print(res)

        return res

'''
from os import system

res = os.system('swipl -g "cure(5,king),nl,halt" -f -s labeled.pl')

print(res)
'''
