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
WHERE  EXISTS (
        SELECT jh_job_id
        FROM   (
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
                    AND (jh_step_id = 0 OR JH_Status = 2)
			    ) hist
		    GROUP BY jh_job_id
            ) AS hist2
            LEFT JOIN (select sj_server,sj_job_id,sj_name from [SQL_JOB] group by sj_server, sj_job_id, sj_name) AS job
              ON job.sj_server = hist2.jh_server
              AND job.sj_job_id = hist2.jh_job_id
            WHERE  ( ['0'] ) <> 0
            AND NOT (
	            EXISTS (
                    SELECT IL_Server
                    FROM   SQL_Job_Ignore_List
                    WHERE  il_name IS NULL
                    AND il_type = 'Status'
                    AND il_server = hist2.jh_server
                )
	            OR EXISTS(
                    SELECT il_server
                    FROM   SQL_JOB_IGNORE_LIST
                    WHERE  il_name = job.SJ_Name
                    AND il_type = 'Status'
                    AND il_server = hist2.jh_server
                    AND ( ( [1] / ( [0] + [1] + [3] ) * 100 ) < COALESCE( il_pourcent_ok, 0 ) )
	            )
            )
        ) AS f
         WHERE  f.Job = hist.jh_job_id AND
                f.Server = hist.jh_server
   )
AND datetime(hist.jh_date) > datetime('now', '-1.04 day', 'localtime')
AND jh_step_id <> 0
AND jh_status = 0
GROUP  BY hist.jh_server, job.sj_name, hist.jh_step_name, hist.jh_step_id