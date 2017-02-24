----------------------------------
-- Analyse_Query table re-creation
----------------------------------

DROP TABLE Analyse_Query;

CREATE TABLE Analyse_Query (
    Analyse_Query_ID      INTEGER NOT NULL
                                  PRIMARY KEY,
    Analyse_Query_Name    VARCHAR COLLATE NOCASE,
    Analyse_Query_Job_ID  INTEGER NOT NULL,
    Analyse_Query_Query   VARCHAR NOT NULL
                                  COLLATE NOCASE,
    Analyse_Query_Tag     INTEGER,
    Analyse_Query_Order   INTEGER NOT NULL,
    Analyse_Query_Status  INTEGER NOT NULL,
    Analyse_Query_Comment VARCHAR COLLATE NOCASE
);

INSERT INTO Analyse_Query (
	  Analyse_Query_Name,
	  Analyse_Query_Job_ID,
	  Analyse_Query_Query,
	  Analyse_Query_Order,
	  Analyse_Query_Status,
	  Analyse_Query_Comment
  )
  VALUES (
		'Create Analyse Query Run Number',
		1,
		"INSERT INTO [Analyse_NumberGenerator](ID, [dummy])VALUES((select max(ID) from [Analyse_NumberGenerator]) + 1, 1);",
		1,
		1,
		NULL
	),
	(
		'Delete Old Analyse Query Run Number',
		1,
		"DELETE FROM [Analyse_NumberGenerator] WHERE ID IN (select min(ID) FROM [Analyse_NumberGenerator]) AND 1 NOT IN(SELECT count(ID) FROM [Analyse_NumberGenerator]);",
		2,
		1,
		NULL
	),
	(
		'Fill Run_Info',
		1,
		"INSERT INTO [Run_Info] ( 	[Run_Col_Number]            	,[Run_Start]            	,[Run_End] 	,[Run_Analyse_Number]            	,[Run_Analyse_Start]            	,[Run_Collect_Job]) SELECT TM_S.[tm_num_exec] AS Run_Number, 	datetime(TM_S.[tm_date_collecte]) AS Run_Start, 	datetime(TM_E.[tm_date_collecte]) AS Run_End, 	A_NUM.ID AS Run_Analyse_Number, 	datetime('now', 'localtime') AS Run_Analyse_Start, 	Jobs.jobs_list AS Run_Collect_Job FROM [table_maitre] AS TM_S LEFT JOIN [table_maitre] AS TM_E ON TM_S.[tm_num_exec] = TM_E.[tm_num_exec] Left Join ( 	select max(ID) as ID 	from [Analyse_NumberGenerator]) as A_NUM on 1=1 LEFT JOIN ( SELECT DISTINCT t1.tm_num_exec AS  TM_Num_exec, (	 	SELECT replace('#' || group_concat(cast(t2.tm_job AS VARCHAR), ', #') , ', #NULL', '') 	FROM (SELECT tm_num_exec, tm_job FROM [table_maitre] WHERE tm_job is not null GROUP BY tm_num_exec, tm_job) AS t2 ) AS  Jobs_List FROM [table_maitre] t1) AS Jobs ON Jobs.tm_num_exec = TM_S.[tm_num_exec] WHERE TM_S.tm_champ_1 = 'SAJOB_MESSAGE' AND TM_E.tm_champ_1 = 'SAJOB_MESSAGE' AND TM_S.tm_champ_3 = '1' AND TM_E.tm_champ_3 = '2'",
		3,
		1,
		NULL
	),
	(
		'Clear Run_Info from Master',
		1,
		"DELETE FROM [TABLE_MAITRE] WHERE TM_Champ_1 ='SAJOB_MESSAGE' AND ( TM_Champ_3 = '1' OR  TM_Champ_3 = '2')",
		4,
		1,
		NULL
	),
	(
		'Purge Run_Info Table',
		1,
		"DELETE FROM [Run_Info] WHERE datetime(Run_Start) < datetime('now', '-3 year')",
		5,
		1,
		'Purge 3 Years Old Rows'
	),
	(
		'Insert remaining rows in Restant_TM',
		2,
		"INSERT INTO [Restant_TM]             ([TM_ID]             ,[TM_Date_Entre]             ,[TM_Date_collecte]             ,[TM_Num_exec]             ,[TM_Client]             ,[TM_Type]             ,[TM_Job]             ,[TM_Serveur]             ,[TM_SQL_ID]             ,[TM_Champ_1]             ,[TM_Champ_2]             ,[TM_Champ_3]             ,[TM_Champ_4]             ,[TM_Champ_5]             ,[TM_Champ_6]             ,[TM_Champ_7]             ,[TM_Champ_8]             ,[TM_Champ_9]             ,[TM_Champ_10]             ,[TM_Champ_11]             ,[TM_Champ_12]             ,[TM_Champ_13]             ,[TM_Champ_14]             ,[TM_Champ_15]             ,[TM_Champ_16]             ,[TM_Champ_17]             ,[TM_Champ_18] 			,[TM_Champ_19]             ,[TM_Champ_20]) 			select [TM_ID]            ,[TM_Date_Entre]            ,[TM_Date_collecte]            ,[TM_Num_exec]            ,[TM_Client]            ,[TM_Type]            ,[TM_Job]            ,[TM_Serveur]            ,[TM_SQL_ID]            ,[TM_Champ_1]            ,[TM_Champ_2]            ,[TM_Champ_3]            ,[TM_Champ_4]            ,[TM_Champ_5]            ,[TM_Champ_6]            ,[TM_Champ_7]            ,[TM_Champ_8]            ,[TM_Champ_9]            ,[TM_Champ_10]            ,[TM_Champ_11]            ,[TM_Champ_12]            ,[TM_Champ_13]            ,[TM_Champ_14]            ,[TM_Champ_15]            ,[TM_Champ_16]            ,[TM_Champ_17]            ,[TM_Champ_18]            ,[TM_Champ_19]            ,[TM_Champ_20] from [Table_Maitre];",
		1,
		1,
		NULL
	),
	(
		'Purge TABLE_MAITRE Daily',
		2,
		"DELETE FROM [TABLE_MAITRE];",
		2,
		1,
		NULL
	),
	(
		'Purge Restant_TM',
		2,
		"DELETE FROM [Restant_TM]  WHERE datetime(TM_Date_collecte) < datetime('now', '-2 week')",
		3,
		1,
		'Purge 2 Weeks old rows'
	),
	(
		'Purge Analysis Error log',
		2,
		"DELETE FROM [Error_Analyse_Log] WHERE datetime(Error_Time) < datetime('now', '-3 month')",
		4,
		1,
		'Purge 3 months old rows'
	),
	(
		'Purge Analysis log',
		2,
		"DELETE FROM [Analyse_Log] WHERE A_A_Run_Num IN (select Run_analyse_number from Run_Info where datetime(Run_start) < datetime('now', '-1 month'));",
		5,
		1,
		'Purge 1 month old rows'
	),
	(
		'Run_info End',
		2,
		"UPDATE [Run_Info]    SET         [Run_Analyse_End] = datetime('now', 'localtime')        		,[Run_Analyse_Job] = 		(SELECT replace('#' || group_concat(cast(st1.Analyse_Job_ID AS VARCHAR), ', #') , ', #NULL', '') 			FROM (SELECT Analyse_Job_ID FROM [Analyse_Job] WHERE Analyse_Job_Status = 1) AS st1	) 	WHERE [Run_Analyse_End] is NULL; ",
		9999,
		1,
		'Last step of the run'
	),
	(
		'Fill Collector Error log',
		3,
		"INSERT INTO [Error_Collector_Log]             ([Error_Run_Num]             ,[Error_Sev]             ,[Error_Num]             ,[Error_Text]             ,[Error_Time]             ,[Error_Client]             ,[Error_Serveur]             ,[Error_Serveur_Type]             ,[Error_Job]             ,[Error_SQL_ID]) 			SELECT [TM_Num_exec] 			,[TM_Champ_2] 			,[TM_Champ_3] 			,[TM_Champ_4] 			,[TM_Date_collecte] 			,[TM_Client] 			,[TM_Serveur] 			,[TM_Type] 			,[TM_Job] 			,[TM_SQL_ID] 			FROM [TABLE_MAITRE] 			where TM_Champ_1 = 'SAJOB_MESSAGE';",
		1,
		1,
		NULL
	),
	(
		'Delete Collector Error log from TM',
		3,
		"DELETE  FROM [TABLE_MAITRE]  where TM_Champ_1 = 'SAJOB_MESSAGE';",
		2,
		1,
		NULL
	),
	(
		'Purge Collector Error log',
		3,
		"DELETE FROM [Error_Collector_Log]  WHERE datetime(Error_Time) < datetime('now', '-3 month');",
		3,
		1,
		'Purge 3 months old rows'
	),
	(
		'Clear Inventory staging table',
		4,
		"DELETE FROM [SQL_DB_Inv_Stage];",
		1,
		1,
		NULL
	),
	(
		'Move Inventory data to staging table',
		4,
		"INSERT INTO [SQL_DB_Inv_Stage]   ([SDBI_Server]   ,[SDBI_DB_Id]   ,[SDBI_Name]   ,[SDBI_RM]   ,[SDBI_Status]   ,[SDBI_Collation]   ,[SDBI_CL]   ,[SDBI_DB_Size_MB]   ,[SDBI_Log_Size_MB]   ,[SDBI_create_date]   ,[SDBI_Last_FULL]   ,[SDBI_Last_DIFF]   ,[SDBI_Last_Log]   ,[SDBI_Last_Restore]   ,[SDBI_Collect_date])   SELECT [TM_Serveur]   ,[TM_Champ_1]   ,[TM_Champ_2]   ,[TM_Champ_3]   ,[TM_Champ_4]   ,[TM_Champ_5]   ,[TM_Champ_6]   ,[TM_Champ_7]   ,[TM_Champ_8]   ,datetime([TM_Champ_9])   ,datetime([TM_Champ_10])   ,datetime([TM_Champ_11])   ,datetime([TM_Champ_12])   ,datetime([TM_Champ_13])   ,datetime([TM_Date_collecte])   FROM [TABLE_MAITRE]   where TM_Job  IN ( 3 ,4,12)   and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);",
		2,
		1,
		NULL
	),
	(
		'Insert in DB Size from staging table',
		4,
		"INSERT INTO [SQL_DB_Size] ([SDBI_Server]  ,[SDBI_DB_Id]  ,[SDBI_Name]  ,[SDBI_DB_Size_MB]  ,[SDBI_Log_Size_MB]  ,[SDBI_Collect_date])  Select [SDBI_Server]  ,[SDBI_DB_Id]  ,[SDBI_Name]  ,[SDBI_DB_Size_MB]  ,[SDBI_Log_Size_MB]  ,[SDBI_Collect_date]  from SQL_DB_Inv_Stage  where [SDBI_DB_Size_MB] is not null;",
		3,
		1,
		NULL
	),
	(
		'Tag changed data as old',
		4,
		"UPDATE SQL_DB_Inventory set [SDBI_Current] = 0, [SDBI_End] = datetime('now', 'localtime')	 where SDBI_Current = 1 and SDBI_Server || SDBI_Name IN ( 	select t.SDBI_Server || t.SDBI_name 	from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s 	where t.SDBI_Server = s.SDBI_Server 	and t.SDBI_Current = 1		 	and t.SDBI_name = s.SDBI_Name 	and ( 		t.SDBI_DB_Id != s.SDBI_DB_Id or 		t.SDBI_name != s.SDBI_Name or 		t.SDBI_RM != s.SDBI_RM or 		t.SDBI_Status != s.SDBI_Status or 		t.SDBI_Collation != s.SDBI_Collation or 		t.SDBI_CL != s.SDBI_CL or 		t.SDBI_create_date != s.SDBI_create_date 		) 	);",
		4,
		1,
		NULL
	),
	(
		'Insert new row into db inventory table',
		4,
		"INSERT INTO SQL_DB_Inventory(SDBI_Server, SDBI_DB_Id, SDBI_name, SDBI_RM, SDBI_Status, SDBI_Collation, SDBI_CL, SDBI_DB_Size_MB, SDBI_Log_Size_MB, SDBI_create_date, SDBI_Last_FULL, SDBI_Last_DIFF, SDBI_Last_Log, SDBI_Last_Restore, SDBI_Start, SDBI_Current, SDBI_Last_Update) 	select SDBI_Server, SDBI_DB_Id, SDBI_Name, SDBI_RM, SDBI_Status, SDBI_Collation, SDBI_CL, SDBI_DB_Size_MB, SDBI_Log_Size_MB, SDBI_create_date, SDBI_Last_FULL, SDBI_Last_DIFF, SDBI_Last_Log, SDBI_Last_Restore, datetime('now', 'localtime'), 1, SDBI_Collect_date 	from SQL_DB_Inv_Stage 	where SDBI_Server || SDBI_Name NOT IN ( 		select t.SDBI_Server || t.SDBI_name 		from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s 		where t.SDBI_Current = 1 		and t.SDBI_End is null 		and t.SDBI_Server = s.SDBI_Server 		and t.SDBI_name = s.SDBI_Name);",
		5,
		1,
		NULL
	),
	(
		'Update data in db_inv table',
		4,
		"UPDATE SQL_DB_Inventory set SDBI_DB_Size_MB = (select SDBI_DB_Size_MB from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Log_Size_MB = (select SDBI_Log_Size_MB from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Last_FULL = (select SDBI_Last_FULL from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Last_DIFF = (select SDBI_Last_DIFF from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Last_Log = (select SDBI_Last_Log from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Last_Restore = (select SDBI_Last_Restore from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name), 	SDBI_Last_Update = (select SDBI_Collect_date from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name) where SDBI_Current = 1 AND SDBI_END is null AND	SDBI_Server || SDBI_Name IN ( 	SELECT sour.SDBI_Server || sour.SDBI_name 	FROM sql_db_inv_stage Sour, SQL_DB_Inventory target 	WHERE sour.SDBI_Server = target.SDBI_Server 	AND sour.SDBI_name = target.SDBI_name); ",
		6,
		1,
		NULL
	),
	(
		'Tag database as removed',
		4,
		"UPDATE SQL_DB_Inventory set SDBI_End = datetime('now', 'localtime') WHERE SDBI_Current = 1 and SDBI_End is null and SDBI_Server || SDBI_Name NOT IN ( 	select t.SDBI_Server || t.SDBI_name 	from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s 	where t.SDBI_Server = s.SDBI_Server 	and t.SDBI_Current = 1		 	and t.SDBI_name = s.SDBI_Name 	);",
		7,
		1,
		NULL
	),
	(
		'Clear Table_Maitre',
		4,
		"DELETE  FROM [TABLE_MAITRE]  where TM_Job  IN ( 3 ,4,12) and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);",
		8,
		1,
		NULL
	),
	(
		'Clear Job staging table',
		5,
		"DELETE FROM [SQL_Job_Stage];",
		1,
		1,
		NULL
	),
	(
		'Insert Job History table',
		5,
		"INSERT INTO SQL_JOB_HIST ( 	[jh_server], 	[jh_job_id], 	[jh_step_id], 	[jh_step_name], 	[jh_status], 	[jh_mess_id], 	[jh_sev], 	[jh_message], 	[jh_date], 	[jh_duration], 	[jh_retry]) 	SELECT TM_Serveur, tm_champ_1, tm_champ_2, tm_champ_3, tm_champ_4, tm_champ_5, tm_champ_6, tm_champ_7, (substr(tm_champ_8, 1, 4)||'-'||substr(tm_champ_8, 5, 2)||'-'||substr(tm_champ_8, 7, 2)||' '||substr(substr('000000'|| tm_champ_9, -6, 6), 1, 2)||':'|| substr(substr('000000'|| tm_champ_9, -6, 6), 3, 2)||':'||substr(substr('000000'|| tm_champ_9, -6, 6), 5, 2)), tm_champ_10, tm_champ_11 	FROM TABLE_MAITRE 	WHERE tm_job = 9 	and TM_Serveur || '&' || tm_champ_1 || '&' || tm_champ_2 || '&' || (substr(tm_champ_8, 1, 4)||'-'||substr(tm_champ_8, 5, 2)||'-'||substr(tm_champ_8, 7, 2)||' '||substr(substr('000000'|| tm_champ_9, -6, 6), 1, 2)||':'|| substr(substr('000000'|| tm_champ_9, -6, 6), 3, 2)||':'||substr(substr('000000'|| tm_champ_9, -6, 6), 5, 2)) NOT IN ( 		select jh_Server || '&' || jh_job_id || '&' || jh_step_id || '&' || jh_date 		from SQL_JOB_HIST);",
		2,
		1,
		NULL
	),
	(
		'Move into job stage table from TM',
		5,
		"INSERT INTO [SQL_Job_Stage]            ([SJ_Server]            ,[SJ_Job_ID]            ,[SJ_Name]            ,[SJ_Status]            ,[SJ_Desc]            ,[SJ_Start_Step]            ,[SJ_Owner]            ,[SJ_Create_Date]            ,[SJ_Mod_Date]            ,[SJ_Version]            ,[SJ_Sch_Next_Date]            ,[SJ_Sch_Next_Time]            ,[SJ_Sch_Status]            ,[SJ_Sch_ID]            ,[SJ_Sch_Create_Date]            ,[SJ_Sch_Mod_Date]            ,[SJ_Sch_Desc]) SELECT[TM_Serveur]       ,[TM_Champ_1]       ,[TM_Champ_2]       ,[TM_Champ_3]       ,[TM_Champ_4]       ,[TM_Champ_5]       ,[TM_Champ_6]       ,datetime([TM_Champ_7])       ,datetime([TM_Champ_8])       ,[TM_Champ_9]       ,[TM_Champ_11]       ,[TM_Champ_12]       ,[TM_Champ_13]       ,[TM_Champ_14]       ,datetime([TM_Champ_15])       ,datetime([TM_Champ_16])       ,[TM_Champ_17]   FROM [TABLE_MAITRE]   where TM_Job in (8,10); ",
		3,
		1,
		NULL
	),
	(
		'Clear Job data from TM',
		5,
		"DELETE  FROM [TABLE_MAITRE]  where TM_Job  IN ( 8,9,10 ) and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);",
		4,
		1,
		NULL
	),
	(
		'Tag changed data as old',
		5,
		"UPDATE SQL_Job SET [SJ_current] = 0, [SJ_end] = datetime('now', 'localtime') WHERE [SJ_current] = 1 AND SJ_Server || SJ_Job_ID || SJ_Sch_ID IN ( 	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID 	from SQL_Job t, SQL_Job_Stage s 	where t.SJ_Server = s.SJ_Server 	and t.SJ_Job_ID = s.SJ_Job_ID 	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0) 	and t.SJ_Current = 1 	and ( 		t.SJ_Name != s.SJ_Name or 		t.SJ_Status != s.SJ_Status or 		t.SJ_Start_Step != s.SJ_Start_Step or 		t.SJ_Owner != s.SJ_Owner or 		t.SJ_Create_Date != s.SJ_Create_Date or 		t.SJ_Mod_Date != s.SJ_Mod_Date or 		t.SJ_Version != s.SJ_Version or 		t.SJ_Sch_Status != s.SJ_Sch_Status or 		t.SJ_Sch_Create_Date != s.SJ_Sch_Create_Date or 		t.SJ_Sch_Mod_Date != s.SJ_Sch_Mod_Date or 		t.SJ_Sch_Desc != s.SJ_Sch_Desc 	) );",
		5,
		1,
		NULL
	),
	(
		'Insert new data into SQL_Job Table',
		5,
		"INSERT INTO SQL_Job ([SJ_Server] ,[SJ_Job_ID] ,[SJ_Name] ,[SJ_Status] ,[SJ_Desc] ,[SJ_Start_Step] ,[SJ_Owner] ,[SJ_Create_Date] ,[SJ_Mod_Date] ,[SJ_Version] ,[SJ_Sch_Next_Date] ,[SJ_Sch_Next_Time] ,[SJ_Sch_Status] ,[SJ_Sch_ID] ,[SJ_Sch_Create_Date] ,[SJ_Sch_Mod_Date] ,[SJ_Sch_Desc] ,[SJ_Start] ,[SJ_Current] ,[SJ_Last_Update]) 	select SJ_Server, SJ_Job_ID, SJ_Name, SJ_Status, SJ_Desc, SJ_Start_Step, SJ_Owner, SJ_Create_Date, SJ_Mod_Date, SJ_Version, SJ_Sch_Next_Date, SJ_Sch_Next_Time, SJ_Sch_Status, SJ_Sch_ID, SJ_Sch_Create_Date, SJ_Sch_Mod_Date, SJ_Sch_Desc, datetime('now', 'localtime'), 1, datetime('now', 'localtime') 	from SQL_Job_Stage 	where SJ_Server || SJ_Job_ID || SJ_Sch_ID not in ( 		select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID 		from SQL_Job t, SQL_Job_Stage s 		where SJ_Current = 1 		and SJ_End is null 		and t.SJ_Server = s.SJ_Server 		and t.SJ_Job_ID = s.SJ_Job_ID 		and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0) 	);",
		6,
		1,
		NULL
	),
	(
		'Update data in SQL_Job Table',
		5,
		"UPDATE SQL_Job SET [SJ_Desc] = (select [SJ_Desc] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID) , 	[SJ_Sch_Next_Date] = (select [SJ_Sch_Next_Date] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID) , 	[SJ_Sch_Next_Time] = (select [SJ_Sch_Next_Time] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID), 	[sj_last_update] = datetime('now', 'localtime') WHERE SJ_Current = 1 AND SJ_End is null AND SJ_Server || SJ_Job_ID || SJ_Sch_ID IN ( 	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID 	from SQL_Job t, SQL_Job_Stage s 	where t.SJ_Server = s.SJ_Server 	and t.SJ_Job_ID = s.SJ_Job_ID 	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0)	 );",
		7,
		1,
		NULL
	),
	(
		'Tag jobs as removed',
		5,
		"UPDATE SQL_Job SET SJ_End = datetime('now', 'localtime') WHERE SJ_Current =1 AND SJ_End is null AND SJ_Server || SJ_Job_ID || SJ_Sch_ID NOT IN ( 	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID 	from SQL_Job t, SQL_Job_Stage s 	where t.SJ_Server = s.SJ_Server 	and t.SJ_Job_ID = s.SJ_Job_ID 	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0) 	and t.SJ_Current = 1 );",
		8,
		1,
		NULL
	),
	(
		'Purge SQL_Job_Hist_Table',
		5,
		"DELETE FROM SQL_Job_Hist where datetime(jh_Date) < datetime('now', '-1 Month', 'localtime');",
		9,
		1,
		'Purge 1 Month Old Rows'
	),
	(
		'Clear User staging table',
		6,
		"DELETE FROM[SQL_User_Stage];",
		1,
		1,
		NULL
	),
	(
		'Move into user stage table from TM',
		6,
		"INSERT INTO [SQL_User_Stage]([SU_Server],[SU_Name],[SU_User_Id],[SU_Dbname],[SU_Type],[SU_IsSysadmin],[SU_IsServeradmin],[SU_IsProcessadmin],[SU_IsSecurityadmin],[SU_IsSetupadmin],[SU_IsDiskadmin],[SU_IsBulkadmin],[SU_IsDbCreator],[SU_Status],[SU_Create_Date]) 	SELECT[TM_Serveur],[TM_Champ_1],[TM_Champ_2],[TM_Champ_3],[TM_Champ_4],[TM_Champ_5],[TM_Champ_6],[TM_Champ_7],[TM_Champ_8],[TM_Champ_9],[TM_Champ_10],[TM_Champ_11],[TM_Champ_12],[TM_Champ_13],datetime([TM_Champ_14])  FROM [TABLE_MAITRE]   where TM_Job in (13, 14);",
		2,
		1,
		NULL
	),
	(
		'Clear User data from TM',
		6,
		"DELETE FROM [TABLE_MAITRE]  WHERE TM_Job  IN ( 13, 14 ) AND TM_Num_exec = (SELECT MAX(TM_Num_exec) FROM [TABLE_MAITRE]);",
		3,
		1,
		NULL
	),
	(
		'Tag changed data as old',
		6,
		"UPDATE SQL_User SET [SU_current] = 0, [SU_end] = datetime('now', 'localtime') WHERE [SU_current] = 1 AND SU_Server || SU_Name IN ( 	select t.SU_Server || t.SU_Name 	from SQL_User t, SQL_User_Stage s 	where t.SU_Server = s.SU_Server 	and t.SU_Name = s.SU_Name 	and t.SU_Current = 1 	and ( 		t.SU_User_Id != s.SU_User_Id or 		t.SU_Type != s.SU_Type or 		t.SU_Dbname != s.SU_Dbname or 		t.SU_Type != s.SU_Type or 		t.SU_IsSysadmin != s.SU_IsSysadmin or 		t.SU_IsServeradmin != s.SU_IsServeradmin or 		t.SU_IsProcessadmin != s.SU_IsProcessadmin or 		t.SU_IsSecurityadmin != s.SU_IsSecurityadmin or 		t.SU_IsSetupadmin != s.SU_IsSetupadmin or 		t.SU_IsDiskadmin != s.SU_IsDiskadmin or 		t.SU_IsBulkadmin != s.SU_IsBulkadmin or 		t.SU_IsDbCreator != s.SU_IsDbCreator or 		t.SU_Status != s.SU_Status or 		t.SU_create_date != s.SU_create_date 	) );",
		4,
		1,
		NULL
	),
	(
		'Insert new data into SQL_User Table',
		6,
		"INSERT INTO SQL_User ([SU_Server],[SU_name],[SU_User_Id],[SU_Dbname],[SU_Type],[SU_IsSysadmin],[SU_IsServeradmin],[SU_IsProcessadmin],[SU_IsSecurityadmin],[SU_IsSetupadmin],[SU_IsDiskadmin],[SU_IsBulkadmin],[SU_IsDbCreator],[SU_Status],[SU_create_date], [SU_Start], [SU_End], [SU_Current], [SU_Last_Update]) 	select SU_Server, SU_name, SU_User_Id, SU_Dbname, SU_Type, SU_IsSysadmin, SU_IsServeradmin, SU_IsProcessadmin, SU_IsSecurityadmin, SU_IsSetupadmin, SU_IsDiskadmin, SU_IsBulkadmin, SU_IsDbCreator, SU_Status, SU_create_date, datetime('now','localtime'), null, 1, SU_Collect_Date 	from SQL_User_Stage 	where SU_Server || SU_Name not in ( 		select t.SU_Server || t.SU_Name 		from SQL_User t, SQL_User_Stage s 		where SU_Current = 1 		and SU_End is null 		and t.SU_Server = s.SU_Server 		and t.SU_Name = s.SU_Name 	);",
		5,
		1,
		NULL
	),
	(
		'Tag User as removed',
		6,
		"UPDATE SQL_User SET SU_End = datetime('now','localtime') WHERE SU_Current =1 AND SU_End is null AND SU_Server || SU_Name NOT IN ( 	select t.SU_Server || t.SU_Name 	from SQL_User t, SQL_User_Stage s 	where t.SU_Server = s.SU_Server 	and t.SU_Name = s.SU_Name 	and t.SU_Current = 1 );",
		6,
		1,
		NULL
	);

--------------------------------
-- Analyse_Job table re-creation
--------------------------------

DROP TABLE Analyse_Job;

CREATE TABLE Analyse_Job (
    Analyse_Job_ID      INTEGER      NOT NULL
									 PRIMARY KEY,
    Analyse_Job_Name    VARCHAR (50) COLLATE NOCASE,
    Analyse_Job_Tag     INTEGER,
    Analyse_Job_Order   INTEGER      NOT NULL,
    Analyse_Job_Status  INTEGER      NOT NULL,
    Analyse_Job_Comment VARCHAR      COLLATE NOCASE
);


INSERT INTO Analyse_Job (
		Analyse_Job_Comment,
		Analyse_Job_Status,
		Analyse_Job_Order,
		Analyse_Job_Tag,
		Analyse_Job_Name
	)
	VALUES (
		NULL,
		1,
		1,
		1,
		'Analysis Start'
	),
	(
		'Must run after everything else',
		1,
		9999,
		1,
		'Analysis End'
	),
	(
		NULL,
		1,
		2,
		1,
		'Error_Collector'
	),
	(
		NULL,
		1,
		3,
		2,
		'SQL DB inventory Analysis'
	),
	(
		NULL,
		1,
		4,
		2,
		'SQL Job Analysis'
	),
	(
		NULL,
		1,
		5,
		2,
		'SQL User Analysis'
	);

-------------------------------
-- Email_Query Table recreation
-------------------------------

DROP TABLE Email_Query;

CREATE TABLE Email_Query (
    Email_Query_ID       INTEGER       NOT NULL
                                       PRIMARY KEY,
    Email_Query_Name     VARCHAR (50)  COLLATE NOCASE,
    Email_Query_Title    VARCHAR (200) COLLATE NOCASE,
    Email_Query_Email_ID INTEGER       NOT NULL,
    Email_Query_Query    VARCHAR       NOT NULL
                                       COLLATE NOCASE,
    Email_Query_Tag      INTEGER,
    Email_Query_Order    INTEGER       NOT NULL,
    Email_Query_Status   INTEGER       NOT NULL,
    Email_Query_Comment  VARCHAR       COLLATE NOCASE
);

INSERT INTO Email_Query (
		Email_Query_ID,
		Email_Query_Name,
		Email_Query_Title,
		Email_Query_Email_ID,
		Email_Query_Query,
		Email_Query_Tag,
		Email_Query_Order,
		Email_Query_Status,
		Email_Query_Comment
	)
	VALUES (
		1,
		'Inventory Change',
		'Inventory Change',
		2,
		'SELECT * FROM [SQL_DB_Change]',
		NULL,
		1,
		1,
		NULL
	),(
		2,
		'Missing Prod Backup',
		'Missing production backup in the last 24h',
		2,
		'SELECT *  FROM [SQL_DB_Backups]',
		NULL,
		2,
		1,
		NULL
	),(
		3,
		'SAJOB Report',
		'SAJOB Activity report',
		1,
		'SELECT *  FROM [Rapport_SAJOB]',
		NULL,
		1,
		1,
		NULL
	),(
		4,
		'Error Collector',
		'Data Collector Error',
		1,
		'SELECT *  FROM [Error_Collector]',
		NULL,
		2,
		1,
		NULL
	),(
		5,
		'Analysis Error',
		'Data Analysis Error',
		1,
		'SELECT *  FROM [Error_Analyse]',
		NULL,
		3,
		1,
		NULL
	),(
		6,
		'DB Grow',
		'Significant database growth',
		2,
		'SELECT * FROM [SQL_DB_Grow]',
		NULL,
		4,
		1,
		NULL
	),(
		7,
		'Untreated_Data',
		'Untreated Collector Data',
		1,
		'SELECT *  FROM [Untreated_Data]',
		NULL,
		4,
		1,
		NULL
	),(
		8,
		'Job Inv',
		'SQL Jobs Change',
		3,
		'SELECT * FROM [SQL_Job_Change]',
		NULL,
		4,
		1,
		NULL
	),(
		9,
		'Job report',
		'SQL Jobs Report',
		3,
		'SELECT * FROM [SQL_Job_Report]',
		NULL,
		1,
		1,
		NULL
	),(
		10,
		'Job Fail Det',
		'Failed job detail',
		3,
		'SELECT * FROM SQL_Job_Fail_Det',
		NULL,
		3,
		1,
		NULL
	),(
		11,
		'Late Job',
		'Late job',
		3,
		'SELECT * FROM [SQL_Job_Late]',
		NULL,
		2,
		1,
		NULL
	),(
		12,
		'New sysadmin',
		'New Sysadmin',
		4,
		'SELECT * FROM [SQL_User_NewSysadmin]',
		NULL,
		1,
		1,
		NULL
	),(
		13,
		'User Change',
		'User Change',
		4,
		'SELECT * FROM [SQL_User_Change]',
		NULL,
		2,
		1,
		NULL
	),(
		14,
		'Missing Log Backup',
		'Missing Log backup from Production databases in Full recovery model',
		2,
		'SELECT *  FROM [SQL_DB_Log_Backups]',
		NULL,
		3,
		1,
		NULL
	);

-------------------------------
-- Email_Job Table recreation
-------------------------------

DELETE FROM Email_Job;

INSERT INTO Email_Job (
                          Email_Job_Comment,
                          Email_Job_Freq,
                          Email_Job_Status,
                          Email_Job_Order,
                          Email_Job_Tag,
                          Email_Job_Email,
                          Email_Job_Message,
                          Email_Job_Subject,
                          Email_Job_Name,
                          Email_Job_ID
                      )
                      VALUES (
                          NULL,
                          NULL,
                          1,
                          1,
                          1,
                          'DBGROUP@yp.ca',
                          NULL,
                          '(new) SAJOB Report',
                          'Sajob Report',
                          1
                      ),
                      (
                          NULL,
                          NULL,
                          1,
                          2,
                          2,
                          'DBGROUP@yp.ca',
                          NULL,
                          '(new) SQL Inventory Report',
                          'Inventory Report',
                          2
                      ),
                      (
                          NULL,
                          NULL,
                          1,
                          3,
                          2,
                          'DBGROUP@yp.ca',
                          NULL,
                          '(new) SQL Job Report',
                          'JOb Report',
                          3
                      ),
                      (
                          NULL,
                          NULL,
                          1,
                          4,
                          2,
                          'DBGROUP@yp.ca',
                          NULL,
                          '(new) SQL User Report',
                          'User Report',
                          4
                      );

-------------------------------
-- Table_Maitre Table recreation
-------------------------------

DROP TABLE TABLE_MAITRE;

CREATE TABLE TABLE_MAITRE (
    TM_ID            INTEGER       NOT NULL
                                   PRIMARY KEY,
    TM_Date_Entre    DATETIME          NOT NULL,
    TM_Date_collecte DATETIME,
    TM_Num_exec      INTEGER,
    TM_Client        VARCHAR 		COLLATE NOCASE,
    TM_Type          VARCHAR  		COLLATE NOCASE,
    TM_Job           INTEGER,
    TM_Serveur       VARCHAR (50) COLLATE NOCASE,
    TM_SQL_ID        INTEGER,
    TM_Champ_1       VARCHAR      COLLATE NOCASE,
    TM_Champ_2       VARCHAR      COLLATE NOCASE,
    TM_Champ_3       VARCHAR      COLLATE NOCASE,
    TM_Champ_4       VARCHAR      COLLATE NOCASE,
    TM_Champ_5       VARCHAR      COLLATE NOCASE,
    TM_Champ_6       VARCHAR      COLLATE NOCASE,
    TM_Champ_7       VARCHAR      COLLATE NOCASE,
    TM_Champ_8       VARCHAR      COLLATE NOCASE,
    TM_Champ_9       VARCHAR      COLLATE NOCASE,
    TM_Champ_10      VARCHAR      COLLATE NOCASE,
    TM_Champ_11      VARCHAR      COLLATE NOCASE,
    TM_Champ_12      VARCHAR      COLLATE NOCASE,
    TM_Champ_13      VARCHAR      COLLATE NOCASE,
    TM_Champ_14      VARCHAR      COLLATE NOCASE,
    TM_Champ_15      VARCHAR      COLLATE NOCASE,
    TM_Champ_16      VARCHAR      COLLATE NOCASE,
    TM_Champ_17      VARCHAR      COLLATE NOCASE,
    TM_Champ_18      VARCHAR      COLLATE NOCASE,
    TM_Champ_19      VARCHAR      COLLATE NOCASE,
    TM_Champ_20      VARCHAR      COLLATE NOCASE
);

-------------------------------
-- Analyse_NumberGenerator Table recreation
-------------------------------

DROP TABLE Analyse_NumberGenerator;

CREATE TABLE Analyse_NumberGenerator (
    ID    INTEGER NOT NULL
                  PRIMARY KEY,
    dummy INTEGER
);

INSERT INTO Analyse_NumberGenerator (ID, dummy) VALUES (352, 1);

-------------------------------
-- SQL_DB_Inventory Table recreation
-------------------------------

PRAGMA foreign_keys = 0;

CREATE TABLE sqlitestudio_temp_table AS SELECT *
                                          FROM SQL_DB_Inventory;

DROP TABLE SQL_DB_Inventory;

CREATE TABLE SQL_DB_Inventory (
    SDBI_Id           INTEGER       NOT NULL
                                    PRIMARY KEY,
    SDBI_Server       VARCHAR (60)  COLLATE NOCASE,
    SDBI_DB_Id        SMALLINT,
    SDBI_name         VARCHAR (60)  COLLATE NOCASE,
    SDBI_RM           VARCHAR (30)  COLLATE NOCASE,
    SDBI_Status       VARCHAR (30)  COLLATE NOCASE,
    SDBI_Collation    VARCHAR (60)  COLLATE NOCASE,
    SDBI_CL           SMALLINT,
    SDBI_DB_Size_MB   INTEGER,
    SDBI_Log_Size_MB  INTEGER,
    SDBI_create_date  DATETIME,
    SDBI_Last_FULL    DATETIME,
    SDBI_Last_DIFF    DATETIME,
    SDBI_Last_Log     DATETIME,
    SDBI_Last_Restore DATETIME,
    SDBI_Start        DATETIME,
    SDBI_End          DATETIME,
    SDBI_Current      SMALLINT,
    SDBI_Last_Update  DATETIME,
    SDBI_Comment      VARCHAR (100) COLLATE NOCASE
);

INSERT INTO SQL_DB_Inventory (
                                 SDBI_Id,
                                 SDBI_Server,
                                 SDBI_DB_Id,
                                 SDBI_name,
                                 SDBI_RM,
                                 SDBI_Status,
                                 SDBI_Collation,
                                 SDBI_CL,
                                 SDBI_DB_Size_MB,
                                 SDBI_Log_Size_MB,
                                 SDBI_create_date,
                                 SDBI_Last_FULL,
                                 SDBI_Last_DIFF,
                                 SDBI_Last_Log,
                                 SDBI_Last_Restore,
                                 SDBI_Start,
                                 SDBI_End,
                                 SDBI_Current,
                                 SDBI_Last_Update,
                                 SDBI_Comment
                             )
                             SELECT SDBI_Id,
                                    SDBI_Server,
                                    SDBI_DB_Id,
                                    SDBI_name,
                                    SDBI_RM,
                                    SDBI_Status,
                                    SDBI_Collation,
                                    SDBI_CL,
                                    SDBI_DB_Size_MB,
                                    SDBI_Log_Size_MB,
                                    SDBI_create_date,
                                    SDBI_Last_FULL,
                                    SDBI_Last_DIFF,
                                    SDBI_Last_Log,
                                    SDBI_Last_Restore,
                                    SDBI_Start,
                                    SDBI_End,
                                    SDBI_Current,
                                    SDBI_Last_Update,
                                    SDBI_Comment
                               FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

-------------------------------
-- SQL_User Table recreation
-------------------------------
CREATE TABLE sqlitestudio_temp_table AS SELECT *
                                          FROM SQL_User;

DROP TABLE SQL_User;

CREATE TABLE SQL_User (
    SU_Id              INTEGER       NOT NULL
                                     PRIMARY KEY,
    SU_Server          VARCHAR (60)  COLLATE NOCASE,
    SU_Name            VARCHAR (100) COLLATE NOCASE,
    SU_User_Id         INTEGER,
    SU_Dbname          VARCHAR (60)  COLLATE NOCASE,
    SU_Type            VARCHAR (30)  COLLATE NOCASE,
    SU_IsSysadmin      VARCHAR (8)   COLLATE NOCASE,
    SU_IsServeradmin   VARCHAR (8)   COLLATE NOCASE,
    SU_IsProcessadmin  VARCHAR (8)   COLLATE NOCASE,
    SU_IsSecurityadmin VARCHAR (8)   COLLATE NOCASE,
    SU_IsSetupadmin    VARCHAR (8)   COLLATE NOCASE,
    SU_IsDiskadmin     VARCHAR (8)   COLLATE NOCASE,
    SU_IsBulkadmin     VARCHAR (8)   COLLATE NOCASE,
    SU_IsDbCreator     VARCHAR (8)   COLLATE NOCASE,
    SU_Status          VARCHAR (8)   COLLATE NOCASE,
    SU_Create_Date     DATETIME,
    SU_Start           DATETIME,
    SU_End             DATETIME,
    SU_Current         SMALLINT,
    SU_Last_Update     DATETIME,
    SU_Comment         VARCHAR (100) COLLATE NOCASE
);

INSERT INTO SQL_User (
                         SU_Id,
                         SU_Server,
                         SU_Name,
                         SU_User_Id,
                         SU_Dbname,
                         SU_Type,
                         SU_IsSysadmin,
                         SU_IsServeradmin,
                         SU_IsProcessadmin,
                         SU_IsSecurityadmin,
                         SU_IsSetupadmin,
                         SU_IsDiskadmin,
                         SU_IsBulkadmin,
                         SU_IsDbCreator,
                         SU_Status,
                         SU_Create_Date,
                         SU_Start,
                         SU_End,
                         SU_Current,
                         SU_Last_Update,
                         SU_Comment
                     )
                     SELECT SU_Id,
                            SU_Server,
                            SU_Name,
                            SU_User_Id,
                            SU_Dbname,
                            SU_Type,
                            SU_IsSysadmin,
                            SU_IsServeradmin,
                            SU_IsProcessadmin,
                            SU_IsSecurityadmin,
                            SU_IsSetupadmin,
                            SU_IsDiskadmin,
                            SU_IsBulkadmin,
                            SU_IsDbCreator,
                            SU_Status,
                            SU_Create_Date,
                            SU_Start,
                            SU_End,
                            SU_Current,
                            SU_Last_Update,
                            SU_Comment
                       FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM SQL_Job;

-------------------------------
-- SQL_DB_Ignore_list Table Add missing exeptions
-------------------------------

DROP TABLE SQL_Job;

CREATE TABLE SQL_Job (
    SJ_Id              INTEGER       NOT NULL
                                     PRIMARY KEY,
    SJ_Server          VARCHAR (60)  COLLATE NOCASE,
    SJ_Job_ID          VARCHAR (50)  COLLATE NOCASE,
    SJ_Name            VARCHAR (100) COLLATE NOCASE,
    SJ_Status          SMALLINT,
    SJ_Desc            VARCHAR       COLLATE NOCASE,
    SJ_Start_Step      SMALLINT,
    SJ_Owner           VARCHAR (50)  COLLATE NOCASE,
    SJ_Create_Date     DATETIME,
    SJ_Mod_Date        DATETIME,
    SJ_Version         INTEGER,
    SJ_Sch_Next_Date   INTEGER,
    SJ_Sch_Next_Time   INTEGER,
    SJ_Sch_Status      SMALLINT,
    SJ_Sch_ID          INTEGER,
    SJ_Sch_Create_Date DATETIME,
    SJ_Sch_Mod_Date    DATETIME,
    SJ_Sch_Desc        VARCHAR       COLLATE NOCASE,
    SJ_Start           DATETIME,
    SJ_End             DATETIME,
    SJ_Current         SMALLINT,
    SJ_Last_Update     DATETIME,
    SJ_Comment         VARCHAR (100) COLLATE NOCASE
);

INSERT INTO SQL_Job (
                        SJ_Id,
                        SJ_Server,
                        SJ_Job_ID,
                        SJ_Name,
                        SJ_Status,
                        SJ_Desc,
                        SJ_Start_Step,
                        SJ_Owner,
                        SJ_Create_Date,
                        SJ_Mod_Date,
                        SJ_Version,
                        SJ_Sch_Next_Date,
                        SJ_Sch_Next_Time,
                        SJ_Sch_Status,
                        SJ_Sch_ID,
                        SJ_Sch_Create_Date,
                        SJ_Sch_Mod_Date,
                        SJ_Sch_Desc,
                        SJ_Start,
                        SJ_End,
                        SJ_Current,
                        SJ_Last_Update,
                        SJ_Comment
                    )
                    SELECT SJ_Id,
                           SJ_Server,
                           SJ_Job_ID,
                           SJ_Name,
                           SJ_Status,
                           SJ_Desc,
                           SJ_Start_Step,
                           SJ_Owner,
                           SJ_Create_Date,
                           SJ_Mod_Date,
                           SJ_Version,
                           SJ_Sch_Next_Date,
                           SJ_Sch_Next_Time,
                           SJ_Sch_Status,
                           SJ_Sch_ID,
                           SJ_Sch_Create_Date,
                           SJ_Sch_Mod_Date,
                           SJ_Sch_Desc,
                           SJ_Start,
                           SJ_End,
                           SJ_Current,
                           SJ_Last_Update,
                           SJ_Comment
                      FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

PRAGMA foreign_keys = 1;

-------------------------------
-- SQL_DB_Ignore_list Table Add missing exeptions
-------------------------------

INSERT INTO SQL_DB_Ignore_List (
                                   IL_Comment,
                                   IL_Status,
                                   IL_Type,
                                   IL_name,
                                   IL_Server,
                                   IL_Id
                               )
                               VALUES (
                                   'Slave of YPGLDCYIDSQL01',
                                   1,
                                   'Log',
                                   NULL,
                                   'YPGLDCYIDSQL02',
                                   19
                               );