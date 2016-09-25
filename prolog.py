'''from subprocess import call
import narrate


quest = 'cure(3,king)'

mres=""
res = call('swipl -g "'+quest+',nl,halt" -f -s labeled.pl', shell=True, universal_newlines=True)
'''

from subprocess import Popen, PIPE, STDOUT
import narrate
import json
quest = 'cure(3,king)'



cmd = 'swipl -g "'+quest+',nl,halt" -f -s labeled.pl'
p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
res = p.stdout.read()
print(res)
res = res.decode("utf-8")
res = res.split("\n")[1]
print(res)


narrate.narrate_quest(res)

'''
from os import system

res = os.system('swipl -g "cure(5,king),nl,halt" -f -s labeled.pl')

print(res)
'''
