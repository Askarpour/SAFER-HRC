
import os
with open("count_0_to_3.txt", mode="r") as bigfile:
    reader = bigfile.read()
    for i,part in enumerate(reader.split("------ time 0 ------")):
        if i != 0:
        	with open("File_" + str(i), mode="w") as newfile:
         		newfile.write("------ time 0 ------"+part)
         		os.system("python Table.py File_" + str(i) + " err > Table_"+ str(i))	
         		os.system("python Table.py File_" + str(i) + " sa >> Table_"+ str(i))	
# for i in range(1 , 1, 60):
# 	os.system("python Table.py File_" + str(i) + " err > Table_"+ str(i))	