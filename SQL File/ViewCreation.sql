--------------------------------------------------------------------------------
--NAME CHANGE :
--------------------------------------------------------------------------------
--	[SQLDBINV].[Backups]      -> [SQL_DB_Backups]
--	[SQLDBINV].[Changement]   -> [SQL_DB_Change]
--	[SQLDBINV].[DB_Grow]      -> [SQL_DB_Grow]
--	[SQLJOB].[JOB_Changement] -> [SQL_Job_Change]
--  [SQLJOB].[Job_Fail_Det]   -> [SQL_Job_Fail_Det]
--  [SQLJOB].[Job_Late]       -> [SQL_Job_Late]
--  [SQLJOB].[Job_Report]     -> [SQL_Job_Report]
--  [SQLUSER].[Changement]    -> [SQL_User_Change]
--  [SQLUSER].[NewSysadmin]   -> [SQL_User_NewSysadmin]
--  [SAJOB].[Restant]         -> [Untreated_Data]

-- TEST DATE : '2016-10-14 07:00:00'

--------------------------------------------------------------------------------
-- View Error_Analyse
--------------------------------------------------------------------------------
create view [Error_Analyse] as
SELECT logs.[Error_Analyse_Run] as 'Analyse ID'
      , sev.[Error_Severity_Name] as 'Severity'
      ,num.[Error_Number_Text] as 'Error'
      ,logs.[Error_Text] as 'Error text'
      ,logs.[Error_Time] as 'Error time'
      ,logs.[Error_Job] as 'Analyse Job ID'
      ,ajob.[Analyse_Job_Name] as 'Analyse job'
      ,logs.[Error_Query] as 'Analyse Query ID'
      ,aque.[Analyse_Query_Name] as 'Analyse Query'
  FROM [Error_Analyse_Log] logs
  Left join [Error_Severity] sev on logs.Error_Sev = sev.Error_Severity_Id
  left join [Error_Number] num on logs.[Error_Num] = num.Error_Number_Id
  left join [Analyse_Job] ajob on logs.[Error_Job] = ajob.Analyse_Job_ID
  left join [Analyse_Query] aque on logs.[Error_Query] = aque.Analyse_Query_ID
  where datetime(Error_Time) > datetime('now', '-1 days', 'localtime');


--------------------------------------------------------------------------------
-- View Error_Collector
--------------------------------------------------------------------------------
create view [Error_Collector] as
SELECT [Error_Run_Num] as 'Collection ID'
      , sev.Error_Severity_Name as 'Severity'
      ,num.Error_Number_Text as 'Error'
      ,[Error_Text] as 'Error Text'
      ,[Error_Time] as 'Error Time'
      ,[Error_Serveur] as 'Server'
      ,[Error_Serveur_Type] as 'Type'
      ,[Error_Job] as 'Collection job ID'
      ,cjob.JobName as 'Collection ID'
      ,[Error_SQL_ID] as 'Collection Query ID'
      ,cque.SqlName as 'Collection Query'
  FROM [Error_Collector_Log] logs
  Left join [Error_Severity] sev on logs.Error_Sev = sev.Error_Severity_Id
  left join [Error_Number] num on logs.[Error_Num] = num.Error_Number_Id
  left join [Prm_Jobs] cjob on logs.[Error_Job] = cjob.JobId
  left join [Prm_SqlQueries] cque on logs.[Error_SQL_ID] = cque.SqlID
  where datetime(Error_Time) > datetime('now', '-1 day', 'localtime');


--------------------------------------------------------------------------------
-- View Rapport_SAJOB
--------------------------------------------------------------------------------
create view [Rapport_SAJOB] as
SELECT [Run_Col_Number] as 'Collection ID'
      ,[Run_Start] as 'Collection Start'
      ,[Run_End] as 'Collection End'
      ,[Run_Collect_Job] as 'Collection Jobs executed'
      ,[Run_Analyse_Number] as 'Analyse ID'
      ,[Run_Analyse_Start] as 'Analyse Start'
      ,[Run_Analyse_End] as 'Analyse End'
      ,[Run_Analyse_Job] as 'Analyse Jobs executed'
  FROM [Run_Info]
  where datetime(Run_Analyse_End) > datetime('now', '-0.97 days', 'localtime');


--------------------------------------------------------------------------------
-- View Untreated_Data
--------------------------------------------------------------------------------
create view [Untreated_Data] as
SELECT Reste.[TM_Type] as 'Type'
      ,Reste.[TM_Job] as 'Collection Job ID'
      ,Jobs.[JobName] as 'Collection Job'
      ,Reste.[TM_SQL_ID] as 'Collection Query ID'
      ,Que.[SqlName] as 'Collection Query'
      ,COUNT(1) as 'Unprocessed Line'
  FROM [Restant_TM] Reste
  left join [Prm_Jobs] Jobs
  on Reste.TM_Job = Jobs.JobID
  left join [Prm_SqlQueries] Que
  on Reste.[TM_SQL_ID] = Que.SqlID
  group by Reste.[TM_Type]      ,Reste.[TM_Job]      ,Jobs.JobName       ,Reste.[TM_SQL_ID]       ,Que.SqlName ;


--------------------------------------------------------------------------------
-- View SQL_DB_Backups
--------------------------------------------------------------------------------
SELECT inv.[SDBI_Server] as 'Server'
	  ,inv.[SDBI_name] as 'Database'
	  ,inv.[SDBI_Last_FULL] as 'Last Full'
	  ,inv.[SDBI_Last_DIFF] as 'Last Diff'
FROM [SQL_DB_Inventory] inv
left Join [Prm_Server] list on inv.[SDBI_Server]=list.[serverName]
WHERE inv.SDBI_Current = 1   and inv.SDBI_name not in ('tempdb')  and list.DTQAP ='P'
AND ((coalesce(inv.SDBI_Last_FULL, '0001-01-01 00:00:00') < datetime('now', '-1 day', 'localtime')
AND coalesce(inv.SDBI_Last_DIFF, '0001-01-01 00:00:00') < datetime('now', '-1 day', 'localtime') and not exists (select 1 from [SQL_DB_Ignore_List] il where il.il_server = inv.SDBI_Server and il.il_name = inv.SDBI_name and il_type = 'Weekly'))
OR ((inv.SDBI_Server in (select IL_Server from [SQL_DB_Ignore_List] where IL_name = inv.SDBI_name and il_type = 'Weekly') AND coalesce(inv.SDBI_Last_FULL, '0001-01-01 00:00:00') < datetime('now', '-7 days', 'localtime'))
AND coalesce(inv.SDBI_Last_DIFF, '0001-01-01 00:00:00') < datetime('now', '-7 days', 'localtime')))
and inv.SDBI_Server not in (select IL_Server from [SQL_DB_Ignore_List] where IL_name is null and il_type = 'Backup')
and not exists (select 1 from [SQL_DB_Ignore_List] il where il.il_server = inv.SDBI_Server and il.il_name = inv.SDBI_name and il_type = 'Backup')

--------------------------------------------------------------------------------
-- View SQL_DB_Log_Backups
--------------------------------------------------------------------------------

create view [SQL_DB_Log_Backups] as
SELECT inv.SDBI_server as 'Server',
	inv.SDBI_name as 'Database',
	inv.SDBI_Last_Log as 'Last Log'
FROM SQL_DB_Inventory inv
LEFT JOIN Prm_Server list on inv.SDBI_Server=list.ServerName
WHERE inv.SDBI_Current = 1
and inv.SDBI_RM = 'FULL'
and inv.SDBI_Name NOT IN ('tempdb', 'model', 'msdb', 'master')
and list.DTQAP = 'P'
AND coalesce(inv.SDBI_Last_Log, '0001-01-01 00:00:00') < datetime('now', '-2 Days')
and inv.SDBI_Server not in (select IL_Server from [SQL_DB_Ignore_List] where IL_name is null and il_type = 'Log')
and not exists (select 1 from [SQL_DB_Ignore_List] il where il.il_server = inv.SDBI_Server and il.il_name = inv.SDBI_name and il_type = 'Log')
ORDER BY Server, Database;




--------------------------------------------------------------------------------
-- View SQL_DB_Change
--------------------------------------------------------------------------------
create view [SQL_DB_Change] as
SELECT Case
		When SDBI_Current = 1 and co = 1 and SDBI_End IS NOT NULL Then 'Deleted Database'
		When SDBI_Current = 1 and co = 1 and SDBI_End IS NULL  Then 'New Database'
		When SDBI_Current = 0 and co > 1 Then 'Modification (Old)'
		When SDBI_Current = 1 and co > 1  Then 'Modification (New)'
		Else 'Error'
	end as 'Nature',
	   [SDBI_Server] as 'Server'
      ,[SDBI_name] as 'Database'
      ,[SDBI_DB_Id] as 'ID'
      ,[SDBI_RM] as 'Recovery Model'
      ,[SDBI_Status] as 'Statut'
      ,[SDBI_Collation] as 'Collation'
      ,[SDBI_CL] as 'Compatibility Level'
      ,[SDBI_create_date] as 'Creation Date'
      ,[SDBI_Last_Restore] as 'Last Restore'
      ,[SDBI_Comment] as 'Comment'
      from
      (select
      main.[SDBI_Server]
	  ,main.[SDBI_name]
      ,main.[SDBI_DB_Id]
      ,main.[SDBI_RM]
      ,main.[SDBI_Status]
      ,main.[SDBI_Collation]
      ,main.[SDBI_CL]
      ,main.[SDBI_create_date]
      ,main.[SDBI_Last_Restore]
      ,main.SDBI_End
      ,main.[SDBI_Current]
      ,main.[SDBI_Comment]
      ,co.co
  FROM [SQL_DB_Inventory] main
  left join (select COUNT(1) as co, SDBI_Server, SDBI_name from [SQL_DB_Inventory] where datetime(SDBI_Start) > datetime('now', '-1 day', 'localtime')  or datetime(SDBI_End) > datetime('now', '-1 day', 'localtime') group by SDBI_Server,SDBI_Name) as co
  on co.SDBI_Server = main.SDBI_Server and co.SDBI_name = main.SDBI_name
  where datetime(main.SDBI_Start) > datetime('now', '-1 day', 'localtime')
  or datetime(main.SDBI_End) > datetime('now', '-1 day', 'localtime')
  and main.SDBI_Server not in (select IL_Server from [SQL_DB_Ignore_List] where IL_name is null and il_type = 'Changement')
  and not exists (select 1 from [SQL_DB_Ignore_List] il where il.il_server = main.SDBI_Server and il.il_name = main.SDBI_name and il_type = 'Changement')
  ) q1
  order by SDBI_Server, SDBI_name, [SDBI_Current];


--------------------------------------------------------------------------------
-- View SQL_DB_Grow
--------------------------------------------------------------------------------
create view [SQL_DB_Grow] as
SELECT auj.[SDBI_Server] as 'Server'
      ,auj.[SDBI_Name] as 'Database'
      ,auj.[SDBI_DB_Size_MB] as 'Data Today. (Mb)'
      ,hier.[SDBI_DB_Size_MB] as 'Data Yesterday (Mb)'
     ,sem.[SDBI_DB_Size_MB] as 'Data Last week (Mb)'
      ,auj.[SDBI_Log_Size_MB] as 'Log Today (Mb)'
      ,hier.[SDBI_Log_Size_MB]   as 'Log Yesterday (Mb)'
      ,sem.[SDBI_Log_Size_MB] as 'Log Last Week (Mb)'
  FROM (select [SDBI_Server], [SDBI_Name], max([SDBI_DB_Size_MB]) as [SDBI_DB_Size_MB] ,max([SDBI_Log_Size_MB]) as [SDBI_Log_Size_MB] from
  [SQL_DB_Size] where datetime([SDBI_Collect_date]) > datetime('now', '-0.8 day', 'localtime') group by [SDBI_Server], [SDBI_Name] ) auj
  left join (select [SDBI_Server], [SDBI_Name], max([SDBI_DB_Size_MB]) as [SDBI_DB_Size_MB] ,max([SDBI_Log_Size_MB]) as [SDBI_Log_Size_MB] from
  [SQL_DB_Size] where datetime([SDBI_Collect_date]) between datetime('now', '-1.2 day', 'localtime') and datetime('now', '-0.8 day', 'localtime') group by [SDBI_Server], [SDBI_Name] ) as hier
  on auj.[SDBI_Server] = hier.[SDBI_Server] and
	auj.[SDBI_Name] = hier.[SDBI_Name]
  left join (select [SDBI_Server], [SDBI_Name], max([SDBI_DB_Size_MB]) as [SDBI_DB_Size_MB] ,max([SDBI_Log_Size_MB]) as [SDBI_Log_Size_MB] from
  [SQL_DB_Size] where datetime([SDBI_Collect_date]) between datetime('now', '-6.8 day', 'localtime') and datetime('now', '-7.2 day', 'localtime') group by [SDBI_Server], [SDBI_Name] ) as sem
  on auj.[SDBI_Server] = sem.[SDBI_Server] and
	auj.[SDBI_Name] = sem.[SDBI_Name]
left join [SQL_DB_Inventory] inv
on auj.[SDBI_Server] = inv.SDBI_Server and
	auj.[SDBI_Name] = inv.SDBI_name
	where (auj.[SDBI_DB_Size_MB] > hier.[SDBI_DB_Size_MB] * 1.2
	or auj.[SDBI_DB_Size_MB] > sem.[SDBI_DB_Size_MB] * 1.5
	or inv.SDBI_RM = 'FULL'
	AND (auj.[SDBI_LOG_Size_MB] > hier.[SDBI_LOG_Size_MB] * 1.2
	or auj.[SDBI_LOG_Size_MB] > sem.[SDBI_LOG_Size_MB] * 1.5)
	);


--------------------------------------------------------------------------------
-- View SQL_Job_Change
--------------------------------------------------------------------------------
Create view [SQL_Job_Change] as
SELECT  Case
		When SJ_Current = 1 and co = 1 and SJ_End IS NOT NULL Then 'Job Deleted'
		When SJ_Current = 1 and co = 1 and SJ_End IS NULL  Then 'New Job'
		When SJ_Current = 0 and co > 1 Then 'Modification (Old)'
		When SJ_Current = 1 and co > 1  Then 'Modification (New)'
		Else 'Error'
	end as 'Nature',
	   [SJ_Server] as 'Server'
      ,[SJ_name] as 'Job'
      ,[SJ_Desc] as 'Description'
      ,[SJ_Status] as 'Status'
      ,[SJ_Owner] as 'Owner'
      ,[SJ_Sch_Desc] as 'Schedule'
      ,[SJ_Sch_Status] as 'Schedule Status'
      ,[SJ_Job_ID] as 'Job ID'
      ,[SJ_Version] as 'Version'
      ,datetime([SJ_Create_Date]) as 'Creation Date'
      ,datetime([SJ_Mod_Date]) as 'Modification Date'
      ,[SJ_Start_Step] as '1st Step'
      ,[SJ_Sch_ID] as 'Sche. ID'
      ,datetime([SJ_Sch_Create_Date]) as 'Schedule Creation Date'
      ,datetime([SJ_Sch_Mod_Date]) as 'Schedule Modif Date'
      ,[SJ_Comment] as 'Comment'
      from
      (select
      main.[SJ_Server]
	  ,main.[SJ_name]
	  ,main.[SJ_Desc]
	  ,main.[SJ_Job_ID]
	   ,main.[SJ_Status]
       ,main.[SJ_Start_Step]
       ,main.[SJ_Owner]
       ,main.[SJ_Create_Date]
       ,main.[SJ_Mod_Date]
       ,main.[SJ_Version]
       ,main.[SJ_Sch_Status]
       ,main.[SJ_Sch_ID]
       ,main.[SJ_Sch_Create_Date]
       ,main.[SJ_Sch_Mod_Date]
       ,main.[SJ_Sch_Desc]
      ,main.SJ_End
      ,main.[SJ_Current]
      ,main.[SJ_Comment]
      ,co.co
  FROM [SQL_Job] main
  left join (select COUNT(1) as co, SJ_Server, SJ_name, SJ_Sch_ID from [SQL_Job] where datetime(SJ_Start) > datetime('now', '-1 day', 'localtime')  or datetime(SJ_End) > datetime('now', '-1 day', 'localtime') group by SJ_Server, SJ_Name, SJ_Sch_ID) as co
  on co.SJ_Server = main.SJ_Server and co.SJ_name = main.SJ_name and COALESCE (co.SJ_Sch_ID, 0) = COALESCE (main.SJ_Sch_ID, 0)
  where datetime(main.SJ_Start) > datetime('now', '-1 day', 'localtime')
  or datetime(main.SJ_End) > datetime('now', '-1 day', 'localtime')
  and main.SJ_Server not in (select IL_Server from [SQL_Job_Ignore_List] where IL_name is null and il_type = 'Changement')
  and not exists (select 1 from [SQL_Job_Ignore_List] il where il.il_server = main.SJ_Server and il.il_name = main.SJ_name and il_type = 'Changement')
  ) q1
  order by SJ_Server, SJ_Job_ID, [SJ_Sch_ID], [SJ_Current];

--------------------------------------------------------------------------------
-- View SQL_Job_Fail_Det
--------------------------------------------------------------------------------
create view [SQL_Job_Fail_Det] as
SELECT hist.jh_server         AS 'Server',
       job.sj_name            AS 'Job',
       hist.jh_step_name      AS 'Fail Step',
       hist.jh_step_id        AS 'Step ID',
       Max( hist.jh_date )    AS 'Last Fail Time',
       Max( hist.jh_message ) AS 'Error Message Example'
FROM   [SQL_JOB_HIST] hist
       LEFT JOIN [SQL_JOB] AS job
              ON job.sj_server = hist.jh_server AND
                 job.sj_job_id = hist.jh_job_id
WHERE  EXISTS
       ( SELECT jh_job_id
         FROM   SQL_Job_Fail_Det_2 f
         WHERE  f.Job = hist.jh_job_id AND
                f.Server = hist.jh_server ) AND
       datetime(hist.jh_date) > datetime('now', '-1.04 day', 'localtime') AND
       jh_step_id <> 0 AND
       jh_status = 0
GROUP  BY hist.jh_server, job.sj_name, hist.jh_step_name, hist.jh_step_id;

--------------------------------------------------------------------------------
-- View SQL_Job_Fail_Det_2
--------------------------------------------------------------------------------
create view [SQL_Job_Fail_Det_2] as
SELECT hist2.jh_server AS 'Server',
       hist2.jh_job_id AS 'Job'
FROM   (
	SELECT  jh_server,
			jh_job_id,
			SUM(CASE WHEN jh_status = 0 THEN 1 ELSE 0 END) AS '0',
			SUM(CASE WHEN jh_status = 1 THEN 1 ELSE 0 END) AS '1',
			SUM(CASE WHEN jh_status = 2 THEN 1 ELSE 0 END) AS '2',
			SUM(CASE WHEN jh_status = 3 THEN 1 ELSE 0 END) AS '3'
	FROM (
		SELECT jh_server,
				jh_job_id,
				jh_status
		FROM   [SQL_JOB_HIST]
		WHERE  datetime(jh_date) > datetime('now', '-1.04 day', 'localtime')
		AND (jh_step_id = 0 or JH_Status = 2)
	) AS hist
	GROUP BY jh_job_id
) AS hist2
LEFT JOIN [SQL_JOB] AS job
ON job.sj_server = hist2.jh_server
AND job.sj_job_id = hist2.jh_job_id
WHERE  ( [0] ) <> 0
AND NOT (
	EXISTS (
		SELECT il_server
		FROM   SQL_JOB_IGNORE_LIST
		WHERE  il_name IS NULL
		AND il_type = 'Status'
		AND il_server = hist2.jh_server
		)
	OR EXISTS(
		SELECT il_server
		FROM   SQL_JOB_IGNORE_LIST
		WHERE  il_name = job.sj_name
		AND il_type = 'Status'
		AND il_server = hist2.jh_server
		AND ( ( [1] / ( [0] + [1] + [3] ) * 100 ) < COALESCE( il_pourcent_ok, 0 ) )
	)
) ;

--------------------------------------------------------------------------------
-- View SQL_Job_Late
--------------------------------------------------------------------------------
create view [SQL_Job_Late] as
SELECT
	[SJ_Server] as 'Server'
      ,[SJ_Name] as 'Job'
      ,[SJ_Sch_Desc] 'Schedule'
      ,datetime(date([SJ_Sch_Next_Date]), time([SJ_Sch_Next_Time])) as 'Next expected Run'
  FROM [SQL_Job]
  where
  SJ_Status = 1
  and SJ_Sch_Status = 1
  and SJ_Sch_Next_Date !=0
  and SJ_Current = 1
  and SJ_End is null
  and (SELECT MAX(julianday(Run_Start)) FROM [Run_Info]) >  julianday(datetime(date([SJ_Sch_Next_Date]), time([SJ_Sch_Next_Time]))) + 1
  order by [SJ_Server];


--------------------------------------------------------------------------------
-- View SQL_Job_Report
--------------------------------------------------------------------------------
create view [SQL_Job_Report] as
SELECT hist2.jh_server as 'Server',
       job.sj_name as 'Job',
       case when [1] = 0 then '' else cast([1] as varchar(10)) end AS ' Success ',
       case when [0] = 0 then '' else cast([0] as varchar(10)) end AS ' Fail ',
       case when [3] = 0 then '' else cast([3] as varchar(10)) end AS ' Cancel ',
       case when [2] = 0 then '' else cast([2] as varchar(10)) end AS ' Retry ',
       ( [0] + [1]  + [3] ) AS 'Total'
FROM   (SELECT  jh_server,
			    jh_job_id,
			    SUM(CASE WHEN jh_status = 0 THEN 1 ELSE 0 END) AS '0',
				SUM(CASE WHEN jh_status = 1 THEN 1 ELSE 0 END) AS '1',
				SUM(CASE WHEN jh_status = 2 THEN 1 ELSE 0 END) AS '2',
				SUM(CASE WHEN jh_status = 3 THEN 1 ELSE 0 END) AS '3'
		FROM (
			SELECT jh_server,
                jh_job_id,
				jh_status
			FROM   [SQL_JOB_HIST]
			WHERE  datetime(jh_date) > datetime('now', '-1.04 day', 'localtime') AND
                (jh_step_id = 0 or JH_Status = 2)
			) hist
		GROUP BY jh_job_id
		) AS hist2
    LEFT JOIN (select sj_server,sj_job_id,sj_name from [SQL_JOB] group by sj_server, sj_job_id, sj_name) AS job
              ON job.sj_server = hist2.jh_server AND
                 job.sj_job_id = hist2.jh_job_id
WHERE  ( [0] + [3] ) <> 0
and not (exists (select IL_Server from SQL_Job_Ignore_List where il_name is null and IL_Type = 'Status' and IL_Server = hist2.JH_Server)
or exists (select IL_Server from SQL_Job_Ignore_List where il_name = job.SJ_Name and IL_Type = 'Status' and IL_Server = hist2.JH_Server and (([1]/( [0] + [1]  + [3] )*100) <= coalesce(IL_Pourcent_OK,0)))
)
ORDER BY Server;


--------------------------------------------------------------------------------
-- View SQL_User_Change
--------------------------------------------------------------------------------
create view [SQL_User_Change] as
SELECT Case
		When SU_Current = 1 and co = 1 and SU_End IS NOT NULL Then 'User Deleted'
		When SU_Current = 1 and co = 1 and SU_End IS NULL  Then 'New User'
		When SU_Current = 0 and co > 1 Then 'Modification (Old)'
		When SU_Current = 1 and co > 1  Then 'Modification (New)'
		Else 'Erreur de PMG'
	end as 'Nature',
	   [SU_Server] as 'Server'
      ,[SU_Name] as 'Name'
      ,[SU_User_Id] as 'ID'
      ,[SU_Type] as 'Login Type'
      ,[SU_Status] as 'Statut'
      ,[SU_IsSysadmin] as 'IsSysadmin'
	  ,[SU_IsServeradmin] as 'IsServeradmin'
	  ,[SU_IsProcessadmin] as 'IsProcessadmin'
	  ,[SU_IsSecurityadmin] as 'IsSecurityadmin'
	  ,[SU_IsSetupadmin] as 'IsSetupadmin'
	  ,[SU_IsDiskadmin] as 'IsDiskadmin'
	  ,[SU_IsBulkadmin] as 'IsBulkadmin'
	  ,[SU_IsDbCreator] as 'IsDbCreator'
      ,[SU_create_date] as 'Creation Date'
      ,[SU_Comment] as 'Comment'
      from
      (select
      main.[SU_Server]
	  ,main.[SU_Name]
      ,main.[SU_User_Id]
      ,main.[SU_Type]
      ,main.[SU_Status]
      ,main.[SU_IsSysadmin]
	  ,main.[SU_IsServeradmin]
	  ,main.[SU_IsProcessadmin]
	  ,main.[SU_IsSecurityadmin]
	  ,main.[SU_IsSetupadmin]
	  ,main.[SU_IsDiskadmin]
	  ,main.[SU_IsBulkadmin]
	  ,main.[SU_IsDbCreator]
      ,main.[SU_create_date]
      ,main.[SU_Last_Update]
      ,main.[SU_End]
      ,main.[SU_Current]
      ,main.[SU_Comment]
      ,co.co
  FROM [SQL_User] main
  left join (select COUNT(1) as co, SU_Server, SU_name
	from [SQL_User]
	where datetime(SU_Start) > datetime('now', '-1 day', 'localtime')  or datetime(SU_End) > datetime('now', '-1 day', 'localtime') group by SU_Server,SU_Name) as co
  on co.SU_Server = main.SU_Server and co.SU_name = main.SU_name
  where datetime(main.SU_Start) > datetime('now', '-1 day', 'localtime')
  or datetime(main.SU_End) > datetime('now', '-1 day', 'localtime')
  and main.SU_Server not in (select IL_Server from [SQL_User_Ignore_List] where IL_name is null and il_type = 'Changement')
  and not exists (select 1 from [SQL_User_Ignore_List] il where il.il_server = main.SU_Server and il.il_name = main.SU_name and il_type = 'Changement')
  ) q1
  order by SU_Server, SU_name, [SU_Current];


--------------------------------------------------------------------------------
-- View SQL_User_NewSysadmin
--------------------------------------------------------------------------------
create view [SQL_User_NewSysadmin] as
SELECT [SU_Server] as 'Server'
      ,[SU_Name] as 'Name'
      ,[SU_User_Id] as 'ID'
      ,[SU_Type] as 'Login Type'
      ,[SU_Status] as 'Statut'
      ,[SU_IsSysadmin] as 'isSysadmin'
      ,[SU_create_date] as 'Creation Date'
      ,[SU_Comment] as 'Comment'
      from
      (select
      main.[SU_Server]
	  ,main.[SU_Name]
      ,main.[SU_User_Id]
      ,main.[SU_Type]
      ,main.[SU_Status]
      ,main.[SU_IsSysadmin]
      ,main.[SU_create_date]
      ,main.[SU_Last_Update]
      ,main.[SU_End]
      ,main.[SU_Current]
      ,main.[SU_Comment]
      ,co.co
  FROM [SQL_User] main
  left join (select COUNT(1) as co, SU_Server, SU_name
	from [SQL_User]
	where SU_Current = 0  and datetime(SU_End) > datetime('now', '-1 day', 'localtime') and SU_IsSysadmin = 'True' group by SU_Server,SU_Name) as co
  on co.SU_Server = main.SU_Server and co.SU_name = main.SU_name
  where datetime(main.SU_Start) > datetime('now', '-1 day', 'localtime')
  or datetime(main.SU_End) > datetime('now', '-1 day', 'localtime')
  and main.SU_Server not in (select IL_Server from [SQL_User_Ignore_List] where IL_name is null and il_type = 'Sysadmin')
  and not exists (select 1 from [SQL_User_Ignore_List] il where il.il_server = main.SU_Server and il.il_name = main.SU_name and il_type = 'Sysadmin')
  ) q1
  where SU_IsSysadmin = 'True'
  and SU_Current = 1
  order by SU_Server, SU_name, [SU_Current];