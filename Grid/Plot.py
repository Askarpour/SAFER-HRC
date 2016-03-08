
import matplotlib.pyplot as plt
import numpy as numpy
import matplotlib.gridspec as gridspec
import math
# import scipy, pylab

step = -1
records = {}

bool_set = set()
f = open('output.hist.txt')
for line in f:
       line = line.strip()   # strip out carriage return
       if line.startswith("------ time"):
           step += 1
#            print("------- STEP {0} -------".format(step))
       elif line.startswith("------ end"):
           pass
       elif line.strip() == "**LOOP**":
           records["LOOP"] = step
           # BODY["LOOP"] = step
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
 
# sqrt(step)
d = 4 
f, axarr = plt.subplots(d,d)
i = 0
for k in range(0, d):
    for j in range(0, d):
       body = [records['BODY_PART(1)'][i], records['BODY_PART(2)'][i], records['BODY_PART(3)'][i], records['BODY_PART(4)'][i], records['BODY_PART(5)'][i], records['BODY_PART(6)'][i], records['BODY_PART(7)'][i], records['BODY_PART(8)'][i], records['BODY_PART(9)'][i], records['BODY_PART(10)'][i], records['BODY_PART(11)'][i]]
       robot = [records['ARM1'][i], records['ARM2'][i], records['END_EFF_B'][i], records['END_EFF_F'][i]]
       axarr[k,j].scatter(body, body, color='blue')
       axarr[k,j].scatter(robot, robot, color='red')
       # axarr[k,j].axes.get_xaxis().set_visible(False)
       # axarr[k,j].axes.get_yaxis().set_visible(False)
       axarr[k,j].axis([1, 9, 1, 9])
       axarr[k,j].grid(color='gray', linestyle='-')

plt.show()