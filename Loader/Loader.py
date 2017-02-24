# coding=utf-8
import pyodbc
import sqlite3
import csv
import codecs
import datetime


def processSql(serverName, Username, Password):
    connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;Trusted_Connection=yes;"
    cnxn = pyodbc.connect(connectstring)

    csvFileConversion()

    Query = "BULK INSERT " + config["Table_Maitre"] + " FROM'" + config["Table_M_File_C"] + "' WITH (FORMATFILE ='" + \
            config["Format_File"] + "' , FIRE_TRIGGERS, DATAFILETYPE='widechar');"
    print(Query)
    csv_cursor = cnxn.cursor()
    csv_cursor.execute(Query)
    cnxn.commit()


def processSQLite(serverName):
    print ("Starting insertion of collected data in SQLite database " + serverName)

    csvFileConversion()

    conn = sqlite3.connect(serverName)
    csvFileName = config["Table_M_File_C"]
    cursor = conn.cursor()
    with open(csvFileName, 'rU') as fi:
        f = (line.replace('\n', '') for line in fi)

        reader = csv.reader(f, delimiter='~', lineterminator='\n')
        linenumber = 0

        for row in reader:
            linenumber += 1
            row = [r.replace("'", "''") for r in row]
            if len(row) == 27:
                query = "INSERT INTO " + config[
                    "Table_Maitre"] + "(TM_Date_Entre,TM_Date_collecte,TM_Num_exec,TM_Client,TM_Type,TM_Job,TM_Serveur,TM_SQL_ID,TM_Champ_1,TM_Champ_2,TM_Champ_3,TM_Champ_4,TM_Champ_5,TM_Champ_6,TM_Champ_7,TM_Champ_8,TM_Champ_9,TM_Champ_10,TM_Champ_11,TM_Champ_12,TM_Champ_13,TM_Champ_14,TM_Champ_15,TM_Champ_16,TM_Champ_17,TM_Champ_18,TM_Champ_19,TM_Champ_20)VALUES('" + str(
                    datetime.datetime.now()) + "', NULLIF('" + row[0] + "', ''), NULLIF('" + row[1] + "', ''), NULLIF('" + row[
                            2] + "', ''), NULLIF('" + row[3] + "', ''), NULLIF('" + row[4] + "', ''), NULLIF('" + row[
                            5] + "', ''), NULLIF('" + row[6] + "', ''), NULLIF('" + row[7] + "', ''), NULLIF('" + row[
                            8] + "', ''), NULLIF('" + row[9] + "', ''), NULLIF('" + row[10] + "', ''), NULLIF('" + row[
                            11] + "', ''), NULLIF('" + row[12] + "', ''), NULLIF('" + row[13] + "', ''), NULLIF('" + row[
                            14] + "', ''), NULLIF('" + row[15] + "', ''), NULLIF('" + row[16] + "', ''), NULLIF('" + row[
                            17] + "', ''), NULLIF('" + row[18] + "', ''), NULLIF('" + row[19] + "', ''), NULLIF('" + row[
                            20] + "', ''), NULLIF('" + row[21] + "', ''), NULLIF('" + row[22] + "', ''), NULLIF('" + row[
                            23] + "', ''), NULLIF('" + row[24] + "', ''), NULLIF('" + row[25] + "', ''), NULLIF('" + row[26] + "', ''));"
                # print query
                cursor.execute(query)
            else:
                print ("Error : line " + str(linenumber) + " is not valid")
    conn.commit()
    conn.close()
    print ('Insertion complete !')


def processOracle(serverName, Username, Password):
    print ("Oracle server " + serverName)


def processDB2(serverName, Username, Password):
    print ("DB2 server " + serverName)


def processMYSQL(serverName, Username, Password):
    print ("MYSQL server " + serverName)


def csvFileConversion():
    sourceFileName = config["Table_M_File"]
    targetFileName = config["Table_M_File_C"]

    BLOCKSIZE = 1048576  # or some other, desired size in bytes
    with codecs.open(sourceFileName, "r", "utf-8") as sourceFile:

        with codecs.open(targetFileName, "w", "utf-8") as targetFile:
            while True:

                contents = sourceFile.read(BLOCKSIZE)
                if not contents:
                    break
                try:
                    targetFile.write(contents)
                except:
                    print "ERROR : The csv file conversion failed"


######### Main Program ##################

# Chargement des parametre
config = dict()
config_file = open('Loader.ini', 'r')
for line in config_file:
    eq_index = line.find('=')
    var_name = line[:eq_index].strip()
    value = line[eq_index + 1:].strip()
    config[var_name] = value

# Redirection vers la bonne procÃ©dure selon le SGBD
if config["tech"] == "SQL":
    processSql(config["dbserver"], config["UID"], config["PWD"])
elif config["tech"] == "ORACLE":
    processOracle(config["dbserver"], config["UID"], config["PWD"])
elif config["tech"] == "SQLITE":
    processSQLite(config["dbserver"])
else:
    print ("Unknown RDBMS (SGBD)")
