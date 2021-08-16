import os 
import numpy as np
import sys
import csv

path = sys.argv[1]

dirs = os.listdir(path)
dirs.sort()

print(path)
foo = open(path+'/summary.txt', 'w')
csvfoo = open(path+'/summary.csv', 'w')
csvwriter = csv.writer(csvfoo)#, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

string='network\t\t\t offline (MB) \t\t\t online(MB)\t\t\ttotal (MB)\t\t\t offline (s) \t\t\t online(s) \t\t\ttotal (s)\n'
csvwriter.writerow(['network', 'offline (MB)', 'online(MB)', 'Linear total (MB)', 'Nonlinear total(MB)', 'total (MB)', 'offline(s)', 'online (s)', 'Linear total (s)', 'Nonlinear total(s)','total(s)', 'total with setup(s)'])
print(string,file=foo)
for d in dirs:
	if not '.txt' in d:
		continue
	f = open(path+'/'+d,'r')
	lin_com_online = 0
	lin_com_offline = 0
	lin_time_online = 0
	lin_time_offline = 0
	lin_time_setup = 0

	nonlin_com_online = 0
	nonlin_com_offline = 0
	nonlin_time_online = 0
	nonlin_time_offline = 0
	nonlin_time_setup = 0

	for line in f.readlines():
		if len(line.split())==0:
			continue
		type_ = line.split()[0]
		# print(line.split())
			
		if 'CONV' in type_ or 'FC' in type_:
			comm_offline = 0#loat(line.split()[1])
			comm_online = 0#loat(line.split()[2])
			time_offline = float(line.split()[3])
			time_online = float(line.split()[4])
			time_setup = float(line.split()[5])	
			lin_com_online += comm_online
			lin_com_offline += comm_offline
			lin_time_online += time_online
			lin_time_offline += time_offline
			lin_time_setup += time_setup
		elif 'MP' in type_ or "ReLU" in type_:
			comm_offline = 0#loat(line.split()[1])
			comm_online = 0#float(line.split()[2])
			time_offline = float(line.split()[3])
			time_online = float(line.split()[4])
			time_setup = float(line.split()[5])	
			nonlin_com_online += comm_online
			nonlin_com_offline += comm_offline
			nonlin_time_online += time_online
			nonlin_time_offline += time_offline
			nonlin_time_setup += time_setup
		else:
			continue
	offline_comm = (lin_com_offline+nonlin_com_offline)/(1e6)
	online_comm = (lin_com_online+nonlin_com_online)/(1e6)
	lin_comm = (lin_com_offline+lin_com_online)/(1e6)
	nonlin_comm = (nonlin_com_offline+nonlin_com_online)/(1e6)
	total_comm = (offline_comm+online_comm)/(1e6)
	offline_time = lin_time_offline+nonlin_time_offline
	online_time = lin_time_online+nonlin_time_online
	setup_time = lin_time_setup+nonlin_time_setup
	total_time = offline_time+online_time
	total_time_with_setup = total_time + setup_time
	lin_time = (lin_time_offline+lin_time_online)
	nonlin_time = (nonlin_time_offline+nonlin_time_online)

	string = '%s\t\t\t%0.3f\t\t\t%0.3f\t\t\t%0.3f\t\t\t%0.3f\t\t\t%0.3f\t\t\t%0.3f\t\t\t%0.3f\n'%(d[0:-4],offline_comm, online_comm, total_comm,offline_time, online_time, total_time, total_time_with_setup)
	csvwriter.writerow([d[0:-4],offline_comm, online_comm, lin_comm, nonlin_comm, total_comm, offline_time, online_time, lin_time, nonlin_time, total_time, total_time_with_setup])
	print(string, file=foo)
	# print('communication cost for linear layers of', d[0:-4], 'was', comm_linear/(10.0**9), 'GBs')


foo.close()
csvfoo.close()

