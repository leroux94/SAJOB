--------------------------------------------------------------------
-- Analyse Start -- Query_Job_ID : 1
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Create Analyse Query Run Number -- Order : 1 -- Status : 1
--------------------------------------------------------------------

INSERT INTO [Analyse_NumberGenerator](ID, [dummy])VALUES((select max(ID) from [Analyse_NumberGenerator]) + 1, 1);

--------------------------------------------------------------------
-- Delete Old Analyse Query Run Number -- Order : 2 -- Status : 1
--------------------------------------------------------------------

DELETE FROM [Analyse_NumberGenerator] WHERE ID IN (select min(ID) FROM [Analyse_NumberGenerator]) AND 1 NOT IN(SELECT count(ID) FROM [Analyse_NumberGenerator]);

--------------------------------------------------------------------
-- Fill Run_Info -- Order : 3 -- Status : 1
--------------------------------------------------------------------

INSERT INTO [Run_Info] (
	[Run_Col_Number]
	,[Run_Start]
	,[Run_End]
	,[Run_Analyse_Number]
	,[Run_Analyse_Start]
	,[Run_Collect_Job])
SELECT TM_S.[tm_num_exec] AS Run_Number,
	datetime(TM_S.[tm_date_collecte]) AS Run_Start,
	datetime(TM_E.[tm_date_collecte]) AS Run_End,
	A_NUM.ID AS Run_Analyse_Number,
	datetime('now','localtime') AS Run_Analyse_Start,
	Jobs.jobs_list AS Run_Collect_Job
FROM [table_maitre] AS TM_S
LEFT JOIN [table_maitre] AS TM_E ON TM_S.[tm_num_exec] = TM_E.[tm_num_exec]
Left Join (
	select max(ID) as ID
	from [Analyse_NumberGenerator]) as A_NUM on 1=1
LEFT JOIN (
SELECT DISTINCT t1.tm_num_exec AS  TM_Num_exec, (
	SELECT replace('#' || group_concat(cast(t2.tm_job AS VARCHAR), ', #') , ', #NULL', '')
	FROM (SELECT tm_num_exec, tm_job FROM [table_maitre] WHERE tm_job is not null GROUP BY tm_num_exec, tm_job) AS t2
) AS  Jobs_List
FROM [table_maitre] t1) AS Jobs ON Jobs.tm_num_exec = TM_S.[tm_num_exec]
WHERE TM_S.tm_champ_1 = 'SAJOB_MESSAGE'
AND TM_E.tm_champ_1 = 'SAJOB_MESSAGE'
AND TM_S.tm_champ_3 = '1'
AND TM_E.tm_champ_3 = '2'

--------------------------------------------------------------------
-- Clear Run_Info from Master -- Order : 4 -- Status : 1 --
--------------------------------------------------------------------

DELETE FROM [TABLE_MAITRE] WHERE TM_Champ_1 ='SAJOB_MESSAGE' AND ( TM_Champ_3 = '1' OR  TM_Champ_3 = '2')

--------------------------------------------------------------------
-- Purge Run_Info Table -- Order : 5 -- Status : 1 -- Comment : Purge 3 Years Old Rows
--------------------------------------------------------------------

DELETE FROM [Run_Info] WHERE datetime(Run_Start) < datetime('now', '-3 year')

--------------------------------------------------------------------
--------------------------------------------------------------------
-- Analyse End -- Query_Job_ID : 2  -- Order : 9999
--------------------------------------------------------------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Insert remaining rows in Restant_TM -- Order : 1 -- Status : 1
--------------------------------------------------------------------

INSERT INTO [Restant_TM]             ([TM_ID]             ,[TM_Date_Entre]             ,[TM_Date_collecte]             ,[TM_Num_exec]             ,[TM_Client]             ,[TM_Type]             ,[TM_Job]             ,[TM_Serveur]             ,[TM_SQL_ID]             ,[TM_Champ_1]             ,[TM_Champ_2]             ,[TM_Champ_3]             ,[TM_Champ_4]             ,[TM_Champ_5]             ,[TM_Champ_6]             ,[TM_Champ_7]             ,[TM_Champ_8]             ,[TM_Champ_9]             ,[TM_Champ_10]             ,[TM_Champ_11]             ,[TM_Champ_12]             ,[TM_Champ_13]             ,[TM_Champ_14]             ,[TM_Champ_15]             ,[TM_Champ_16]             ,[TM_Champ_17]             ,[TM_Champ_18] 			,[TM_Champ_19]             ,[TM_Champ_20]) 			select [TM_ID]            ,[TM_Date_Entre]            ,[TM_Date_collecte]            ,[TM_Num_exec]            ,[TM_Client]            ,[TM_Type]            ,[TM_Job]            ,[TM_Serveur]            ,[TM_SQL_ID]            ,[TM_Champ_1]            ,[TM_Champ_2]            ,[TM_Champ_3]            ,[TM_Champ_4]            ,[TM_Champ_5]            ,[TM_Champ_6]            ,[TM_Champ_7]            ,[TM_Champ_8]            ,[TM_Champ_9]            ,[TM_Champ_10]            ,[TM_Champ_11]            ,[TM_Champ_12]            ,[TM_Champ_13]            ,[TM_Champ_14]            ,[TM_Champ_15]            ,[TM_Champ_16]            ,[TM_Champ_17]            ,[TM_Champ_18]            ,[TM_Champ_19]            ,[TM_Champ_20] from [Table_Maitre];

--------------------------------------------------------------------
-- Purge TABLE_MAITRE Daily -- Order : 2 -- Status : 1
--------------------------------------------------------------------

DELETE FROM [TABLE_MAITRE];

--------------------------------------------------------------------
-- Purge Restant_TM -- Order : 3 -- Status : 1 -- Comment : Purge 2 Weeks old rows
--------------------------------------------------------------------

DELETE FROM [Restant_TM]  WHERE datetime(TM_Date_collecte) < datetime('now', '-2 week')

--------------------------------------------------------------------
-- Purge Analysis Error log -- Order : 4 -- Status : 1 -- Comment : Purge 3 months old rows
--------------------------------------------------------------------

DELETE FROM [Error_Analyse_Log] WHERE datetime(Error_Time) < datetime('now', '-3 month')

--------------------------------------------------------------------
-- Purge Analysis log -- Order : 5 -- Status : 1 -- Comment : Purge 1 month old rows
--------------------------------------------------------------------

DELETE FROM [Analyse_Log] WHERE A_A_Run_Num IN (select Run_analyse_number from Run_Info where datetime(Run_start) < datetime('now', '-1 month'));

--------------------------------------------------------------------
-- Run_info End -- Order : 9999 -- Status : 1 -- Comment : Last step of the run
--------------------------------------------------------------------
UPDATE [Run_Info]    SET
        [Run_Analyse_End] = datetime('now','localtime')
		,[Run_Analyse_Job] =
		(SELECT replace('#' || group_concat(cast(st1.Analyse_Job_ID AS VARCHAR), ', #') , ', #NULL', '')
			FROM (SELECT Analyse_Job_ID FROM [Analyse_Job] WHERE Analyse_Job_Status = 1) AS st1	)
	WHERE [Run_Analyse_End] is NULL;

--------------------------------------------------------------------
--------------------------------------------------------------------
-- Error Collector -- Query_Job_ID : 3  -- Order : 2
--------------------------------------------------------------------
--------------------------------------------------------------------
## ICI ##
--------------------------------------------------------------------
-- Fill Collector Error log -- Order : 1 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO [Error_Collector_Log]
            ([Error_Run_Num]
            ,[Error_Sev]
            ,[Error_Num]
            ,[Error_Text]
            ,[Error_Time]
            ,[Error_Client]
            ,[Error_Serveur]
            ,[Error_Serveur_Type]
            ,[Error_Job]
            ,[Error_SQL_ID])
			SELECT [TM_Num_exec]
			,[TM_Champ_2]
			,[TM_Champ_3]
			,[TM_Champ_4]
			,[TM_Date_collecte]
			,[TM_Client]
			,[TM_Serveur]
			,[TM_Type]
			,[TM_Job]
			,[TM_SQL_ID]
			FROM [TABLE_MAITRE]
			where TM_Champ_1 = 'SAJOB_MESSAGE';

--------------------------------------------------------------------
-- Delete Collector Error log from TM -- Order : 2 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE  FROM [TABLE_MAITRE]  where TM_Champ_1 = 'SAJOB_MESSAGE';

--------------------------------------------------------------------
-- Purge Collector Error log -- Order : 3 -- Status : 1 -- Comment : Purge 3 months old rows
--------------------------------------------------------------------

DELETE FROM [Error_Collector_Log]  WHERE datetime(Error_Time) < datetime('now', '-3 month');

--------------------------------------------------------------------
--------------------------------------------------------------------
-- SQL DB Inventory -- Query_Job_ID : 4 (was 5)  -- Order : 2
--------------------------------------------------------------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Clear Inventory staging table -- Order : 1 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE FROM [SQL_DB_Inv_Stage];

--------------------------------------------------------------------
-- Move Inventory data to staging table -- Order : 2 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO [SQL_DB_Inv_Stage]
  ([SDBI_Server]
  ,[SDBI_DB_Id]
  ,[SDBI_Name]
  ,[SDBI_RM]
  ,[SDBI_Status]
  ,[SDBI_Collation]
  ,[SDBI_CL]
  ,[SDBI_DB_Size_MB]
  ,[SDBI_Log_Size_MB]
  ,[SDBI_create_date]
  ,[SDBI_Last_FULL]
  ,[SDBI_Last_DIFF]
  ,[SDBI_Last_Log]
  ,[SDBI_Last_Restore]
  ,[SDBI_Collect_date])
  SELECT [TM_Serveur]
  ,[TM_Champ_1]
  ,[TM_Champ_2]
  ,[TM_Champ_3]
  ,[TM_Champ_4]
  ,[TM_Champ_5]
  ,[TM_Champ_6]
  ,[TM_Champ_7]
  ,[TM_Champ_8]
  ,datetime([TM_Champ_9])
  ,datetime([TM_Champ_10])
  ,datetime([TM_Champ_11])
  ,datetime([TM_Champ_12])
  ,datetime([TM_Champ_13])
  ,datetime([TM_Date_collecte])
  FROM [TABLE_MAITRE]
  where TM_Job  IN ( 3 ,4,12)
  and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);

--------------------------------------------------------------------
-- Insert in DB Size from staging table -- Order : 3 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO [SQL_DB_Size] ([SDBI_Server]
 ,[SDBI_DB_Id]
 ,[SDBI_Name]
 ,[SDBI_DB_Size_MB]
 ,[SDBI_Log_Size_MB]
 ,[SDBI_Collect_date])
 Select [SDBI_Server]
 ,[SDBI_DB_Id]
 ,[SDBI_Name]
 ,[SDBI_DB_Size_MB]
 ,[SDBI_Log_Size_MB]
 ,[SDBI_Collect_date]
 from SQL_DB_Inv_Stage
 where [SDBI_DB_Size_MB] is not null;

--------------------------------------------------------------------
-- Tag changed data as old -- Order : 4 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_DB_Inventory set [SDBI_Current] = 0, [SDBI_End] = datetime('now','localtime')
where SDBI_Current = 1
and SDBI_Server || SDBI_Name IN (
	select t.SDBI_Server || t.SDBI_name
	from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s
	where t.SDBI_Server = s.SDBI_Server
	and t.SDBI_Current = 1
	and t.SDBI_name = s.SDBI_Name
	and (
		t.SDBI_DB_Id != s.SDBI_DB_Id or
		t.SDBI_name != s.SDBI_Name or
		t.SDBI_RM != s.SDBI_RM or
		t.SDBI_Status != s.SDBI_Status or
		t.SDBI_Collation != s.SDBI_Collation or
		t.SDBI_CL != s.SDBI_CL or
		t.SDBI_create_date != s.SDBI_create_date
		)
	);

--------------------------------------------------------------------
-- Insert new row into db inventory table -- Order : 5 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO SQL_DB_Inventory(SDBI_Server, SDBI_DB_Id, SDBI_name, SDBI_RM, SDBI_Status, SDBI_Collation, SDBI_CL, SDBI_DB_Size_MB, SDBI_Log_Size_MB, SDBI_create_date, SDBI_Last_FULL, SDBI_Last_DIFF, SDBI_Last_Log, SDBI_Last_Restore, SDBI_Start, SDBI_Current, SDBI_Last_Update)
	select SDBI_Server, SDBI_DB_Id, SDBI_Name, SDBI_RM, SDBI_Status, SDBI_Collation, SDBI_CL, SDBI_DB_Size_MB, SDBI_Log_Size_MB, SDBI_create_date, SDBI_Last_FULL, SDBI_Last_DIFF, SDBI_Last_Log, SDBI_Last_Restore, datetime('now','localtime'), 1, SDBI_Collect_date
	from SQL_DB_Inv_Stage
	where SDBI_Server || SDBI_Name NOT IN (
		select t.SDBI_Server || t.SDBI_name
		from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s
		where t.SDBI_Current = 1
		and t.SDBI_End is null
		and t.SDBI_Server = s.SDBI_Server
		and t.SDBI_name = s.SDBI_Name);

--------------------------------------------------------------------
-- Update data in db_inv table -- Order : 6 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_DB_Inventory set SDBI_DB_Size_MB = (select SDBI_DB_Size_MB from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Log_Size_MB = (select SDBI_Log_Size_MB from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Last_FULL = (select SDBI_Last_FULL from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Last_DIFF = (select SDBI_Last_DIFF from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Last_Log = (select SDBI_Last_Log from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Last_Restore = (select SDBI_Last_Restore from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name),
	SDBI_Last_Update = (select SDBI_Collect_date from SQL_DB_Inv_Stage s where s.SDBI_Server = SQL_DB_Inventory.SDBI_Server and s.SDBI_Name = SQL_DB_Inventory.SDBI_Name)
where SDBI_Current = 1
AND SDBI_END is null
AND	SDBI_Server || SDBI_Name IN (
	SELECT sour.SDBI_Server || sour.SDBI_name
	FROM sql_db_inv_stage Sour, SQL_DB_Inventory target
	WHERE sour.SDBI_Server = target.SDBI_Server
	AND sour.SDBI_name = target.SDBI_name);

--------------------------------------------------------------------
-- Tag database as removed -- Order : 7 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_DB_Inventory set SDBI_End = datetime('now','localtime')
WHERE SDBI_Current = 1
and SDBI_End is null
and SDBI_Server || SDBI_Name NOT IN (
	select t.SDBI_Server || t.SDBI_name
	from SQL_DB_Inventory t,  SQL_DB_Inv_Stage s
	where t.SDBI_Server = s.SDBI_Server
	and t.SDBI_Current = 1
	and t.SDBI_name = s.SDBI_Name
	);

--------------------------------------------------------------------
-- Clear Table_Maitre -- Order : 8 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE  FROM [TABLE_MAITRE]  where TM_Job  IN ( 3 ,4,12) and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);

--------------------------------------------------------------------
--------------------------------------------------------------------
-- SQL_JOB Query_Job_ID : 5 (was 6)  -- Order : 2
--------------------------------------------------------------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Clear Job staging table -- Order : 1 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE FROM [SQL_Job_Stage];

--------------------------------------------------------------------
-- Insert Job History table -- Order : 2 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO SQL_JOB_HIST (
	[jh_server],
	[jh_job_id],
	[jh_step_id],
	[jh_step_name],
	[jh_status],
	[jh_mess_id],
	[jh_sev],
	[jh_message],
	[jh_date],
	[jh_duration],
	[jh_retry])
	SELECT TM_Serveur, tm_champ_1, tm_champ_2, tm_champ_3, tm_champ_4, tm_champ_5, tm_champ_6, tm_champ_7, (substr(tm_champ_8, 1, 4)||'-'||substr(tm_champ_8, 5, 2)||'-'||substr(tm_champ_8, 7, 2)||' '||substr(substr('000000'|| tm_champ_9, -6, 6), 1, 2)||':'|| substr(substr('000000'|| tm_champ_9, -6, 6), 3, 2)||':'||substr(substr('000000'|| tm_champ_9, -6, 6), 5, 2)), tm_champ_10, tm_champ_11
	FROM TABLE_MAITRE
	WHERE tm_job = 9
	and TM_Serveur || '&' || tm_champ_1 || '&' || tm_champ_2 || '&' || (substr(tm_champ_8, 1, 4)||'-'||substr(tm_champ_8, 5, 2)||'-'||substr(tm_champ_8, 7, 2)||' '||substr(substr('000000'|| tm_champ_9, -6, 6), 1, 2)||':'|| substr(substr('000000'|| tm_champ_9, -6, 6), 3, 2)||':'||substr(substr('000000'|| tm_champ_9, -6, 6), 5, 2)) NOT IN (
		select jh_Server || '&' || jh_job_id || '&' || jh_step_id || '&' || jh_date
		from SQL_JOB_HIST);

--------------------------------------------------------------------
-- Move into job stage table from TM -- Order : 3 -- Status : 1 -- Comment :
--------------------------------------------------------------------
INSERT INTO [SQL_Job_Stage]            ([SJ_Server]            ,[SJ_Job_ID]            ,[SJ_Name]            ,[SJ_Status]            ,[SJ_Desc]            ,[SJ_Start_Step]            ,[SJ_Owner]            ,[SJ_Create_Date]            ,[SJ_Mod_Date]            ,[SJ_Version]            ,[SJ_Sch_Next_Date]            ,[SJ_Sch_Next_Time]            ,[SJ_Sch_Status]            ,[SJ_Sch_ID]            ,[SJ_Sch_Create_Date]            ,[SJ_Sch_Mod_Date]            ,[SJ_Sch_Desc]) SELECT[TM_Serveur]       ,[TM_Champ_1]       ,[TM_Champ_2]       ,[TM_Champ_3]       ,[TM_Champ_4]       ,[TM_Champ_5]       ,[TM_Champ_6]       ,datetime([TM_Champ_7])       ,datetime([TM_Champ_8])       ,[TM_Champ_9]       ,[TM_Champ_11]       ,[TM_Champ_12]       ,[TM_Champ_13]       ,[TM_Champ_14]       ,datetime([TM_Champ_15])       ,datetime([TM_Champ_16])       ,[TM_Champ_17]   FROM [TABLE_MAITRE]   where TM_Job in (8,10);

--------------------------------------------------------------------
-- Clear Job data from TM -- Order : 4 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE  FROM [TABLE_MAITRE]  where TM_Job  IN ( 8,9,10 ) and TM_Num_exec = (select MAX(TM_Num_exec) from [TABLE_MAITRE]);

--------------------------------------------------------------------
-- Tag changed data as old -- Order : 5 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_Job SET [SJ_current] = 0, [SJ_end] = datetime('now','localtime')
WHERE [SJ_current] = 1
AND SJ_Server || SJ_Job_ID || SJ_Sch_ID IN (
	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID
	from SQL_Job t, SQL_Job_Stage s
	where t.SJ_Server = s.SJ_Server
	and t.SJ_Job_ID = s.SJ_Job_ID
	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0)
	and t.SJ_Current = 1
	and (
		t.SJ_Name != s.SJ_Name or
		t.SJ_Status != s.SJ_Status or
		t.SJ_Start_Step != s.SJ_Start_Step or
		t.SJ_Owner != s.SJ_Owner or
		t.SJ_Create_Date != s.SJ_Create_Date or
		t.SJ_Mod_Date != s.SJ_Mod_Date or
		t.SJ_Version != s.SJ_Version or
		t.SJ_Sch_Status != s.SJ_Sch_Status or
		t.SJ_Sch_Create_Date != s.SJ_Sch_Create_Date or
		t.SJ_Sch_Mod_Date != s.SJ_Sch_Mod_Date or
		t.SJ_Sch_Desc != s.SJ_Sch_Desc
	)
);

--------------------------------------------------------------------
-- Insert new data into SQL_Job Table -- Order : 6 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO SQL_Job ([SJ_Server] ,[SJ_Job_ID] ,[SJ_Name] ,[SJ_Status] ,[SJ_Desc] ,[SJ_Start_Step] ,[SJ_Owner] ,[SJ_Create_Date] ,[SJ_Mod_Date] ,[SJ_Version] ,[SJ_Sch_Next_Date] ,[SJ_Sch_Next_Time] ,[SJ_Sch_Status] ,[SJ_Sch_ID] ,[SJ_Sch_Create_Date] ,[SJ_Sch_Mod_Date] ,[SJ_Sch_Desc] ,[SJ_Start] ,[SJ_Current] ,[SJ_Last_Update])
	select SJ_Server, SJ_Job_ID, SJ_Name, SJ_Status, SJ_Desc, SJ_Start_Step, SJ_Owner, SJ_Create_Date, SJ_Mod_Date, SJ_Version, SJ_Sch_Next_Date, SJ_Sch_Next_Time, SJ_Sch_Status, SJ_Sch_ID, SJ_Sch_Create_Date, SJ_Sch_Mod_Date, SJ_Sch_Desc, datetime('now','localtime'), 1, datetime('now','localtime')
	from SQL_Job_Stage
	where SJ_Server || SJ_Job_ID || SJ_Sch_ID not in (
		select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID
		from SQL_Job t, SQL_Job_Stage s
		where SJ_Current = 1
		and SJ_End is null
		and t.SJ_Server = s.SJ_Server
		and t.SJ_Job_ID = s.SJ_Job_ID
		and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0)
	);

--------------------------------------------------------------------
-- Update data in SQL_Job Table  -- Order : 7 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_Job SET [SJ_Desc] = (select [SJ_Desc] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID) ,
	[SJ_Sch_Next_Date] = (select [SJ_Sch_Next_Date] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID) ,
	[SJ_Sch_Next_Time] = (select [SJ_Sch_Next_Time] from SQL_Job_Stage s where s.SJ_Server = SQL_JOB.SJ_Server and s.SJ_Job_ID = SQL_JOB.SJ_Job_ID and s.SJ_Sch_ID = SQL_JOB.SJ_Sch_ID),
	[sj_last_update] = datetime('now', 'localtime')
WHERE SJ_Current = 1
AND SJ_End is null
AND SJ_Server || SJ_Job_ID || SJ_Sch_ID IN (
	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID
	from SQL_Job t, SQL_Job_Stage s
	where t.SJ_Server = s.SJ_Server
	and t.SJ_Job_ID = s.SJ_Job_ID
	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0)
);

--------------------------------------------------------------------
-- Tag jobs as removed -- Order : 8 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_Job SET SJ_End = datetime('now', 'localtime')
WHERE SJ_Current =1
AND SJ_End is null
AND SJ_Server || SJ_Job_ID || SJ_Sch_ID NOT IN (
	select t.SJ_Server || t.SJ_Job_ID || t.SJ_Sch_ID
	from SQL_Job t, SQL_Job_Stage s
	where t.SJ_Server = s.SJ_Server
	and t.SJ_Job_ID = s.SJ_Job_ID
	and ifnull(t.SJ_Sch_ID, 0) = ifnull(s.SJ_Sch_ID, 0)
	and t.SJ_Current = 1
);

--------------------------------------------------------------------
-- Purge SQL_Job_Hist Table -- Order : 9 -- Status : 1 -- Comment : Purge 1 Month Old Rows
--------------------------------------------------------------------

DELETE FROM SQL_Job_Hist where datetime(jh_Date) < datetime('now', '-1 Month', 'localtime');

--------------------------------------------------------------------
--------------------------------------------------------------------
-- Query_Job_ID : 6 (was 7)  -- Order : 6
--------------------------------------------------------------------
--------------------------------------------------------------------

--------------------------------------------------------------------
-- Clear User staging table -- Order : 1 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE FROM[SQL_User_Stage];

--------------------------------------------------------------------
-- Move into user stage table from TM -- Order : 2 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO [SQL_User_Stage]([SU_Server],[SU_Name],[SU_User_Id],[SU_Dbname],[SU_Type],[SU_IsSysadmin],[SU_IsServeradmin],[SU_IsProcessadmin],[SU_IsSecurityadmin],[SU_IsSetupadmin],[SU_IsDiskadmin],[SU_IsBulkadmin],[SU_IsDbCreator],[SU_Status],[SU_Create_Date])
	SELECT[TM_Serveur],[TM_Champ_1],[TM_Champ_2],[TM_Champ_3],[TM_Champ_4],[TM_Champ_5],[TM_Champ_6],[TM_Champ_7],[TM_Champ_8],[TM_Champ_9],[TM_Champ_10],[TM_Champ_11],[TM_Champ_12],[TM_Champ_13],datetime([TM_Champ_14])  FROM [TABLE_MAITRE]   where TM_Job in (13, 14);

--------------------------------------------------------------------
-- Clear User data from TM -- Order : 3 -- Status : 1 -- Comment :
--------------------------------------------------------------------

DELETE FROM [TABLE_MAITRE]  WHERE TM_Job  IN ( 13, 14 ) AND TM_Num_exec = (SELECT MAX(TM_Num_exec) FROM [TABLE_MAITRE]);

--------------------------------------------------------------------
-- Tag changed data as old  -- Order : 4 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_User SET [SU_current] = 0, [SU_end] = datetime('now', 'localtime')
WHERE [SU_current] = 1
AND SU_Server || SU_Name IN (
	select t.SU_Server || t.SU_Name
	from SQL_User t, SQL_User_Stage s
	where t.SU_Server = s.SU_Server
	and t.SU_Name = s.SU_Name
	and t.SU_Current = 1
	and (
		t.SU_User_Id != s.SU_User_Id or
		t.SU_Type != s.SU_Type or
		t.SU_Dbname != s.SU_Dbname or
		t.SU_Type != s.SU_Type or
		t.SU_IsSysadmin != s.SU_IsSysadmin or
		t.SU_IsServeradmin != s.SU_IsServeradmin or
		t.SU_IsProcessadmin != s.SU_IsProcessadmin or
		t.SU_IsSecurityadmin != s.SU_IsSecurityadmin or
		t.SU_IsSetupadmin != s.SU_IsSetupadmin or
		t.SU_IsDiskadmin != s.SU_IsDiskadmin or
		t.SU_IsBulkadmin != s.SU_IsBulkadmin or
		t.SU_IsDbCreator != s.SU_IsDbCreator or
		t.SU_Status != s.SU_Status or
		t.SU_create_date != s.SU_create_date
	)
);

--------------------------------------------------------------------
-- Insert new data into SQL_User Table -- Order : 5 -- Status : 1 -- Comment :
--------------------------------------------------------------------

INSERT INTO SQL_User ([SU_Server],[SU_name],[SU_User_Id],[SU_Dbname],[SU_Type],[SU_IsSysadmin],[SU_IsServeradmin],[SU_IsProcessadmin],[SU_IsSecurityadmin],[SU_IsSetupadmin],[SU_IsDiskadmin],[SU_IsBulkadmin],[SU_IsDbCreator],[SU_Status],[SU_create_date], [SU_Start], [SU_End], [SU_Current], [SU_Last_Update])
	select SU_Server, SU_name, SU_User_Id, SU_Dbname, SU_Type, SU_IsSysadmin, SU_IsServeradmin, SU_IsProcessadmin, SU_IsSecurityadmin, SU_IsSetupadmin, SU_IsDiskadmin, SU_IsBulkadmin, SU_IsDbCreator, SU_Status, SU_create_date, datetime('now','localtime'), null, 1, SU_Collect_Date
	from SQL_User_Stage
	where SU_Server || SU_Name not in (
		select t.SU_Server || t.SU_Name
		from SQL_User t, SQL_User_Stage s
		where SU_Current = 1
		and SU_End is null
		and t.SU_Server = s.SU_Server
		and t.SU_Name = s.SU_Name
	);

--------------------------------------------------------------------
-- Tag User as removed -- Order : 6 -- Status : 1 -- Comment :
--------------------------------------------------------------------

UPDATE SQL_User SET SU_End = datetime('now','localtime')
WHERE SU_Current =1
AND SU_End is null
AND SU_Server || SU_Name NOT IN (
	select t.SU_Server || t.SU_Name
	from SQL_User t, SQL_User_Stage s
	where t.SU_Server = s.SU_Server
	and t.SU_Name = s.SU_Name
	and t.SU_Current = 1
);





