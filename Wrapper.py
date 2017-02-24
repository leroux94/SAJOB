# coding=utf-8

import os
import sys
import datetime
import time
from os import walk

# SAJOB version : 1.0.0
# This script is the starting point of SAJOB, it starts each module in order.
# See each python script for more info on them.
# All the output is redirect to a logfile to easily track error.

# Used to remove old log files
def cleanupOldLog():
    keep = 30  # config['days_to_keep_logs']
    removed = 0
    folder = sajobPath + '\Log'
    time_in_secs = time.time() - (keep * 86400)

    for the_file in os.listdir(folder):
        file_path = os.path.join(folder, the_file)
        if os.stat(file_path).st_mtime < time_in_secs:
            if os.path.isfile(file_path):
                print file_path
                removed += 1
                os.remove(file_path)

    print ('The log file cleanup removed ' + str(removed) + ' files')

# ### Start point ### #

# Config loading :
'''
config = dict()
try :
    print ("config_file = open('Wrapper_Config.ini', 'r')")
    config_file = open('Wrapper_Config.ini', 'r')

    for line in config_file:
        eq_index = line.find('=')
        var_name = line[:eq_index].strip()
        value = line[eq_index + 1:].strip()
        config[var_name] = value
config_file.close()

sajobPath =
'''

sajobPath = 'E:\DBASupport\SAJOB'

logfile = open(sajobPath + "\Log\Sajob_" + str(datetime.datetime.now().strftime("%Y%m%d-%H%M%S")) + ".log", "w")

sys.stdout = logfile
sys.stderr = logfile

print ("*** process started at " + str(datetime.datetime.now()) + " ***")

os.chdir(sajobPath + '\Param_Gen')
print ('*** Executing ' + sajobPath + '\Param_Gen\Param_Gen.py ***')
execfile(sajobPath + '\Param_Gen\Param_Gen.py')

os.chdir(sajobPath + '\Collector')
print ('*** Executing ' + sajobPath + "\Collector\Collector.py ***")
execfile(sajobPath + "\Collector\Collector.py")

os.chdir(sajobPath + '\Loader')
print ('*** Executing ' + sajobPath + "\Loader\Loader.py ***")
execfile(sajobPath + "\Loader\Loader.py")

os.chdir(sajobPath + '\Analyser')
print ('*** Executing ' + sajobPath + "\Analyser\Analyser.py ***")
execfile(sajobPath + "\Analyser\Analyser.py")

os.chdir(sajobPath + '\Emailer')
print ('*** Executing ' + sajobPath + "\Emailer\Emailer.py ***")
execfile(sajobPath + "\Emailer\Emailer.py")

cleanupOldLog()

print ("*** process completed at " + str(datetime.datetime.now()) + " *** \n")

input("prompt: ")