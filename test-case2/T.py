import numpy as np
import sys
import os
import matplotlib.pyplot as plt
plt.rcParams.update({'figure.figsize': (20,20)})
plt.matplotlib.rcParams.update({'font.size': 30})
import matplotlib.image as mpimg
import matplotlib
import matplotlib.patches as mpatches
from matplotlib import lines
import time
from termcolor import colored
import tables
import prettytable


#############################parsing the output file#############################
# File_name = sys.argv[1]
# output_type = sys.argv[1]
step = -1
body_parts_num = 11

class switch(object):
    def __init__(self, value):
        self.value = value
        self.fall = False

    def __iter__(self):
        """Return the match method once, then stop"""
        yield self.match
        raise StopIteration
   
    def pallet(element):
    	for case in switch(elelemnt):
    		 if case('head'):
    		 	return (1500,480)
    		 	break
     		 if case('hand'):
    		 	return (1400,520)
    		 	break
     		 if case('ro'):
    		 	return (1350,520)
    		 	break
    		 if case():
    		 	print ("something is wrong with coordinates of the object!")
	        		
    def match(self, *args):
        """Indicate whether or not to enter a case suite"""
        if self.fall or not args:
            return True
        elif self.value in args: # changed for v1.5, see below
            self.fall = True
            return True
        else:
            return False
def element_co(strin,element):
	for case in switch(strin):
	    if case('1'): #L1
	        return (200,300)
	        break
	    if case('2'): #L2
	        return (650,400)
	        break
	    if case('3'): #L3
	        return (950,400)
	        break
	    if case('4'): #L4
	        return (1100,480)
	        break
	    if case('5'): #L5
	        return (1200,550)
	        break
	    if case('6'): #L6
	        if element == 'head':
	        	return (1200,700)
	        if element == 'hand':
	        	return (1200,600)
	        if element == 'ro':
	        	return (1000,620)
	        break
	    if case('7'): #L7
	        return (600,1200)
	        break
	    if case('8'): #L8
	        return (600,1050)
	        break
	    if case('9'): #L9
	        return (600,800)
	        break
	    if case('10'): #L10
	        return (1200,480)
	        break    
	    if case(): # default, could also just omit condition or 'if True'
	        print ("something is wrong with coordinates of the object!")
def hazard_id(i):
	for case in switch(i):
	    if case(1):
	        return (hazard_occured_1, hazard_risk_1, hazard_se_1, 'Tr on Head area by EE')
	        # break
	    if case(2):
	        return (hazard_occured_2, hazard_risk_2, hazard_se_2, 'Tr on Waist area by EE')
	        # break
	    if case(3):
	        return (hazard_occured_3, hazard_risk_3, hazard_se_3, 'Tr on Arm area by EE')
	    	# break
	    if case(4):
	        return (hazard_occured_4, hazard_risk_4, hazard_se_4, 'Tr on Head area by R1')
        	# break
	    if case(5):
	        return (hazard_occured_5, hazard_risk_5, hazard_se_5, 'Tr on Waist area by R1')
	        # break
	    if case(6):
	        return (hazard_occured_6, hazard_risk_6, hazard_se_6, 'Tr on Arm area by R1')
	        # break
	    if case(7):
	        return (hazard_occured_7, hazard_risk_7, hazard_se_7, 'Tr on Head area by R2')
	        # break
	    if case(8):
	        return (hazard_occured_8, hazard_risk_8, hazard_se_8, 'Tr on Waist area by R2')
	        # break
	    if case(9):
	        return (hazard_occured_9, hazard_risk_9, hazard_se_9, 'Tr on Arm area by R2')
	        # break
	    if case(10):
	        return (hazard_occured_10, hazard_risk_10, hazard_se_10, 'Qs on Head area by EE')
	        # break
	    if case(11):
	        return (hazard_occured_11, hazard_risk_11, hazard_se_11, 'Qs on Waist area by EE')
	        # break
	    if case(12):
	        return (hazard_occured_12, hazard_risk_12, hazard_se_12, 'Qs on Arm area by EE')
	        # break
	    if case(13):
	    	return (hazard_occured_13, hazard_risk_13, hazard_se_13, 'Qs of Head area by R1')
	        # break
	    if case(14):
        	return (hazard_occured_14, hazard_risk_14, hazard_se_14, 'Qs of Waist area by R1')
	        # break
	    if case(15):
        	return (hazard_occured_15, hazard_risk_15, hazard_se_15, 'Qs of Arm area by R1')
	    if case(16):
	    	return (hazard_occured_16, hazard_risk_16, hazard_se_16, 'Qs of Head area by R2')
	        # break
	    if case(17):
        	return (hazard_occured_17, hazard_risk_17, hazard_se_17, 'Qs of Waist area by R2')
	        # break
	    if case(18):
        	return (hazard_occured_18, hazard_risk_18, hazard_se_18, 'Qs of Arm area by R2')
	        # break
	    if case	():
        	print ("something is wrong with hazards list!")
def low_mid (x):
    return{
            '1': 'low',
            '2': 'mid',
            '3': 'high',
    }[x]  
def close_far (x):
    return{
            '1': 'far',
            '2': 'mid',
            '3': 'close',
    }[x]    
def still_moving (strin, strout, j):
    if strin[j] == strin[j-1]: strout[j] = 'still'
    if strin[j] != strin[j-1]: strout[j] = 'moving'
    return 
def reach_leave (strin, strout, i, j, body_parts_num):
    if strin[i][j] == '0':
        if i == body_parts_num: strout[j] = 'leave'
    if strin[i][j] == '1':
        strout[j] = 'reach'
        i = body_parts_num
    return  
def chunks(l, n):
    n = max(1, n)
    return [l[i:i + n] for i in range(0, len(l), n)]

records = {}
bool_set = set()
EndEffPos={}
EndEffStill={}
Link1Pos={}
Link1Still={}
Link2Pos={}
Link2Still={}
BodyPartPosition={}
BodyPartPosition_name={}
BodypartStill={}
velocity={}
force={}
actions_num = 0
hazards_num = 0

def import_act_names(filename):
    in_file = open(filename,"r")
    act_names = []
    while 1:
        in_line = in_file.readline()
        if in_line == "":
            break
        else:
            str1 = str.split(in_line,";;")
        if str1[0]=="":
            act_names.append(str1[1])
    in_file.close()
    return act_names

def import_layout_sec(filename):
    in_file = open(filename,"r")
    sec_ids = []
    while 1:
        in_line = in_file.readline()
        if in_line == "(defun Adj (i j)\n":
            break
        else:
            str1 = in_line.split("defvar")
        if str1[0]=="(":
            str1 = str1[1].split()
            sec_ids.append(str1[0])
    in_file.close()
    return sec_ids

def read_file():
	global step
	global records
	global actions_num
	global hazards_num
	global Action_states

	
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

	               if 'ACTION_STATE_NS_' in key:
	               	temp = key.split('_NS_')
	               	temp = temp[1].split('_')
	               	temp[0]= int(temp[0])
	               	if temp[0] > actions_num:
	               		actions_num = temp[0]

	               if 'HAZARD_RISK' in key:
	               	temp = key.split('_RISK_')
	               	temp[1]= int(temp[1])
	               	records[key] = [value]
	               	if temp[1] > hazards_num:
	               		hazards_num = temp[1]
def parse_positions(step, records):
	global EndEffPos
	global EndEffStill
	global Link1Pos
	global Link1Still
	global Link2Pos
	global Link2Still


	EndEffPos = records['END_EFF_B_POSITION']
	Link1Pos= records['LINK1_POSITION']
	Link2Pos= records['LINK2_POSITION']
	EndEffStill[0] = Link1Still[0]= Link2Still[0] ='still'
	j = 1
	while j <= step:
	    still_moving (EndEffPos, EndEffStill, j)
	    still_moving (Link1Pos, Link1Still, j)
	    still_moving (Link2Pos, Link2Still, j)
	    j += 1

	global BodyPartPosition
	global BodyPartPosition_name
	global BodypartStill
	i = 1
	while i <= body_parts_num:
	    BodyPartPosition[i] = records['BODY_PART_POS('+str(i)+')']
	    i += 1

	j = 1
	while j <= step:
	    i = 1
	    while i <= body_parts_num:
	        if BodyPartPosition[i][j] == BodyPartPosition[i][j-1]:
	            if i == body_parts_num: BodypartStill[j] = 'still'
	        if BodyPartPosition[i][j] != BodyPartPosition[i][j-1]:
	            BodypartStill[j] = 'moving'
	            i = body_parts_num   

	        i += 1
	    j += 1

	i = 1


#############################creating the layout vision#############################
# create the figure and the axis in one shot
def create_legend (step,plt):
	legend = ''
	legendexe = ''
	legendexrm = ''
	legendex = ''
	legendhz = ''
	target = ''
	legendinex = ''
	legendintrusion = ''
	legenderror=''
	for i in range(1, actions_num+1,1):
		exec("if step in actions_EXE_%s_%s: legendexe +=  caseAact[i]" % (i,task_id))
	for i in range(1, actions_num+1,1):
		exec("if step in actions_EXRM_%s_%s: legendexrm += caseAact[i]" % (i,task_id))
	for i in range(1, actions_num+1,1):
		exec("if step in actions_INEX_%s_%s: legendexrm += caseAact[i] " % (i,task_id))
	for i in range(1, actions_num+1,1):
		exec("if step in actions_INEX_%s_%s: legendexrm += caseAact[i] " % (i,task_id))

	for i in range(1, actions_num+1, 1):
			for x in ('REPETITION', 'OMISSION', 'LATE', 'EARLY_START', 'EARLY_END','ERR_F', 'ERR_L' ):
				exec ("if step in %s_%s_%s:	legenderror += '%s of ' + caseAact[i]" % ( x, i, task_id,x))			
	for i in range(1, actions_num+1, 1):
			exec ("if step in INTRUSION_%s_%s:	legenderror += 'INTRUSION during ' + caseAact[i]" % (i, task_id))						

	for i in range (1, hazards_num+1,1):
		temp =''
		if step in hazard_id(i)[0]: temp = hazard_id(i)[3]
		if (int (hazard_id(i)[1][step])== 0) and (temp != ''): legendhz += temp +'(0)' +'\n' 
		if int (hazard_id(i)[1][step])== 1: legendhz += temp + '(1)'  + '\n'
		if int (hazard_id(i)[1][step])== 2: legendhz += temp + '(2)'  + '\n'
	if 	legendhz =='': legendhz += '-'	

	labely = "time "+str(step)
	label  = legendexe + legendexrm + '\n' + "errors: " + legenderror
	if label == '': label += '-'
	labelx = "executing: " + label
	title = "hazards: " + legendhz 
	plt.xlabel(title)
	plt.ylabel(labely)
	plt.title(labelx)

	return legend,

def draw_layout(ee, l1, l2, op_head, op_hand, step, task_id):
	#
	fig, ax = plt.subplots()
	layoutA = mpimg.imread("layoutA.png")
	ax.imshow(layoutA)
	# Turn off tick labels
	ax.set_yticklabels([])
	ax.set_xticklabels([])
	#
	L_base = mpatches.Circle((600,800),15, color="red")
	ax.add_patch(L_base)
	#
	L_head = mpatches.Circle((element_co(op_head,'head')[0],element_co(op_head,'head')[1]),35, color="blue")
	ax.add_patch(L_head)
	#
	L_hand = lines.Line2D([element_co(op_head,'head')[0], element_co(op_hand,'hand')[0]],[element_co(op_head,'head')[1], element_co(op_hand,'hand')[1]], lw=5., color="blue",zorder=1)
	ax.add_line(L_hand)
	#
	L_ee = mpatches.Circle((element_co(ee,'ro')[0],element_co(ee,'ro')[1]),15, color="red",zorder=2)
	ax.add_patch(L_ee)
	#
	L_l1 = lines.Line2D([600,element_co(l1,'ro')[0]],[800, element_co(l1,'ro')[1]], lw=9., color="red",zorder=2)
	ax.add_line(L_l1)
	#
	L_l2 = lines.Line2D([element_co(l1,'ro')[0], element_co(ee,'ro')[0] ],[element_co(l1,'ro')[1], element_co(ee,'ro')[1]], lw=9., color="red",zorder=2)
	ax.add_line(L_l2)
	#
	return ax.patches,

#############################creating tables#############################
def safety_analysis_table (tick,task_id):

	actions = ''
	hzs = ''
	risks = ''
	severities = ''
	
	for i in range(1, actions_num+1,1):
		exec("if tick in actions_EXE_%s_%s: actions += caseAact[i]  " % (i,task_id))
	for i in range(1, actions_num+1,1):
		exec("if tick in actions_EXRM_%s_%s: actions += caseAact[i] " % (i,task_id))
	for i in range(1, actions_num+1,1):
		exec("if tick in actions_INEX_%s_%s: actions += caseAact[i] " % (i,task_id))	
	#
	from prettytable import PrettyTable
	GstateSA = PrettyTable()
	GstateSA.field_names = ["t","Executing", "Hazards","Se","Risk","force","velocity"]
	GstateSA.add_row([tick, "actions - V1" ,"","","","",""])
	GstateSA.add_row(["", actions ,"","","",force[tick],velocity[tick]])
	for i in range (1, hazards_num+1,1):
		if tick in hazard_id(i)[0]: 
			exec("hzs = hazard_id(%s)[3]" % (i))
			exec("risks = hazard_risk_%s[tick]" % (i))
			exec("severities = hazard_se_%s[tick]" % (i))
			GstateSA.add_row(["", "",hzs,severities,risks,"",""])
	return GstateSA	

#############################executing zot and processing the output#############################
if __name__ == '__main__':
	os.system("zot Main.lisp")
	#wait for output.hist
	while not os.path.exists('output.hist.txt'):time.sleep(1)
	if os.path.isfile('output.hist.txt'):
		read_file()
		task_id = 1
		# parse actions
		for i in range(1, actions_num+1, 1):
			for x in ('NS', 'WT', 'EXE', 'EXRM', 'HD', 'DN','INEX', 'EX' ):
				exec ("actions_%s_%s_%s={}" % (x, i ,task_id))
				exec ("if 'ACTION_STATE_%s_%s_%s' in records.keys():	actions_%s_%s_%s = records['ACTION_STATE_%s_%s_%s']" % ( x, i, task_id, x, i,task_id, x,i,task_id))	
		
		# parse hazards
		for i in range (1, hazards_num+1, 1):
			exec("hazard_occured_%s = {}" % (i))
			exec("hazard_risk_%s = {}" % (i))
			exec ("if 'HAZARD_OCCURED_%s' in records.keys():	hazard_occured_%s = records['HAZARD_OCCURED_%s']" % (i ,i, i))
			exec ("hazard_risk_%s = records['HAZARD_RISK_%s']" % (i ,i))
			exec ("hazard_se_%s = records['HAZARD_SE_%s']" % (i ,i))

		# parse errors
		for i in range(1, actions_num+1, 1):
			for x in ('REPETITION', 'OMISSION', 'LATE', 'EARLY_START', 'EARLY_END', 'INTRUSION','ERR_F', 'ERR_L' ):
				exec ("%s_%s_%s={}" % (x, i , task_id))
				exec ("if '%s_%s_%s' in records.keys():	%s_%s_%s = records['%s_%s_%s']" % ( x, i, task_id, x, i, task_id, x,i, task_id))	
		
		# parse positions
		parse_positions(step, records)
		caseAact = import_act_names("TaskLib/T1.lisp")
		caseAlayout = import_layout_sec("ORL-Module/L.lisp")
		errors = import_act_names("TaskLib/fcm.lisp")

		# parse relative attributes
		for i in range (0, step+1):
			for x in ('LOW', 'CRITICAL', 'NORMAL'):
				exec ("if 'RELATIVEVELOCITY_%s' in records.keys() and i in records['RELATIVEVELOCITY_%s']:	velocity[i] = x" % (x,x))
				exec ("if 'RELATIVEFORCE_%s' in records.keys() and i in records['RELATIVEFORCE_%s']:	force[i] = x" % (x,x))

		for i in force:
			if 	force[i]=='CRITICAL': force[i]='high'
			elif 	force[i]=='LOW': force[i]='low'
			elif 	force[i]=='NORMAL': force[i]='mid'

		for i in velocity:
			if 	velocity[i]=='CRITICAL': velocity[i]='high'
			elif 	velocity[i]=='LOW': velocity[i]='low'
			elif 	velocity[i]=='NORMAL': velocity[i]='mid'	
		
		# if output_type == 'fig':
		index = 1
		newpath = 'Output'
		while 1:
			name = str(index)
			if not os.path.exists(newpath+name):
				os.makedirs(newpath+name)
				folder = newpath+name
				break
			else:
				index += 1

		for i in range (0, step+1):
			draw_layout(EndEffPos[i], Link1Pos[i], Link2Pos[i], BodyPartPosition[1][i], BodyPartPosition[7][i], i, 1)
			# plt.show()
			create_legend (i,plt)
			plt.savefig(folder+"/Time"+str(i)+".png")

		# elif output_type == 'table':
		f = open(folder+'/Table.txt','w')
		for i in range (0, step+1):
			table = safety_analysis_table(i, task_id)
			table_txt = table.get_string()
			f.write(table_txt)

	else:
		raise ValueError("output.hist.txt not found!")
	
	
