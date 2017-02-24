# coding=utf-8
#!/usr/bin/python

import pyodbc
import sqlite3
import csv
import os

def processSql(serverName,Query,Username,Password):

    # connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;UID="+Username+";PWD="+Password
    connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;Trusted_Connection=yes;"
    Insert_Query = "INSERT INTO [SAJOB_Data].[SAJOB].[Analyse_Log] ([A_A_Run_Num] ,[A_Log_Job_ID] ,[A_Log_Query_ID] ,[A_Log_Row_Mod]) select max(ID) ,? ,? ,? from [SAJOB_Data].[SAJOB].[Analyse_NumberGenerator]"
    Error_Query = "INSERT INTO [SAJOB_Data].[SAJOB].[Error_Analyse_Log] ([Error_Analyse_Run] ,[Error_Sev] ,[Error_Num] ,[Error_Text] ,[Error_Time] ,[Error_Job] ,[Error_Query]) select max(ID), 2, 11, ?  , GETDATE(),? ,? from [SAJOB_Data].[SAJOB].[Analyse_NumberGenerator]"
    Query_cnxn = pyodbc.connect(connectstring)
    Query_cursor = Query_cnxn.cursor()
    Analyse_cnxn = pyodbc.connect(connectstring)
    Analyse_cursor = Analyse_cnxn.cursor()
    
    Query_cursor.execute(Query)
    

    for Query_A in Query_cursor:

        try:
            row_A = Analyse_cursor.execute(Query_A[4]).rowcount
        except pyodbc.Error, err:
            error = "'" + str(err) + "'"
            Analyse_cursor.rollback()
            print error
            Analyse_cursor.execute(Error_Query, (error,Query_A[0],Query_A[2]))
            Analyse_cursor.commit()
        else:
            Analyse_cursor.commit()
        
            Analyse_cursor.execute(Insert_Query, (Query_A[0],Query_A[2],row_A))
            Analyse_cursor.commit()

def processOracle(serverName,Username,Password):
    print ("Oracle server " + serverName)

def processSQLite(serverName, Query):
    print ("SQLite server " + serverName)

    Insert_Query = "INSERT INTO [Analyse_Log] ([A_A_Run_Num] ,[A_Log_Job_ID] ,[A_Log_Query_ID] ,[A_Log_Row_Mod]) select max(ID) ,? ,? ,? from [Analyse_NumberGenerator]"
    Error_Query = "INSERT INTO [Error_Analyse_Log] ([Error_Analyse_Run] ,[Error_Sev] ,[Error_Num] ,[Error_Text] ,[Error_Time] ,[Error_Job] ,[Error_Query]) select max(ID), 2, 11, ?  , datetime('now', 'localtime'),? ,? from [Analyse_NumberGenerator]"
    Analyse_cnxn = sqlite3.connect(serverName)
    Query_cursor = Analyse_cnxn.cursor()
    Analyse_cursor= Analyse_cnxn.cursor()

    Query_cursor.execute(Query)

    for Query_A in Query_cursor:
        try:
            row_A = Analyse_cursor.execute(Query_A[4]).rowcount
            # print (Query_A[4])

        except sqlite3.Error as err:

            error = "'" + str(err.message) + "'"
            print ("SQLite Error : (" + error + "), see query in problem below :\n" + Query_A[4])
            try:
                Analyse_cnxn.rollback()
                Analyse_cursor.execute(Error_Query, (error, Query_A[0], Query_A[2]))
                Analyse_cnxn.commit()
            except sqlite3.Error as err2:
                print ("SQLite Error : (" + error + "), see query in problem below :\n" + Query_A[4])
        else:
            Analyse_cnxn.commit()
            Analyse_cursor.execute(Insert_Query, (Query_A[0], Query_A[2], row_A))
            Analyse_cnxn.commit()



# ######### Main Program ##################

# Parameters Loading
config = dict()

config_file = open('./Analyser_config.ini', 'r')

for line in config_file:
    eq_index = line.find('=')
    var_name = line[:eq_index].strip()
    value = line[eq_index + 1:].strip()
    config[var_name] = value

# Redirect to the right procedure depending on the rdbms used
if config["tech"] == "SQL":
    processSql(config["dbserver"],config["Query"],config["UID"],config["PWD"])
elif config["tech"] == "ORACLE":
    processOracle(config["dbserver"],config["UID"],config["PWD"])
elif config["tech"] == "SQLITE":
    processSQLite(config["dbserver"],config["Query"])
else:
    print ("Analyser Config error : Unknown RDBMS (" + config["tech"] + ")")
        




