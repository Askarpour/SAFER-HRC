
import os
import sys

count = -1
hazard = 0
file_name = sys.argv[1]
SAT = -1
path = "tables/outputs"

if not os.path.exists(path):
    os.makedirs(path)
#
f = open(file_name)
for line in f:
	line = line.strip()
	if line.startswith("---SAT"):
		SAT = 1
		if hazard % 15 == 0:
			count += 1
			hazard = 0
			print "count = "+ str(count)
		hazard += 1
		print "hazard "+ str(hazard)
		#
	if line.startswith("---UNSAT"):
		SAT = 0
		if hazard % 15 == 0:
			count += 1
			hazard = 0
			print "count = "+ str(count)
		hazard += 1
		#
	elif SAT == 1:
		newfile = open(os.path.join(path, "Hazard_" + str(hazard) + "_count_" + str(count)), mode="a")
		newfile.write(line )
		newfile.write("\n")

for f in os.listdir(path):
	os.system("python Table.py tables/outputs/" + str(f) + " info > tables/Table_"+ str(f))
	os.system("python Table.py tables/outputs/" + str(f) + " err >> tables/Table_"+ str(f))
	os.system("python Table.py tables/outputs/" + str(f) + " sa >> tables/Table_"+ str(f))


