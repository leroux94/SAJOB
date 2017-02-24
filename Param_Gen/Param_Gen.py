# coding=utf-8
#!/usr/bin/python

import pyodbc
import sqlite3
import csv
import os


def processSql(serverName,Username,Password):

    #connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;UID="+Username+";PWD="+Password
    connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;Trusted_Connection=yes;"
    print connectstring
    cnxn = pyodbc.connect(connectstring)
    Param_Gen_Query_File = csv.reader(open("./Param_Gen_SQLServer_Query.csv", "rt"),delimiter='~')
    
    for row in Param_Gen_Query_File:
        File_Name = row[0]
        Query = row[1]
        csv_cursor = cnxn.cursor()
        #print(Query)
        csv_cursor.execute(Query)
        csv_file = open("./Parameter_File/" + File_Name + ".csv", "w")
        csv_writer = csv.writer(csv_file, delimiter = '~', lineterminator='\n')
        #csv_file = open("./Parameter_File/" + File_Name + ".csv", "w", newline='')
        #csv_writer = csv.writer(csv_file, delimiter = '~')
        csv_writer.writerows(csv_cursor)
        csv_file.close()


def processSQLite(serverName):

    print ("Loading parameter from SQLite Database" + serverName)
    conn = sqlite3.connect(serverName)
    Param_Gen_Query_File = csv.reader(open("./Param_Gen_SQLite_Query.csv", "rt"), delimiter='~')

    for row in Param_Gen_Query_File:
        file_name = row[0]
        query = row[1]
        csv_cursor = conn.cursor()
        csv_cursor.execute(query)
        csv_file = open("./Parameter_File/" + file_name + ".csv", "w")
        csv_writer = csv.writer(csv_file, delimiter='~', lineterminator='\n')
        csv_writer.writerows(csv_cursor)
        csv_file.close()
    print ('Parameter loading completed')
             
def processOracle(serverName,Username,Password):
    print ("Oracle server " + serverName)

def processDB2(serverName,Username,Password):
    print ("DB2 server " + serverName)

def processMYSQL(serverName,Username,Password):
    print ("MYSQL server " + serverName)




######### Main Program ##################

#Chargement des parametre
config = dict()

config_file = open('./Param_Gen_Config.ini', 'r')

for line in config_file:
    eq_index = line.find('=')
    var_name = line[:eq_index].strip()
    value = line[eq_index + 1:].strip()
    #print value
    config[var_name] = value

#Redirection vers la bonne procÃ©dure selon le SGBD
if config["tech"] == "SQL":
    processSql(config["dbserver"],config["UID"],config["PWD"])
elif config["tech"] == "ORACLE":
    processOracle(config["dbserver"],config["UID"],config["PWD"])
elif config["tech"] == "SQLITE":
    processSQLite(config["dbserver"])
else:
    print ("Unknown SGBD")
        




