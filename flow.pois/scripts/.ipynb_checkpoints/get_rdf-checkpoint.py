#!/usr/bin/python
import sys
temp = sys.argv[1]

import matplotlib.pyplot as plt

f=open('./rdf/tmp_{}.rdf'.format(temp))

Nlines=0
rdf_dict={}
for line in f.readlines():
    if (line[0]=='#'):
        continue
    lineS=line.split()
    if (len(lineS) == 2):
        Nlines=int(lineS[1])
        step=int(lineS[0])
        rdf_dict[step]={
            'r': [],
            'rdf': []
        }
        continue
    if not (len(lineS) == 4):
        print ("Error: not 4 columns")
        break
    if (Nlines<0):
        print ("Error: Nlines < 0")
        break
            
    rdf_dict[step]['r'].append(float(lineS[1])) 
    rdf_dict[step]['rdf'].append(float(lineS[2]))
    Nlines -= 1

for step in rdf_dict:
    plt.plot(rdf_dict[step]['r'], rdf_dict[step]['rdf'],
            '-')

#plt.legend()
plt.xlabel("r")
plt.ylabel("rdf")
plt.title("RDF for Temp={:s}".format(temp))
plt.savefig("png/temp_{:s}.png".format(temp))
                
