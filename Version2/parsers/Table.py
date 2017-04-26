import tables
import numpy as np
import sys
import prettytable


def layout_parser (x):
    return{
            '0': 'L_0',
            '1': 'L_1_1',
            '2': 'L_1_2',
            '3': 'L_1_3',
            '4': 'L_2_1',
            '5': 'L_2_2',
            '6': 'L_2_3',
            '7': 'L_2_4',
            '8': 'L_3_1',
            '9': 'L_3_2',
            '10': 'L_3_4',
            '11': 'L_4_1',
            '12': 'L_4_2',
            '13': 'L_5_1',
            '14': 'L_6_1',
            '15': 'L_6_2',
            '16': 'L_6_3',
            '17': 'L_7_1',
            '18': 'L_7_2',
            '19': 'L_7_3',
            '20': 'L_8_1',
            '21': 'L_8_2',
    }[x]
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

def exe_parser (x):
    return{
            '0': 'ns',
            '1': 'wt',
            '2': 'exe',
            '3': 'exrm',
            '4': 'hold',
            '5': 'done',
            '6': 'exit',
    }[x]  

def execution_parser (strin , strout):
    if strin == ['0']: strout = 'ns'
    if strin == ['1']: strout = 'wt'
    if strin == ['2']: strout = 'exe'
    if strin == ['3']: strout = 'exrm'
    if strin == ['4']: strout = 'hold'
    if strin == ['5']: strout = 'done'
    if strin == ['6']: strout = 'exit'
    return

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
    

    

      
#arguments
File_name = sys.argv[1]
Table_type = sys.argv[2]
Task = {}
if Table_type=="state":
    Task = sys.argv[3]


step = -1
tasks_num = 4
actions_num = 0
actions1_num = 0
err1_num = 0
actions2_num = 0
err2_num = 0
actions3_num = 0
err3_num = 0
actions4_num = 0
err4_num = 0
RRM_num = 0
hazards_num = 15
body_parts_num = 11


#parsing numbers

def chunks(l, n):
    n = max(1, n)
    return [l[i:i + n] for i in range(0, len(l), n)]
records = {}
bool_set = set()
f = open(File_name)
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

           if 'ACTIONS(' in key:
               if '4)' in key:
                temp = key.split('(')
                temp = temp[1].split(' ')
                temp[0]= int(temp[0])
                if temp[0] > actions4_num:
                        actions4_num = temp[0]
               if '3)' in key:
                    temp = key.split('(')
                    temp = temp[1].split(' ')
                    temp[0]= int(temp[0])
                    if temp[0] > actions3_num:
                        actions3_num = temp[0]
               if '2)' in key:
                    temp = key.split('(')
                    temp = temp[1].split(' ')
                    temp[0]= int(temp[0])
                    if temp[0] > actions2_num:
                        actions2_num = temp[0]
               if '1)' in key:
                    temp = key.split('(')
                    temp = temp[1].split(' ')
                    temp[0]= int(temp[0])
                    if temp[0] > actions1_num:
                        actions1_num = temp[0]
           if 'RRM(' in key:
                temp = key.split('(')
                temp = temp[1].split(')')
                temp[0]= int(temp[0])
                if temp[0] > RRM_num:
                    RRM_num = temp[0]



EndEffPos={}
EndEffStill={}
Link1Pos={}
Link1Still={}
Link2Pos={}
Link2Still={}

i = 0
EndEffPos = records['END_EFF_F_POSITION']
Link1Pos= records['LINK1_POSITION']
Link2Pos= records['LINK2_POSITION']

EndEffStill[0] = Link1Still[0]= Link2Still[0] ='still'
j = 1
while j <= step:
    still_moving (EndEffPos, EndEffStill, j)
    still_moving (Link1Pos, Link1Still, j)
    still_moving (Link2Pos, Link2Still, j)
    j += 1

BodyPartPosition={}
BodyPartPosition_name={}
BodypartStill={}
i = 1
while i <= body_parts_num:
    BodyPartPosition[i] = records['BODY_PART_POS('+str(i)+')']
    i += 1

# BodyPartPosition_name = BodyPartPosition

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
MOVEDIRECTIONENDEFF={}
EndEffFinalDirection= {}

MOVEDIRECTIONLINK2={}
Link2FinalDirection={}

MOVEDIRECTIONLINK1={}
Link1FinalDirection= {}


while i <= body_parts_num:
    MOVEDIRECTIONENDEFF[i] = records['MOVEDIRECTIONENDEFF('+str(i)+')']
    MOVEDIRECTIONLINK2[i] = records['MOVEDIRECTIONLINK2('+str(i)+')']
    MOVEDIRECTIONLINK1[i] = records['MOVEDIRECTIONLINK1('+str(i)+')']
    i += 1


j = 0
while j <= step:
    i = 1
    while i <= body_parts_num:
        reach_leave (MOVEDIRECTIONENDEFF, EndEffFinalDirection, i, j, body_parts_num)
        reach_leave (MOVEDIRECTIONLINK2, Link2FinalDirection, i, j, body_parts_num)
        reach_leave (MOVEDIRECTIONLINK1, Link1FinalDirection, i, j, body_parts_num)
        i += 1
    j += 1


velocity={}
velocity = records['RELATIVEVELOCITY']

force={}
force = records['RELATIVEFORCE']

i= 0
while i<= step:
    low_mid(velocity[i])
    low_mid(force[i])
    i+=1


separationEE={}
separationL1={}
separationL2={}
i = 0
while i<= step:
    j = 1
    while j <= body_parts_num:
     separationEE[i] = records['RELATIVESEPARATIONENDEFF('+str(j)+')']
     separationL1[i] = records['RELATIVESEPARATIONLINK1('+str(j)+')']
     separationL2[i] = records['RELATIVESEPARATIONLINK2('+str(j)+')']
     j +=1
    i += 1

separationEEmax={}
separationL1max={}
separationL2max={}
i = 0
while i < step:
 #   
    for o in separationEE[i]:
        if o == '3':
            separationEEmax[i]='close'
            break
        separationEEmax[i]='far'
#
    for o in separationL1[i]:
        if o == '3':
            separationL1max[i]='close'
            break
        separationL1max[i]='far' 
#
    for o in separationL2[i]:
        if o == '3':
            separationL2max[i]='close'
            break
        separationL2max[i]='far'
#
    i += 1


risk={}
risk = chunks (records['RISK'],1)


i= 0
while i<= step:
    if risk[i] == ['0']: risk[i]='0'
    if risk[i] == ['1']: risk[i]='1'
    if risk[i] == ['2']: risk[i]='2'
    i += 1

i = 0
j = 0
action_state1={}
action_state2={}
action_state3={}
action_state4={}


##state of each action

#Task 1
while i < actions1_num:
    i += 1
    action_state1[i] = chunks (records['ACTIONS('+str(i)+ ' 1 1)'],1)
i = 1
while i <= actions1_num:
    j = 0
    while j <= step:
        # execution_parser (action_state1[i][j] , action_state1[i][j])
        if action_state1[i][j] == ['0']: action_state1[i][j] = 'ns'
        if action_state1[i][j] == ['1']: action_state1[i][j] = 'wt'
        if action_state1[i][j] == ['2']: action_state1[i][j] = 'exe'
        if action_state1[i][j] == ['3']: action_state1[i][j] = 'exrm'
        if action_state1[i][j] == ['4']: action_state1[i][j] = 'hold'
        if action_state1[i][j] == ['5']: action_state1[i][j] = 'done'
        if action_state1[i][j] == ['6']: action_state1[i][j] = 'exit'
        j += 1
    i +=1

i = 0
j = 0
action_doer={}
while i < actions1_num:
    i += 1
    action_doer[i] = chunks (records['ACTIONS('+str(i)+ ' 3 1)'],1)


#Task2
i = 0
while i < actions2_num:
    i += 1
    action_state2[i] = chunks (records['ACTIONS('+str(i)+ ' 1 2)'],1)

i = 1
while i <= actions2_num:
    j = 0
    while j <= step:
        execution_parser (action_state2[i][j] , action_state2[i][j])
        j += 1
    i +=1


i = 0
while i < actions3_num:
    i += 1
    action_state3[i] = chunks (records['ACTIONS('+str(i)+ ' 1 3)'],1)

i = 1
while i <= actions3_num:
    j = 0
    while j <= step:
        execution_parser (action_state3[i][j] , action_state3[i][j])
        j += 1
    i +=1



i = 0
while i < actions4_num:
    i += 1
    action_state4[i] = chunks (records['ACTIONS('+str(i)+ ' 1 4)'],1)

i = 1
while i <= actions4_num:
    j = 0
    while j <= step:
        execution_parser (action_state3[i][j] , action_state3[i][j])
        j += 1
    i +=1


i = 0
RRM={}
while i < RRM_num:
    i += 1
    RRM[i] = chunks (records['RRM('+str(i)+ ')'],1)

i = 0
hazard_state={}
hazard_severity={}
hazard_region={}
hazard_risk={}
hazard_ci={}
while i < hazards_num:
    i += 1
    hazard_state[i] = chunks (records['HAZARDS('+str(i)+ ' 0)'],1)
    hazard_ci[i] = chunks (records['HAZARDS('+str(i)+ ' 1)'],1)
    hazard_severity[i] = chunks (records['HAZARDS('+str(i)+ ' 3)'],1)
    hazard_risk[i] = chunks (records['HAZARDS('+str(i)+ ' 4)'],1)
    hazard_region[i] = chunks (records['HAZARDS('+str(i)+ ' 5)'],1)


#
i = 1
j = 0
while i <= hazards_num:
    j = 0
    while j <= step:
        if hazard_state[i][j] == ['1']:
            if i == 1: hazard_state[i][j]= 'Tr on Head area by EE'
            if i == 2: hazard_state[i][j]= 'Tr on Waist area by EE'
            if i == 3: hazard_state[i][j]= 'Tr on Arm area by EE'

            if i == 4: hazard_state[i][j]= 'Tr on Head area by R1'
            if i == 5: hazard_state[i][j]= 'Tr on Waist area by R1'
            if i == 6: hazard_state[i][j]= 'Tr on Arm area by R1'

            if i == 7: hazard_state[i][j]= 'Tr on Head area by R2'
            if i == 8: hazard_state[i][j]= 'Tr on Waist area by R2'
            if i == 9: hazard_state[i][j]= 'Tr on Arm area by R2'

            if i == 10: hazard_state[i][j]= 'Qs of Head area by R1'
            if i == 11: hazard_state[i][j]= 'Qs of Waist area by R1'
            if i == 12: hazard_state[i][j]= 'Qs of Arm area by R1'

            if i == 13: hazard_state[i][j]= 'Qs of Head area by R2'
            if i == 14: hazard_state[i][j]= 'Qs of Waist area by R2'
            if i == 15: hazard_state[i][j]= 'Qs of Arm area by R2'

            if i == 16: hazard_state[i][j]= 'Operational Error'


        j += 1
    i += 1

################
i = 0
err_state1={}
errA_repetition_state1={}
errA_Omission_state1={}
errA_Late_state1={}
errA_early_state1={}
errA_insertion_state1={}
errF_state1={}
errL_state1={}
while i < actions1_num:
    i += 1
    err_state1[i] = chunks (records['ACTIONS('+str(i)+ ' 4 1)'],1)
    # errA_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1)'],1)
    errA_repetition_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1 1)'],1)
    errA_Omission_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1 2)'],1)
    errA_Late_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1 3)'],1)
    errA_early_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1 4)'],1)
    errA_insertion_state1[i] = chunks (records['ERRORA('+str(i)+ ' 1 5)'],1)
    errF_state1[i] = chunks (records['ERRORF('+str(i)+ ' 1)'],1)
    errL_state1[i] = chunks (records['ERRORL('+str(i)+ ' 1)'],1)

i = 1
while i <= actions1_num:
    j = 0
    while j <= step:
        if err_state1[i][j] == ['0']: err_state1[i][j] = 'norm'
        if err_state1[i][j] == ['1']: err_state1[i][j] = 'err'
        j += 1
    i +=1
#


###########
#safety analysis table
if Table_type == "sa":
    from prettytable import PrettyTable
    i = 1
    j = 0
    while i < step:
        GstateSA = PrettyTable()
        GstateSA.field_names = ["t" , "Executing","Hazards","L_k","Se","Still/Move","Moving Directions","v","f", "Sep(ee,op)", "Sep(R1,op)", "Sep(R2,op)","Risk"]
        GstateSA.add_row (["" , "action  -  V ", "","","","Op - EE - R2  - R1","EE - R2  - R1","", "", "", "","",""])
        GstateSA.add_row([str(i),"","","","","","","","","","","",""])
        GstateSA.add_row(["","","","","",BodypartStill[i]+ '-' + EndEffStill[i] +'-'+ Link2Still[i]+'-'+ Link1Still[i],EndEffFinalDirection[i]+ '-'+Link2FinalDirection[i] +'-'+ Link1FinalDirection[i] ,velocity[i],force[i],separationEEmax[i],separationL1max[i],separationL2max[i],risk[i]])

        j = 1
        while j<= actions1_num:
            if action_state1[j][i] == 'exe' or action_state1[j][i] == 'exrm':
                GstateSA.add_row(["", str(j)+ "   -   1","","","","","","","","","","",""])
            j += 1

        j = 1
        while j<= actions2_num:
            if action_state2[j][i] == 'exe' or action_state2[j][i] == 'exrm':
                GstateSA.add_row(["", str(j)+ "   -   2","","","","","","","","","","",""])
            j += 1
        j = 1
        while j<= actions3_num:
            if action_state3[j][i] == 'exe' or action_state3[j][i] == 'exrm':
                GstateSA.add_row(["", str(j)+ "   -   3","","","","","","","","","","",""])
            j += 1

        j= 1
        while j<= actions4_num:
            if action_state4[j][i] == 'exe' or action_state4[j][i] == 'exrm':
                GstateSA.add_row(["", str(j)+ "   -   4","","","","","","","","","","",""])
            j += 1

    #
        j= 1
        while j<= hazards_num:
            if hazard_state [j][i] != ['0']:
                GstateSA.add_row(["","",hazard_state[j][i],hazard_region[j][i],hazard_severity[j][i],"","","","","","","",""])
            j += 1
    #
        j= 1
        i += 1
        print GstateSA
#
########################
#erroneous states
if Table_type == "err":
    from prettytable import PrettyTable
    i = 0
    j = 0
    while i < step:
        Gstate_err = PrettyTable()
        Gstate_err.field_names = ["t" , "Action", "status","Erroneous State","error type","Hazards","Risk","RRMs"]
        Gstate_err.add_row([str(i),"","","","L - F - A","","",""])
        Gstate_err.add_row(["","","","","","",risk[i],""])
    #
        j = 1
        while j<= actions1_num:
           
            err_A = ""
            err_A += str(errL_state1[j][i])
            err_A += " , "
            err_A += str(errF_state1[j][i])
            err_A += " , ("
            if errA_repetition_state1[j][i] == ['1']: err_A = err_A + 're '
            if errA_Omission_state1[j][i] == ['1']: err_A = err_A + 'om '
            if errA_Late_state1[j][i] == ['1']: err_A = err_A+'la '
            if errA_early_state1[j][i] == ['1']: err_A = err_A+'ea '
            if errA_insertion_state1[j][i] == ['1']: err_A = err_A+'in'
            err_A += ")"
            err_A = err_A.replace("[", "")
            err_A = err_A.replace("]", "")
            err_A = err_A.replace("'", "")
            if action_doer[j][i] ==['1']:
                Gstate_err.add_row(["",str(j)+ "   -   1",action_state1[j][i],err_state1[j][i],err_A,"","",""])
            j += 1
    #
        #
        k= 1
        while k<= hazards_num:
            if hazard_state [k][i] != ['0']:
                Gstate_err.add_row(["","","","","",hazard_state [k][i],"",""])
            k += 1
    #
        k = 1
        while k<= RRM_num:
            if RRM[k][i] != ['0']:
                Gstate_err.add_row(["","","","","","","",str(k)])
            k += 1
    #
        k= 1
        i += 1
        print Gstate_err
# #####################
#execution status
num = 0
action_state ={}
if Task == "T1":
    num = actions1_num
    action_state = action_state1
elif Task == "T2":
    num = actions2_num
    action_state = action_state2
elif Task == "T3":
    num = actions3_num
    action_state = action_state3
elif Task == "T4":
    num = actions4_num
    action_state = action_state4
#
if Table_type == "state":
    from prettytable import PrettyTable
    i = 1
    j = 0
    while i < step:
        Gstate_status = PrettyTable()
        Gstate_status.field_names = ["t" , "ns","wt","exe","exrm","hold","in-exit","exit","done"]
        Gstate_status.add_row([str(i),"","","","","","","",""])

        j= 1
        while j<= num:
            if action_state[j][i] == 'ns':
                Gstate_status.add_row(["", str(j),"","","","","","",""])
            if action_state[j][i] == 'wt':
                Gstate_status.add_row(["","", str(j),"","","","","",""])
            if action_state[j][i] == 'exe':
                Gstate_status.add_row(["","","",str(j),"","","","",""])
            if action_state[j][i] == 'exrm':
                Gstate_status.add_row(["","","","", str(j),"","","",""])
            if action_state[j][i] == 'hold':
                Gstate_status.add_row(["","","","","", str(j),"","",""])
            if action_state[j][i] == 'inexitt':
                Gstate_status.add_row(["","","","","", "",str(j),"",""])
            if action_state[j][i] == 'exit':
                Gstate_status.add_row(["","","","","", "","",str(j),""])
            if action_state[j][i] == 'done':
                Gstate_status.add_row(["","","","","", "","","",str(j)])
            j += 1
        i += 1
        print Gstate_status
# i = 1
if Table_type == "positions":
    from prettytable import PrettyTable
    while i < step:
        Gstate_status = PrettyTable()
        Gstate_status.field_names = ["step","Link 1", "Link 2", "EndEff", "still/moving", "relative force", "relative Speed"]
        Gstate_status.add_row([str(i),Link1Pos[i],Link2Pos[i],EndEffPos[i],BodypartStill[i]+ '-' + EndEffStill[i] +'-'+ Link2Still[i]+'-'+ Link1Still[i],velocity[i],force[i]])
        i += 1
        print Gstate_status
#
if Table_type == "info":
    k = 1
    i = 1
    while i < step:
        print ("-----------------time"+str(i)+"-----------------")
        j = 1
        while j<= actions1_num:
            if action_state1[j][i] == 'exe' or action_state1[j][i] == 'exrm':
                print "Action "+ str(j)+ " is executing."
            j += 1  

        if Link1Still[i] == 'still': print "Link1 is still in " + layout_parser(Link1Pos[i])
        else: print "Link1 is moving in " + layout_parser(Link1Pos[i])
        
        if Link2Still[i] == 'still': print "Link2 is still in " + layout_parser(Link2Pos[i])
        else: print "Link2 is moving in " + layout_parser(Link2Pos[i])
        
        if EndEffStill[i] == 'still': print "EndEff is still in " + layout_parser(EndEffPos[i])
        else: print "EndEff is moving in " + layout_parser(EndEffPos[i])

        print "the operator's head is in " + layout_parser(BodyPartPosition[1][i])
        print "the operator's shoulders are in " + layout_parser(BodyPartPosition[2][i])
        print "the operator's chest is in " + layout_parser(BodyPartPosition[3][i])
        print "the operator's belly is in " + layout_parser(BodyPartPosition[4][i])
        print "the operator's pelvis is in " + layout_parser(BodyPartPosition[5][i])
        print "the operator's upper arms are in " + layout_parser(BodyPartPosition[6][i])
        print "the operator's hands are in " + layout_parser(BodyPartPosition[7][i])
        print "the operator's thigs are in " + layout_parser(BodyPartPosition[8][i])
        print "the operator's legs are in " + layout_parser(BodyPartPosition[9][i])
        print "the operator's neck is in " + layout_parser(BodyPartPosition[10][i])
        print "the operator's lower arms are in " + layout_parser(BodyPartPosition[11][i])
        i += 1  


