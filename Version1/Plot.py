import tables
import numpy as np
step = -1
actions_num = 14
hazards_num = 15
records = {}
bool_set = set()
f = open('output.hist.txt')
for line in f:
       line = line.strip()   # strip out carriage return
       if line.startswith("------ time"):
           step += 1
       elif line.startswith("------ end"):
           pass
       elif line.strip() == "**LOOP**":
           records["LOOP"] = step

       else:
           key_value = line.split(" = ")   # split line, into key and value
           key = key_value[0]   # key is first item in list
           if len(key_value) > 1:
               value = key_value[1]   # value is 2nd item
           else:
               value = step
               bool_set.add(key)
       
           if key in records:
          
              records[key].append(value)
              
           else:
               records[key] = [value]

##
def chunks(l, n):
    n = max(1, n)
    return [l[i:i + n] for i in range(0, len(l), n)]

action_state={}
action_risk={}
i = 0
while i < actions_num:
    i += 1
    ##state of each action
    action_state[i] = chunks (records['ACTIONS('+str(i)+ ' 1)'],1)
    ##risk value of each action
    action_risk[i] = chunks (records['ACTIONS('+str(i)+ ' 4)'],1)

##
hazard_state={}
hazard_risk={}
i = 0
while i < hazards_num:
    i += 1
    #state of each hazard
    hazard_state[i] = chunks (records['HAZARDS('+str(i)+ ' 0)'],1)
    #risk value of each hazard
    hazard_risk[i] = chunks (records['HAZARDS('+str(i)+ ' 4)'],1)

###
i = 0
j = 0
table=['<htm><body><table border="1">']
while i < step:
    table.append('<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>'.format('step'+str(i),'actions','state','risk value'))
    while j < actions_num:
        j += 1
        table.append('<tr><td>{}</td><td>{}</td><td>{}</td><td>{}</td></tr>'.format('','action' + str(j),action_state[j][i],action_risk[j][i]))
    i += 1
    j = 0
table.append('</table></body></html>')
print ''.join(table)
