SELECT inv.[SDBI_Server] as 'Server'
	  ,inv.[SDBI_name] as 'Database'
	  ,inv.[SDBI_Last_FULL] as 'Last Full'
	  ,inv.[SDBI_Last_DIFF] as 'Last Diff'
FROM [SQL_DB_Inventory] inv
left Join [Prm_Server] list on inv.[SDBI_Server]=list.[serverName]
WHERE inv.SDBI_Current = 1   and inv.SDBI_name not in ('tempdb')  and list.DTQAP ='P'
AND (coalesce(inv.SDBI_Last_FULL, datetime('0001-01-01 00:00:00')) < datetime('now', '-1 day', 'localtime')
AND coalesce(inv.SDBI_Last_DIFF, datetime('0001-01-01 00:00:00')) < datetime('now', '-1 day', 'localtime') and not exists (select 1 from [SQL_DB_Ignore_List] as il where il.il_server = inv.SDBI_Server and il.il_name = inv.SDBI_name and il_type = 'Weekly'))
OR ((inv.SDBI_Server in (select IL_Server from [SQL_DB_Ignore_List] where IL_name = inv.SDBI_name and il_type = 'Weekly') AND coalesce(inv.SDBI_Last_FULL, datetime('0001-01-01 00:00:00')) < datetime('now', '-7 days', 'localtime'))
AND coalesce(inv.SDBI_Last_DIFF, datetime('0001-01-01 00:00:00')) < datetime('now', '-7 days', 'localtime'))
and inv.SDBI_Server not in (select IL_Server from [SQL_DB_Ignore_List] where IL_name is null and il_type = 'Backup')
and not exists (select 1 from [SQL_DB_Ignore_List] il where il.il_server = inv.SDBI_Server and il.il_name = inv.SDBI_name and il_type = 'Backup');