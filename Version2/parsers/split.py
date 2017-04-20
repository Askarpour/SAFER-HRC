
import os
import sys

count = -1
hazard = 0

with open("count_0_to_3.txt", mode="r") as bigfile:
	if sys.argv[1] == "table":
	    reader = bigfile.read()
	    for i,part in enumerate(reader.split("------ time 0 ------")):
	        if i != 0:
	        	with open("File_" + str(i), mode="w") as newfile:
	         		newfile.write("------ time 0 ------"+part)
	         		os.system("python Table.py File_" + str(i) + " err > Table_"+ str(i))	
	         		os.system("python Table.py File_" + str(i) + " sa >> Table_"+ str(i))
#
	if sys.argv[1] == "info":
		f = open("count_0_to_3.txt")
		for line in f:
			line = line.strip()
			if line.startswith("---SAT"):
				if hazard % 15 == 0: 
					count += 1
					hazard = 0
					print "count = "+ str(count)
				hazard += 1
				print "hazard "+ str(hazard)
			elif line.startswith("---UNSAT"):
				if hazard % 15 == 0: 
					count += 1
					print "count = "+ str(count)
				hazard += 1