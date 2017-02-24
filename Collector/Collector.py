# coding=utf-8
import pyodbc
import csv
import datetime
# import cx_Oracle

# The script connect on each server in the table 'Prm_Server' and execute the required queries to collect daily data.
# The queris are taken in the table 'Prm_SQL
# TODO : Add support for sybase. New table 'Prm_Sybase_Queries

def write_error(Error_Level,Error_Number,Error_Text,Error_Client, Error_Jobs_Type, Error_Jobs_ID,Error_Server,Error_QueryId):
    filler = [''] * (20 - 6)
    
    if Error_Level == 0:
        Error_Level_Mess = "Information"
    elif Error_Level == 1:
        Error_Level_Mess = "Warning"
    elif Error_Level == 2:
        Error_Level_Mess = "ERROR"
    elif Error_Level == 3:
        Error_Level_Mess = "CRITICAL"
    else:
        Error_Level_Mess = "?????"

    if Error_Number == 1:
        Error_Descripton = "Debut de run"
    elif Error_Number == 2:
        Error_Descripton = "Fin de run"
    elif Error_Number == 3:
        Error_Descripton = "Connection issue"
    elif Error_Number == 4:
        Error_Descripton = "Mauvaise Requête"
    elif Error_Number == 5:
        Error_Descripton = "SGBD non reconu"
    elif Error_Number == 6:
        Error_Descripton = "Aucune rangé Retourné"
    elif Error_Number == 7:
        Error_Descripton = "SQL_ID n'existe pas"
    elif Error_Number == 8:
        Error_Descripton = "Liste_ID inexistant ou liste vide"
    elif Error_Number == 9:
        Error_Descripton = "Serveur_ID inexistant ou desactivé"
    elif Error_Number == 10:
        Error_Descripton = "User_ID inexistant"
    else:
        Error_Descripton = "??????"
    
    csv_master_writer.writerow([datetime.datetime.now(),config["Run_Num"],Error_Client,Error_Jobs_Type,Error_Jobs_ID,Error_Server,Error_QueryId,"SAJOB_MESSAGE",Error_Level,Error_Number,Error_Text,Error_Level_Mess,Error_Descripton] + filler)

#SQL
def processSql():
    if Server_User == "Trusted_Connection":
        connectstring = "DRIVER={" + config["SQLServer_Driver"] + "};SERVER=" + Server_Name + ";DATABASE=master;Trusted_Connection=yes;"
    else:
        connectstring = "DRIVER={" + config["SQLServer_Driver"] + "};SERVER=" + Server_Name + ";DATABASE=master;UID="+Server_User+";PWD="+Server_Pass

    try:
        print ("SQL Server " + Server_Name)
        cnxn = pyodbc.connect(connectstring)
    except pyodbc.Error, err:          
        write_error(2,3,err,Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
        #csv_master_writer.writerow([datetime.datetime.now(),config["Run_Num"],Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId,"ERROR","3","Connection issue",err] + filler)
    else:
        csv_master_cursor = cnxn.cursor()
        try :
            csv_master_cursor.execute(Jobs_Query) ####------- Query !!!
            ##print csv_master_cursor.description
        except pyodbc.Error, err:
            write_error(2,4,err,Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
        else:
            if csv_master_cursor.description == None:
                write_error(1,6,"",Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
            else:
                filler = [''] * (20 - len(csv_master_cursor.description))
                for ligne in csv_master_cursor:
                    try:
                        ligne_c = [datetime.datetime.now(),config["Run_Num"],Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId] + list(ligne) + filler
                        csv_master_writer.writerow([unicode(s).encode("utf-8").replace("\r\n", " ").replace("\n", " ").replace("None", "") for s in ligne_c])
                    except:
                        print 'Error, see following line : '
                        print list(ligne)
                    
    
#SQL
def processOracle():
    print ("Oracle")

    # dsn_tns = cx_Oracle.makedsn(Server_Name, Server_Oracle_Port, Server_Oracle_DB)
    #
    # try:
    #     cnxn = cx_Oracle.connect(Server_User, Server_Pass, dsn_tns)
    # except cx_Oracle.Error, err:
    #     write_error(2,3,err,Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
    # else:
    #     csv_master_cursor = cnxn.cursor()
    #     try :
    #         csv_master_cursor.execute(Jobs_Query) ####------- Query !!!
    #     except pyodbc.Error, err:
    #         write_error(2,4,err,Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
    #     else:
    #
    #         filler = [''] * (20 - len(csv_master_cursor.description))
    #         for ligne in csv_master_cursor:
    #             csv_master_writer.writerow([datetime.datetime.now(),config["Run_Num"],Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId] + list(ligne) + filler)

def processSybase():
    print ("Sybase Collector is not yet configured")

def processDB2():
    print ("DB2 Collector is not yet configured")

######### Main Program ##################



# Config Loading
config = dict()
config_file = open('Collector_Config.ini', 'r')

for line in config_file:
    eq_index = line.find('=')
    var_name = line[:eq_index].strip()
    value = line[eq_index + 1:].strip()
    config[var_name] = value

config_file.close()

config["Run_Num"] = open('Run_Num.ini').read()
open('Run_Num.ini', 'w').write(str(int(config["Run_Num"]) +1))

# Chargement des fichiers de paramÃ¨tre
param = {'Jobs':[],'Listes':[],'Queries':[],'Server':[],'User':[]}

# print(config["Param_Path"])
for Files in param:
    #print (Files)
    Param_File = csv.reader(open(config["Param_Path"] + Files +".csv", "rt"),delimiter='~')
    for row in Param_File:
        param[Files].append(row)


csv_master_file = open("Master_File.csv", "w")
csv_master_writer = csv.writer(csv_master_file, delimiter = '~', lineterminator='\n')
write_error(0,1,"","","","","","")



# Parcour des jobs

for Jobs in param["Jobs"]:
    Jobs_Id = Jobs[0]
    Jobs_Type = Jobs[1]
    Jobs_Name = Jobs[2]
    Jobs_Server_List_ID = Jobs[3]
    Jobs_QueryId = Jobs[4]
    Jobs_Client = Jobs[5]
    Job_Server_List = []

    
    Jobs_Query = ""
    for Query in param["Queries"]:
        if Query[0] == Jobs_QueryId:
            Jobs_Query = Query[1]
    if Jobs_Query == "":
        write_error(2,7,"",Jobs_Client,Jobs_Type,Jobs_Id,"",Jobs_QueryId)

    for Liste in param["Listes"]:        
        if Liste[0] == Jobs_Server_List_ID:
            Server_Check = 0
            for ServerList in param["Server"]:
                if ServerList[0] == Liste[1] and ServerList[8] == "1":
                    Server_Check = 1
                    if ServerList[5] == "":                        
                        Job_Server_List.append([ServerList[2],"","","Trusted_Connection",""])                        
                    else:
                        User_Check=0
                        for UserList in param["User"]:
                            if UserList[0] == ServerList[5]:
                                User_Check=1
                                Job_Server_List.append([ServerList[2],ServerList[3],ServerList[4],UserList[1],UserList[2]])
                        if User_Check == 0:
                            write_error(1,10,ServerList[5],Jobs_Client,Jobs_Type,Jobs_Id,"",Jobs_QueryId)
            if Server_Check == 0:
                write_error(1,9,Liste[1],Jobs_Client,Jobs_Type,Jobs_Id,"",Jobs_QueryId)

    if len(Job_Server_List)  == 0:
        write_error(1,8,Jobs_Server_List_ID,Jobs_Client,Jobs_Type,Jobs_Id,"",Jobs_QueryId)
                                
       #####Ajouter erreur lorsque liste ou user manquant             

    for Connection_List in Job_Server_List:
        Server_Name = Connection_List[0]
        Server_Oracle_DB = Connection_List[1]
        Server_Oracle_Port = Connection_List[2]                                                
        Server_User = Connection_List[3]
        Server_Pass = Connection_List[4]

        if Jobs_Type == "SQL":
            processSql()
            
        elif Jobs_Type == "ORACLE":
            processOracle()

        elif Jobs_Type == "DB2":
            processDB2()

        else:
            write_error(2,5,Jobs[1],Jobs_Client,Jobs_Type,Jobs_Id,Server_Name,Jobs_QueryId)
            
            
        
            
        
                   

write_error(0,2,"","","","","","")
csv_master_file.close()


