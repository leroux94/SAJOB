# coding=utf-8
#!/usr/bin/python

import smtplib
import pyodbc
import sqlite3
import sys
import os
import datetime as dt
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
#from email.Utils import COMMASPACE
from HTMLParser import HTMLParser

def xstr(s):
    if s is None:
        return ''
    return str(s)

def MailSenderSQL(serverName,Username,Password,JobQuery,QueryQuery):
        connectstring = "DRIVER={SQL Server};SERVER=" + serverName + ";DATABASE=master;Trusted_Connection=yes;"
        connEmail=pyodbc.connect(connectstring)
        connQuery=pyodbc.connect(connectstring)
        cursorEmail=connEmail.cursor()
        cursorQuery=connQuery.cursor()
        cursorEmail.execute(JobQuery)
        
        #print "test"
        for email in cursorEmail:
                cursorQuery.execute(QueryQuery)
                #print email
                #print email[1]
                toaddr = email[3] 
                msgsubject = xstr(email[1])
                msgintro = xstr(email[2])
                
                htmlmsgtext = unicode(msgintro)
                #htmlmsgtext.encode('utf-8')
                
                htmlmsgtext = htmlmsgtext + " </br> "
                
                for table in cursorQuery:
                        tableTitle = xstr(table[1])
                        #print table[1]
                        if table[0] == email[0]:
                                htmlmsgtext = htmlmsgtext + " </br> <h3> "+ unicode(tableTitle) + " </h3> "
                                connTable=pyodbc.connect(connectstring)
                                cursorTable=connTable.cursor()
                                cursorTable.execute(table[2])
                                
                                if cursorTable.rowcount == 0:
                                        htmlmsgtext = htmlmsgtext + 'Aucun </br> '
                                else:
                                        rows = cursorTable.fetchall()
                                        column_names = [d[0] for d in cursorTable.description]
                                        htmlmsgtext = htmlmsgtext + ' <table style="border:2px solid black"> '
                                        htmlmsgtext = htmlmsgtext + ' <tr> '
                                        for column_name in column_names:
                                                htmlmsgtext = htmlmsgtext + ' <th style="border:1px solid black; text-align:center"> ' + unicode(column_name) + ' </th> '
                                        htmlmsgtext = htmlmsgtext + ' </tr> '
                                        for row in rows:    
                                                for column in row:
                                                        #print "test"
                                                        try:
                                                                column = str(column)
                                                        except:
                                                                try:
                                                                        column = column.decode('cp1252').strip()
                                                                        
                                                                except:
                                                                        try:
                                                                                column = unicode(column).encode('cp1252').strip()
                                                                        except:
                                                                                print "tulipe"
                                                        

                                                        try:        
                                                                htmlmsgtext = htmlmsgtext + ' <td style="border:1px solid black; text-align:center"> ' + column.decode('cp1252').strip()  + ' </td> '
                                                        except:
                                                                print column

                                                htmlmsgtext = htmlmsgtext + ' </tr> '
                                        htmlmsgtext = htmlmsgtext + ' </table> </br> '
                                        
                                cursorTable.close
                                
                SendEmail(toaddr,msgsubject,htmlmsgtext)
              
        cursorEmail.close
        cursorQuery.close

def MailSenderSQLite(serverName,JobQuery,QueryQuery):
    conn = sqlite3.connect(serverName)
    cursorEmail = conn.cursor()
    cursorQuery = conn.cursor()
    cursorEmail.execute(JobQuery)

    # print "test"
    for email in cursorEmail:
        # print ("debug : each mail " + "\n" + str(email[0]) + "\n" + str(email[1]) + "\n" + str(email[2]) + "\n" + str(email[3]))
        cursorQuery.execute(QueryQuery)
        # print email
        # print email[1]
        toaddr = email[3]
        msgsubject = xstr(email[1])
        msgintro = xstr(email[2])

        htmlmsgtext = unicode(msgintro)
        # htmlmsgtext.encode('utf-8')

        htmlmsgtext = htmlmsgtext + " </br> "

        for table in cursorQuery:
            print ("Query : " + str(table[2]))
            tableTitle = xstr(table[1])
            # print table[1]
            if table[0] == email[0]:
                htmlmsgtext += " </br> <h3> " + unicode(tableTitle) + " </h3> "
                cursorTable = conn.cursor()

                try:
                    cursorTable.execute(table[2])
                except sqlite3.Error as err:
                    error = "'" + str(err.message) + "'"
                    print "SQLite3 Error (" + error + ")"
                else :
                    rows = cursorTable.fetchall()
                    if len(rows) <= 0:
                        print ("SALUT PAPA JE PASSE À LA TELE")
                        htmlmsgtext += 'Nothing </br> '
                    else:
                        print ("PAPA, LA TELE VEUT PAS DE MOI D:")
                        column_names = [d[0] for d in cursorTable.description]
                        htmlmsgtext += ' <table style="border:2px solid black"> '
                        htmlmsgtext += ' <tr> '
                        for column_name in column_names:
                            htmlmsgtext += ' <th style="border:1px solid black; text-align:center"> ' + unicode(
                                column_name) + ' </th> '
                        htmlmsgtext += ' </tr> '
                        for row in rows:
                            for column in row:
                                # print "test"
                                try:
                                    column = str(column)
                                except:
                                    try:
                                        column = column.decode('cp1252').strip()

                                    except:
                                        try:
                                            column = unicode(column).encode('cp1252').strip()
                                        except:
                                            print "tulipe"

                                try:
                                    htmlmsgtext += ' <td style="border:1px solid black; text-align:center"> ' + column.decode(
                                        'cp1252').strip() + ' </td> '
                                except:
                                    print column

                            htmlmsgtext += ' </tr> '
                        htmlmsgtext += ' </table> </br> '

        SendEmail(toaddr, msgsubject, htmlmsgtext)

    conn.close

def SendEmail(toaddr,msgsubject,htmlmsgtext):
        print ("debug : send email")
        host = config['SMTPSERVER'] # "smtpmtl.itops.ad.ypg.com"
        port = config['SMTPPORT'] # 25
        fromaddr = config['FROMADDR'] # "SAJOB@ypg.com"
        replyto = config['REPLYTO'] # "SAJOB_donotreply@ypg.com"

         # Mail preparation
        
        class MLStripper(HTMLParser):
                def __init__(self):
                        self.reset()
                        self.fed = []
                def handle_data(self, d):
                        self.fed.append(d)
                def get_data(self):
                        return ''.join(self.fed)

        def strip_tags(html):
                s = MLStripper()
                s.feed(html)                
                return s.get_data()
        
        # Make text version from HTML - First convert tags that produce a line break to carriage returns
        msgtext = htmlmsgtext.replace('</br>',"r").replace('<br />',"r").replace('</p>',"r")
        # Then strip all the other tags out
        msgtext = strip_tags(msgtext)
        #msgtext.encode('utf-8')
        
        # necessary mimey stuff
        msg = MIMEMultipart()
        msg.preamble = 'This is a multi-part message in MIME format.n'
        msg.epilogue = ''
        
        body = MIMEMultipart('alternative')
        body.attach(MIMEText(msgtext.encode('utf-8'), 'plain', 'utf-8'))
        body.attach(MIMEText(htmlmsgtext.encode('utf-8'), 'html'))
        msg.attach(body)   
        msg['From'] = fromaddr
        msg['To'] = toaddr
        msg['Subject'] = msgsubject
        msg['Reply-To'] = replyto

        print ("Sending " + msgsubject + " to : " + toaddr)

        # The actual email sendy bits
        try :
            server = smtplib.SMTP(host, port)
            server.set_debuglevel(False)
            server.sendmail(fromaddr, toaddr, msg.as_string())
        except smtplib.SMTPException as err:
            error = str(err.message)
            test = err.
            print ("smtplib error : " + error)
        else:
            print 'Email sent.'
        server.quit() # bye bye

    
                
######### Main Program ##################

#Chargement des parametre
config = dict()

config_file = open('./Emailer.ini', 'r')

for line in config_file:
    eq_index = line.find('=')
    var_name = line[:eq_index].strip()
    value = line[eq_index + 1:].strip()
    #print value
    config[var_name] = value

#Redirection vers la bonne procÃ©dure selon le SGBD
if config["tech"] == "SQL":
    MailSenderSQL(config["dbserver"],config["UID"],config["PWD"],config["JOBQUERY"],config["QUERYQUERY"])
elif config["tech"] == "SQLITE":
    MailSenderSQLite(config["dbserver"], config["JOBQUERY"], config["QUERYQUERY"])
else:
    print ("Emailer Config Error : Unknown RDBMS (" + config["tech"] + ")")
        

