-------------------------------------------------------
-- Table Prm_Jobs
-------------------------------------------------------
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Prm_Jobs
CREATE TABLE [Prm_Jobs] (
	[JobId]	integer NOT NULL PRIMARY KEY,
	[JobType]	nvarchar(50) NOT NULL COLLATE NOCASE,
	[JobName]	nvarchar(50) COLLATE NOCASE,
	[JobServeurList]	integer NOT NULL,
	[JobSqlID]	integer NOT NULL,
	[Client]	nvarchar(50) COLLATE NOCASE,
	[Status]	integer DEFAULT 1,
	[Comment]	nvarchar(50) COLLATE NOCASE

);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (1, 'SQL', 'Test SQL', 1, 1, 'YPG', 0, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (6, 'SQL', 'JOBS SQL', 1, 5, 'YPG', 0, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (3, 'SQL', 'INV SQL8+', 3, 2, 'YPG', 1, '');
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (7, 'SQL', 'test FEDB', 5, 6, 'YPG', 0, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (5, 'ORACLE', 'Test Jobs', 4, 4, 'YPG', 0, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (4, 'SQL', 'INV SQL8', 4, 3, 'YPG', 1, '');
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (8, 'SQL', 'List Jobs SQL8+', 3, 7, 'YPG', 1, '');
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (9, 'SQL', 'History SQL', 8, 8, 'YPG', 1, '');
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (11, 'SQL', 'Check DBGROUP', 6, 11, NULL, 0, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (13, 'SQL', 'List User SQL8+', 3, 13, 'YPG', 1, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (14, 'SQL', 'List User SQL 7&8', 7, 14, NULL, 1, NULL);
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (10, 'SQL', 'List JOBs SQL8', 7, 10, 'YPG', 1, '');
INSERT INTO Prm_Jobs (JobId, JobType, JobName, JobServeurList, JobSqlID, Client, Status, Comment) VALUES (12, 'SQL', 'INV SQL7', 9, 12, NULL, 1, NULL);

-- Index: Prm_Jobs_UQ__Prm_Jobs__1273C1CD
CREATE UNIQUE INDEX [Prm_Jobs_UQ__Prm_Jobs__1273C1CD]
ON [Prm_Jobs]
([JobId] DESC);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

-------------------------------------------------------
-- Table Prm_Listes
-------------------------------------------------------

--
-- File generated with SQLiteStudio v3.1.0 on jeu. déc. 1 14:38:01 2016
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Prm_Listes
CREATE TABLE [Prm_Listes] (
	[NoListe]	integer NOT NULL,
	[ServerID]	integer NOT NULL,
	[Comment]	nvarchar(50) COLLATE NOCASE

);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 2, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 3, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 4, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 5, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 6, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 7, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 8, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 9, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 10, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (1, 11, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 12, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 13, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 14, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 15, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 16, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 17, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 18, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 19, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 20, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 21, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 22, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (7, 19, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 25, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 26, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 27, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 28, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 29, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 30, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 32, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 33, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 34, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 35, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 36, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 37, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 38, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 39, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 40, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 41, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 42, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 43, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (2, 44, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (5, 11, 'Only ORACLE-MANAGER');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 2, 'All SQL 8+');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 4, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 5, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 6, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 7, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 8, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 9, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 10, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 11, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 13, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 14, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 15, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 16, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 17, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 18, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 22, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 19, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 25, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 27, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 28, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 29, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 30, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 33, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 34, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 35, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 36, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 38, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 39, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 40, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 41, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 42, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 43, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 44, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (4, 19, 'ALL SQL8');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (4, 21, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (4, 37, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 2, 'ALL SQL -7');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 3, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 4, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 5, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 6, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 7, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 8, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 9, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 10, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 11, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 13, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 14, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 15, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 16, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 17, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 18, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 22, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 21, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 25, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 27, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 28, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 29, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 30, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 33, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 34, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 35, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 36, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 38, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 39, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 40, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 41, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 42, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 43, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 44, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (7, 20, 'SQL8 AND SQL7');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (6, 37, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (7, 21, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (9, 20, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (7, 37, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 2, 'ALL SQL');
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 3, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 4, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 5, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 6, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 7, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 8, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 9, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 10, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 11, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 13, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 14, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 15, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 16, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 17, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 18, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 19, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 20, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 21, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 22, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 45, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 25, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 27, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 28, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 29, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 30, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 33, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 34, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 35, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 36, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 37, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 38, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 39, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 40, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 41, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 42, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 43, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 44, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 45, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 46, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 47, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 48, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 49, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 46, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 47, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 48, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (8, 49, NULL);
INSERT INTO Prm_Listes (NoListe, ServerID, Comment) VALUES (3, 3, NULL);

-- Index: Prm_Listes_IX_Prm_Listes
CREATE UNIQUE INDEX [Prm_Listes_IX_Prm_Listes]
ON [Prm_Listes]
([NoListe] DESC, [ServerID] DESC);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;


-------------------------------------------------------
-- Table Prm_Server
-------------------------------------------------------

PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Prm_Server
CREATE TABLE Prm_Server (ServerID integer NOT NULL PRIMARY KEY, SGBD nvarchar (50) COLLATE NOCASE, serverName nvarchar (50) NOT NULL COLLATE NOCASE, Oracle_Database nvarchar (50) COLLATE NOCASE, Oracle_Port integer, UID integer, OS nvarchar (50) COLLATE NOCASE, DTQAP nvarchar (50) COLLATE NOCASE, Status integer DEFAULT 1, Comment nvarchar (50) COLLATE NOCASE);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (1, 'ORACLE', '172.27.12.194', 'GRID', 1521, 1, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (2, 'SQL', 'MTLEVDDB01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (3, 'SQL', 'MTLSUNDDB01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (4, 'SQL', 'YPGMTLSBSQL02', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (5, 'SQL', 'YPGMTLGRPLTST', NULL, NULL, NULL, NULL, 'T', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (6, 'SQL', 'YPGMTLSQLDEV01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (7, 'SQL', 'YPGMTLMIDLDEV1', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (8, 'SQL', 'YPGMTLHRPSQLDEV01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (9, 'SQL', 'YPGMTLDLTDEV01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (10, 'SQL', 'MTLQAYIDSQL01', NULL, NULL, NULL, NULL, 'QA', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (11, 'SQL', 'ORACLE-MANAGER\SQLEXPRESS', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (13, 'SQL', 'LDCSUNDBPROD01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (14, 'SQL', 'MTLSCCMPROD02', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (15, 'SQL', 'MTLEUCPDB01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (16, 'SQL', 'MTLEVPDB01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (17, 'SQL', 'YPGLDCLEGSQL01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (18, 'SQL', 'MTLVCTRPROD02', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (19, 'SQL8', 'YPGIDSSUNF03', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (20, 'SQL7', 'YPGSQLMETRIC', NULL, NULL, NULL, NULL, 'P', 1, 'inv prob');
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (21, 'SQL8', 'YPGMTLTTRCKDB01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (22, 'SQL', 'MTLEPO02', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (24, 'SQL8', 'YPGMTLGPSHAP01\SHAREPOINT', NULL, NULL, NULL, NULL, 'P', 0, 'Probleme connection');
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (25, 'SQL', 'YPGMTLHRPSQLPRD01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (27, 'SQL', 'YPGMTLGPPRD01\DYNV9_Production', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (28, 'SQL', 'YPGMTLCFOSVM1', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (29, 'SQL', 'YPGMTLSQLPRD01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (30, 'SQL', 'YPGMTLSBSQL01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (33, 'SQL', 'YPGMTLEVOLDB01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (34, 'SQL', 'YPGLDCYIDSQL01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (35, 'SQL', 'YPGLDCYIDSQL02', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (36, 'SQL', 'LDCDLTDBPRD01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (37, 'SQL8', 'SPBBYDYN1', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (38, 'SQL', 'MTLNTAFSTOR01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (39, 'SQL', 'YPGMTLTRACKIT', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (40, 'SQL', 'LDCPCALLRTVRDB1', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (41, 'SQL', 'MTLXNHDB01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (42, 'SQL', 'ldcmctsqlprd01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (43, 'SQL', 'ypgmtlmapprd01\WINTELINFRA', NULL, NULL, NULL, NULL, 'P', 1, 'No SQL Agent installed');
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (44, 'SQL', 'YPGLDCCAPOST01', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (45, 'SQL', 'YPGLDCDTIPRD', NULL, NULL, NULL, NULL, 'P', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (46, 'SQL', 'Mtlbbsqldev01', NULL, NULL, NULL, NULL, 'D', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (47, 'SQL', 'Mtlbbsqlqa01', NULL, NULL, NULL, NULL, 'QA', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (48, 'SQL', 'Mtlbbsqlppd01', NULL, NULL, NULL, NULL, 'PP', 1, NULL);
INSERT INTO Prm_Server (ServerID, SGBD, serverName, Oracle_Database, Oracle_Port, UID, OS, DTQAP, Status, Comment) VALUES (49, 'SQL', 'Ldcbbsqlprd01', NULL, NULL, NULL, NULL, 'P', 1, NULL);

-- Index: Prm_Server_UQ__Prm_Serv__C56AC8871CF15040
CREATE UNIQUE INDEX Prm_Server_UQ__Prm_Serv__C56AC8871CF15040 ON Prm_Server (ServerID DESC);

-- Index: Prm_Server_UQ__Prm_Serv__C56AC8871FCDBCEB
CREATE UNIQUE INDEX Prm_Server_UQ__Prm_Serv__C56AC8871FCDBCEB ON Prm_Server (ServerID DESC);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;



-------------------------------------------------------
-- Table Prm_SqlQueries
-------------------------------------------------------

--
-- File generated with SQLiteStudio v3.1.0 on jeu. déc. 1 14:45:48 2016
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Prm_SqlQueries
CREATE TABLE Prm_SqlQueries (SqlID integer NOT NULL PRIMARY KEY, SqlQuery nvarchar NOT NULL COLLATE NOCASE, SqlName nvarchar (50) COLLATE NOCASE, Comment nvarchar (50) COLLATE NOCASE);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (1, 'select @@SERVERNAME', 'Test SQL', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (2, 'select t.dbid, t.name, t.[Recovery Model], t.Status, t.Collation, t.compatibility_Level ,sum(t.DataFileSizeMB) as DataFileSizeMB ,sum(t.LogFileSizeMB) as LogFileSizeMB ,create_date,Last_FULL_Backup,Last_DIFF_Backup,Last_Log_Backup,last_restore_date  from ( SELECT DB.dbid ,DB.name ,CAST(DATABASEPROPERTYEX(DB.name, ''Recovery'')AS VARCHAR) as [Recovery Model] ,CAST(DATABASEPROPERTYEX(DB.name, ''Status'')AS VARCHAR) as Status  ,CAST(DATABASEPROPERTYEX(DB.name, ''Collation'')AS VARCHAR) as Collation ,DB.cmptlevel as compatibility_Level ,CASE WHEN MF.type = 0 THEN MF.size * 8 / 1024 ELSE 0 END  AS DataFileSizeMB ,CASE WHEN MF.type = 1 THEN MF.size * 8 / 1024 ELSE 0 END AS LogFileSizeMB ,Max(DB.crdate) as create_date ,Max(Case when bus.Type = ''D'' then bus.backup_finish_date else NULL end) AS Last_FULL_Backup ,Max(Case when bus.Type = ''i'' then bus.backup_finish_date else NULL end) AS Last_DIFF_Backup ,Max(Case when bus.Type = ''L'' then bus.backup_finish_date else NULL end) AS Last_Log_Backup ,Max(r.restore_date) as last_restore_date FROM master.dbo.sysdatabases DB LEFT OUTER join master.sys.master_files MF ON DB.dbid = MF.database_id LEFT OUTER JOIN msdb.dbo.backupset bus ON bus.database_name = DB.name LEFT OUTER JOIN msdb.dbo.restorehistory r ON r.destination_database_name = db.Name GROUP BY DB.name, DB.cmptlevel, DB.dbid, MF.type, MF.size ) as t group by t.dbid, t.name, t.[Recovery Model], t.Status, t.Collation, t.compatibility_Level,create_date,Last_FULL_Backup,Last_DIFF_Backup,Last_Log_Backup,last_restore_date', 'Database Info SQL8+', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (3, 'SELECT DB.dbid ,DB.name ,CAST(DATABASEPROPERTYEX(DB.name, ''Recovery'')AS VARCHAR) as [Recovery Model] ,CAST(DATABASEPROPERTYEX(DB.name, ''Status'')AS VARCHAR) as Status ,CAST(DATABASEPROPERTYEX(DB.name, ''Collation'')AS VARCHAR) as Collation ,DB.cmptlevel as compatibility_Level ,NULL  AS DataFileSizeMB ,NULL AS LogFileSizeMB ,Max(DB.crdate) as create_date ,Max(Case when bus.type = ''D'' then bus.backup_finish_date else NULL end) AS Last_FULL_Backup ,Max(Case when bus.type = ''i'' then bus.backup_finish_date else NULL end) AS Last_DIFF_Backup ,Max(Case when bus.type = ''L'' then bus.backup_finish_date else NULL end) AS Last_Log_Backup ,Max(r.restore_date) as last_restore_date FROM master.dbo.sysdatabases DB LEFT OUTER JOIN msdb.dbo.backupset bus ON bus.database_name = DB.name LEFT OUTER JOIN msdb.dbo.restorehistory r ON r.destination_database_name = DB.name GROUP BY DB.name, DB.cmptlevel, DB.dbid', 'Database Info SQL8', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (4, 'select * from v$database', 'Test Oracle', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (5, 'SELECT      [sJOB].[job_id] AS [JobID]     , [sJOB].[name] AS [JobName]     , CASE          WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL         ELSE CAST(                 CAST([sJOBH].[run_date] AS CHAR(8))                 + '' ''                  + STUFF(                     STUFF(RIGHT(''000000'' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)                         , 3, 0, '':'')                     , 6, 0, '':'')                 AS DATETIME)       END AS [LastRunDateTime]     , CASE [sJOBH].[run_status]         WHEN 0 THEN ''Failed''         WHEN 1 THEN ''Succeeded''         WHEN 2 THEN ''Retry''         WHEN 3 THEN ''Canceled''         WHEN 4 THEN ''Running''        END AS [LastRunStatus]     , STUFF(             STUFF(RIGHT(''000000'' + CAST([sJOBH].[run_duration] AS VARCHAR(6)),  6)                 , 3, 0, '':'')             , 6, 0, '':'')          AS [LastRunDuration (HH:MM:SS)]     , [sJOBH].[message] AS [LastRunStatusMessage]     , CASE [sJOBSCH].[NextRunDate]         WHEN 0 THEN NULL         ELSE CAST(                 CAST([sJOBSCH].[NextRunDate] AS CHAR(8))                 + '' ''                  + STUFF(                     STUFF(RIGHT(''000000'' + CAST([sJOBSCH].[NextRunTime] AS VARCHAR(6)),  6)                         , 3, 0, '':'')                     , 6, 0, '':'')                 AS DATETIME)       END AS [NextRunDateTime] 	  , [sJOB].[date_modified] AS [LastDateModified] 	  , [sJOB].[enabled] AS [Enable] 	  ,[sJOBH].[server] AS [Serveur] 	  ,[sJOBH].step_id AS [Step]	 FROM      [msdb].[dbo].[sysjobs] AS [sJOB]     INNER JOIN (                 SELECT                     [job_id]                     , MIN([next_run_date]) AS [NextRunDate]                     , MIN([next_run_time]) AS [NextRunTime]                 FROM [msdb].[dbo].[sysjobschedules]                 GROUP BY [job_id]             ) AS [sJOBSCH]         ON [sJOB].[job_id] = [sJOBSCH].[job_id]     INNER JOIN (                 SELECT                      [job_id]                     , [run_date]                     , [run_time]                     , [run_status]                     , [run_duration]                     , [message] 					,[server] 					,[step_id]                     , ROW_NUMBER() OVER (                                             PARTITION BY [job_id]                                              ORDER BY [run_date] DESC, [run_time] DESC                       ) AS RowNumber                 FROM [msdb].[dbo].[sysjobhistory]                          ) AS [sJOBH]         ON [sJOB].[job_id] = [sJOBH].[job_id]  		 AND run_date >= CONVERT(CHAR(8), (SELECT DATEADD (DAY,(-1), GETDATE())), 112)  ORDER BY [JobName] ', 'SQL JOB', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (6, 'EXEC sp_MSforeachdb ''USE ? SELECT ''''?'''', * FROM sys.sysfiles SF''', 'TEST FEDB', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (7, 'SELECT   msdb.dbo.sysjobs.job_id,   msdb.dbo.sysjobs.name,   msdb.dbo.sysjobs.enabled,   msdb.dbo.sysjobs.description,   msdb.dbo.sysjobs.start_step_id,   master.dbo.syslogins.name,   msdb.dbo.sysjobs.date_created,   msdb.dbo.sysjobs.date_modified,   msdb.dbo.sysjobs.version_number,   msdb.dbo.sysjobschedules.schedule_id,   msdb.dbo.sysjobschedules.next_run_date,   msdb.dbo.sysjobschedules.next_run_time,   msdb.dbo.sysschedules.enabled,   msdb.dbo.sysschedules.schedule_id,   msdb.dbo.sysschedules.date_created,   msdb.dbo.sysschedules.date_modified,   CASE     WHEN msdb.dbo.sysschedules.freq_type = 0x1 THEN ''Once on '' + CONVERT(char(10), CAST(CAST(msdb.dbo.sysschedules.active_start_date AS varchar) AS datetime), 102)     WHEN msdb.dbo.sysschedules.freq_type = 0x4 THEN ''Daily''     WHEN msdb.dbo.sysschedules.freq_type = 0x8 THEN CASE         WHEN msdb.dbo.sysschedules.freq_recurrence_factor = 1 THEN ''Weekly on ''         WHEN msdb.dbo.sysschedules.freq_recurrence_factor > 1 THEN ''Every '' + CAST(msdb.dbo.sysschedules.freq_recurrence_factor AS varchar) + '' weeks on ''       END + LEFT(CASE         WHEN msdb.dbo.sysschedules.freq_interval & 1 = 1 THEN ''Sunday, ''         ELSE ''''       END +            CASE              WHEN msdb.dbo.sysschedules.freq_interval & 2 = 2 THEN ''Monday, ''              ELSE ''''            END +                 CASE                   WHEN msdb.dbo.sysschedules.freq_interval & 4 = 4 THEN ''Tuesday, ''                   ELSE ''''                 END +                      CASE                        WHEN msdb.dbo.sysschedules.freq_interval & 8 = 8 THEN ''Wednesday, ''                        ELSE ''''                      END +                           CASE                             WHEN msdb.dbo.sysschedules.freq_interval & 16 = 16 THEN ''Thursday, ''                             ELSE ''''                           END +                                CASE                                  WHEN msdb.dbo.sysschedules.freq_interval & 32 = 32 THEN ''Friday, ''                                  ELSE ''''                                END +                                     CASE                                       WHEN msdb.dbo.sysschedules.freq_interval & 64 = 64 THEN ''Saturday, ''                                       ELSE ''''                                     END, LEN(CASE         WHEN msdb.dbo.sysschedules.freq_interval & 1 = 1 THEN ''Sunday, ''         ELSE ''''       END +            CASE              WHEN msdb.dbo.sysschedules.freq_interval & 2 = 2 THEN ''Monday, ''              ELSE ''''            END +                 CASE                   WHEN msdb.dbo.sysschedules.freq_interval & 4 = 4 THEN ''Tuesday, ''                   ELSE ''''                 END +                      CASE                        WHEN msdb.dbo.sysschedules.freq_interval & 8 = 8 THEN ''Wednesday, ''                        ELSE ''''                      END +                           CASE                             WHEN msdb.dbo.sysschedules.freq_interval & 16 = 16 THEN ''Thursday, ''                             ELSE ''''                           END +                                CASE                                  WHEN msdb.dbo.sysschedules.freq_interval & 32 = 32 THEN ''Friday, ''                                  ELSE ''''                                END +                                     CASE                                       WHEN msdb.dbo.sysschedules.freq_interval & 64 = 64 THEN ''Saturday, ''                                       ELSE ''''                                     END) - 1)     WHEN msdb.dbo.sysschedules.freq_type = 0x10 THEN CASE         WHEN msdb.dbo.sysschedules.freq_recurrence_factor = 1 THEN ''Monthly on the ''         WHEN msdb.dbo.sysschedules.freq_recurrence_factor > 1 THEN ''Every '' + CAST(msdb.dbo.sysschedules.freq_recurrence_factor AS varchar) + '' months on the ''       END + CAST(msdb.dbo.sysschedules.freq_interval AS varchar) + CASE         WHEN msdb.dbo.sysschedules.freq_interval IN (1, 21, 31) THEN ''st''         WHEN msdb.dbo.sysschedules.freq_interval IN (2, 22) THEN ''nd''         WHEN msdb.dbo.sysschedules.freq_interval IN (3, 23) THEN ''rd''         ELSE ''th''       END     WHEN msdb.dbo.sysschedules.freq_type = 0x20 THEN CASE         WHEN msdb.dbo.sysschedules.freq_recurrence_factor = 1 THEN ''Monthly on the ''         WHEN msdb.dbo.sysschedules.freq_recurrence_factor > 1 THEN ''Every '' + CAST(msdb.dbo.sysschedules.freq_recurrence_factor AS varchar) + '' months on the ''       END + CASE msdb.dbo.sysschedules.freq_relative_interval         WHEN 0x01 THEN ''first ''         WHEN 0x02 THEN ''second ''         WHEN 0x04 THEN ''third ''         WHEN 0x08 THEN ''fourth ''         WHEN 0x10 THEN ''last ''       END + CASE msdb.dbo.sysschedules.freq_interval         WHEN 1 THEN ''Sunday''         WHEN 2 THEN ''Monday''         WHEN 3 THEN ''Tuesday''         WHEN 4 THEN ''Wednesday''         WHEN 5 THEN ''Thursday''         WHEN 6 THEN ''Friday''         WHEN 7 THEN ''Saturday''         WHEN 8 THEN ''day''         WHEN 9 THEN ''week day''         WHEN 10 THEN ''weekend day''       END     WHEN msdb.dbo.sysschedules.freq_type = 0x40 THEN ''Automatically starts when SQLServerAgent starts.''     WHEN msdb.dbo.sysschedules.freq_type = 0x80 THEN ''Starts whenever the CPUs become idle''     ELSE NULL   END + CASE     WHEN msdb.dbo.sysschedules.freq_subday_type = 0x1 OR       msdb.dbo.sysschedules.freq_type = 0x1 THEN '' at '' + CASE         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 = 0 THEN ''12'' + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 10 THEN CONVERT(char(1), (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 12 THEN CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 22 THEN CONVERT(char(1), ((msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100) + '' PM''         ELSE CONVERT(char(2), ((msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100) + '' PM''       END     WHEN msdb.dbo.sysschedules.freq_subday_type IN (0x2, 0x4, 0x8) THEN '' every '' + CAST(msdb.dbo.sysschedules.freq_subday_interval AS varchar) + CASE freq_subday_type         WHEN 0x2 THEN '' second''         WHEN 0x4 THEN '' minute''         WHEN 0x8 THEN '' hour''       END + CASE         WHEN msdb.dbo.sysschedules.freq_subday_interval > 1 THEN ''s''         ELSE ''''       END     ELSE ''''   END + CASE     WHEN msdb.dbo.sysschedules.freq_subday_type IN (0x2, 0x4, 0x8) THEN '' between '' + CASE         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 = 0 THEN ''12'' + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 10 THEN CONVERT(char(1), (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 12 THEN CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_start_time % 1000000) / 10000 < 22 THEN CONVERT(char(1), ((msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100)) + '' PM''         ELSE CONVERT(char(2), ((msdb.dbo.sysschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_start_time % 10000) / 100)) + '' PM''       END + '' and '' + CASE         WHEN (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000 = 0 THEN ''12'' + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000 < 10 THEN CONVERT(char(1), (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000 < 12 THEN CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100)) + '' AM''         WHEN (msdb.dbo.sysschedules.active_end_time % 1000000) / 10000 < 22 THEN CONVERT(char(1), ((msdb.dbo.sysschedules.active_end_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100)) + '' PM''         ELSE CONVERT(char(2), ((msdb.dbo.sysschedules.active_end_time % 1000000) / 10000) - 12) + '':'' + REPLICATE(''0'', 2 - LEN(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100))) + RTRIM(CONVERT(char(2), (msdb.dbo.sysschedules.active_end_time % 10000) / 100)) + '' PM''       END     ELSE ''''   END AS Schedule FROM msdb.dbo.sysjobs LEFT outer JOIN msdb.dbo.sysjobschedules   ON msdb.dbo.sysjobs.job_id = msdb.dbo.sysjobschedules.job_id LEFT outer JOIN msdb.dbo.sysschedules   ON msdb.dbo.sysjobschedules.schedule_id = msdb.dbo.sysschedules.schedule_id LEFT JOIN master.dbo.syslogins   ON master.dbo.syslogins.sid = msdb.dbo.sysjobs.owner_sid', 'Job list', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (8, 'select job_id, step_id, step_name, run_status, sql_message_id, sql_severity, replace(replace(message,char(10),''''),char(13),''''), run_date, run_time, run_duration, retries_attempted from msdb.dbo.sysjobhistory where run_date > CONVERT(char(10), GetDate() -7 ,112)', 'SQL Job Hist', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (10, 'select msdb.dbo.sysjobs.job_id, msdb.dbo.sysjobs.name, msdb.dbo.sysjobs.enabled, msdb.dbo.sysjobs.description, msdb.dbo.sysjobs.start_step_id, master.dbo.syslogins.name, msdb.dbo.sysjobs.date_created, msdb.dbo.sysjobs.date_modified, msdb.dbo.sysjobs.version_number, msdb.dbo.sysjobschedules.schedule_id, msdb.dbo.sysjobschedules.next_run_date, msdb.dbo.sysjobschedules.next_run_time, msdb.dbo.sysjobschedules.enabled, msdb.dbo.sysjobschedules.schedule_id, msdb.dbo.sysjobschedules.date_created, null as ''mod'', case when msdb.dbo.sysjobschedules.freq_type = 0x1 then ''once on '' + convert(char(10), cast(cast(msdb.dbo.sysjobschedules.active_start_date as varchar) as datetime), 102) when msdb.dbo.sysjobschedules.freq_type = 0x4 then ''daily'' when msdb.dbo.sysjobschedules.freq_type = 0x8 then case when msdb.dbo.sysjobschedules.freq_recurrence_factor = 1 then ''weekly on '' when msdb.dbo.sysjobschedules.freq_recurrence_factor > 1 then ''every '' + cast(msdb.dbo.sysjobschedules.freq_recurrence_factor as varchar) + '' weeks on '' end + left(case when msdb.dbo.sysjobschedules.freq_interval & 1 = 1 then ''sunday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 2 = 2 then ''monday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 4 = 4 then ''tuesday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 8 = 8 then ''wednesday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 16 = 16 then ''thursday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 32 = 32 then ''friday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 64 = 64 then ''saturday, '' else '''' end, len(case when msdb.dbo.sysjobschedules.freq_interval & 1 = 1 then ''sunday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 2 = 2 then ''monday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 4 = 4 then ''tuesday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 8 = 8 then ''wednesday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 16 = 16 then ''thursday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 32 = 32 then ''friday, '' else '''' end + case when msdb.dbo.sysjobschedules.freq_interval & 64 = 64 then ''saturday, '' else '''' end) - 1) when msdb.dbo.sysjobschedules.freq_type = 0x10 then case when msdb.dbo.sysjobschedules.freq_recurrence_factor = 1 then ''monthly on the '' when msdb.dbo.sysjobschedules.freq_recurrence_factor > 1 then ''every '' + cast(msdb.dbo.sysjobschedules.freq_recurrence_factor as varchar) + '' months on the '' end + cast(msdb.dbo.sysjobschedules.freq_interval as varchar) + case when msdb.dbo.sysjobschedules.freq_interval in (1, 21, 31) then ''st'' when msdb.dbo.sysjobschedules.freq_interval in (2, 22) then ''nd'' when msdb.dbo.sysjobschedules.freq_interval in (3, 23) then ''rd'' else ''th'' end when msdb.dbo.sysjobschedules.freq_type = 0x20 then case when msdb.dbo.sysjobschedules.freq_recurrence_factor = 1 then ''monthly on the '' when msdb.dbo.sysjobschedules.freq_recurrence_factor > 1 then ''every '' + cast(msdb.dbo.sysjobschedules.freq_recurrence_factor as varchar) + '' months on the '' end + case msdb.dbo.sysjobschedules.freq_relative_interval when 0x01 then ''first '' when 0x02 then ''second '' when 0x04 then ''third '' when 0x08 then ''fourth '' when 0x10 then ''last '' end + case msdb.dbo.sysjobschedules.freq_interval when 1 then ''sunday'' when 2 then ''monday'' when 3 then ''tuesday'' when 4 then ''wednesday'' when 5 then ''thursday'' when 6 then ''friday'' when 7 then ''saturday'' when 8 then ''day'' when 9 then ''week day'' when 10 then ''weekend day'' end when msdb.dbo.sysjobschedules.freq_type = 0x40 then ''automatically starts when sqlserveragent starts.'' when msdb.dbo.sysjobschedules.freq_type = 0x80 then ''starts whenever the cpus become idle'' else null end + case when msdb.dbo.sysjobschedules.freq_subday_type = 0x1 or msdb.dbo.sysjobschedules.freq_type = 0x1 then '' at '' + case when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 = 0 then ''12'' + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 10 then convert(char(1), (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 12 then convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 22 then convert(char(1), ((msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100) + '' pm'' else convert(char(2), ((msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100) + '' pm'' end when msdb.dbo.sysjobschedules.freq_subday_type in (0x2, 0x4, 0x8) then '' every '' + cast(msdb.dbo.sysjobschedules.freq_subday_interval as varchar) + case freq_subday_type when 0x2 then '' second'' when 0x4 then '' minute'' when 0x8 then '' hour'' end + case when msdb.dbo.sysjobschedules.freq_subday_interval > 1 then ''s'' else '''' end else '''' end + case when msdb.dbo.sysjobschedules.freq_subday_type in (0x2, 0x4, 0x8) then '' between '' + case when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 = 0 then ''12'' + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 10 then convert(char(1), (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 12 then convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000 < 22 then convert(char(1), ((msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100)) + '' pm'' else convert(char(2), ((msdb.dbo.sysjobschedules.active_start_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_start_time % 10000) / 100)) + '' pm'' end + '' and '' + case when (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000 = 0 then ''12'' + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000 < 10 then convert(char(1), (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000 < 12 then convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100)) + '' am'' when (msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000 < 22 then convert(char(1), ((msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100)) + '' pm'' else convert(char(2), ((msdb.dbo.sysjobschedules.active_end_time % 1000000) / 10000) - 12) + '':'' + replicate(''0'', 2 - len(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100))) + rtrim(convert(char(2), (msdb.dbo.sysjobschedules.active_end_time % 10000) / 100)) + '' pm'' end else '''' end as schedule from msdb.dbo.sysjobs left outer join msdb.dbo.sysjobschedules on msdb.dbo.sysjobs.job_id = msdb.dbo.sysjobschedules.job_id left join master.dbo.syslogins on master.dbo.syslogins.sid = msdb.dbo.sysjobs.owner_sid ', 'SQL8 JOB list', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (11, 'SELECT Count( 1 ) from sys.SYSLOGINS s  WHERE  s.sysadmin = 1 AND s.name = ''YPG\DBGROUP'' ', 'Checkc dbgroup', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (12, 'SELECT db.dbid, db.name, ''n/a'' AS [Recovery Model], db.status AS Status, ''n/a'' AS Collation, db.cmptlevel AS compatibility_Level, NULL AS DataFileSizeMB, NULL AS LogFileSizeMB, Max( db.crdate ) AS create_date, Max( CASE WHEN bus.type = ''D'' THEN bus.backup_finish_date ELSE NULL END ) AS Last_FULL_Backup, Max( CASE WHEN bus.type = ''i'' THEN bus.backup_finish_date ELSE NULL END ) AS Last_DIFF_Backup, Max( CASE WHEN bus.type = ''L'' THEN bus.backup_finish_date ELSE NULL END ) AS Last_Log_Backup, Max( r.restore_date ) AS last_restore_date FROM master.dbo.sysdatabases db LEFT OUTER JOIN msdb.dbo.backupset bus ON bus.database_name = db.name LEFT OUTER JOIN msdb.dbo.restorehistory r ON r.destination_database_name = db.name GROUP BY db.name,db.cmptlevel,db.dbid, db.status ', 'SQL7 inv', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (13, 'SELECT name, principal_id,default_database_name, type_desc, isSysadmin = CASE WHEN IS_SRVROLEMEMBER (''sysadmin'',name)= 1 THEN ''True'' ELSE ''False'' END , isServeradmin = CASE WHEN IS_SRVROLEMEMBER (''serveradmin'',name)= 1 THEN ''True'' ELSE ''False'' END ,isProcessadmin = CASE WHEN IS_SRVROLEMEMBER (''processadmin'',name)= 1 THEN ''True'' ELSE ''False'' END,isSecurityadmin = CASE WHEN IS_SRVROLEMEMBER (''securityadmin'',name)= 1 THEN ''True'' ELSE ''False'' END,isSetupadmin = CASE WHEN IS_SRVROLEMEMBER (''setupadmin'',name)= 1 THEN ''True'' ELSE ''False'' END,isDiskadmin = CASE WHEN IS_SRVROLEMEMBER (''diskadmin'',name)= 1 THEN ''True'' ELSE ''False'' END,isBulkadmin = CASE WHEN IS_SRVROLEMEMBER (''bulkadmin'',name)= 1 THEN ''True'' ELSE ''False'' END,isDbcreator = CASE WHEN IS_SRVROLEMEMBER (''dbcreator'',name)= 1 THEN ''True'' ELSE ''False'' END ,status = CASE WHEN is_disabled = 1 THEN ''Disabled'' ELSE ''Enabled'' END, create_date, modify_date FROM master.sys.server_principals WHERE type_desc NOT IN (''SERVER_ROLE'', ''CERTIFICATE_MAPPED_LOGIN'') AND name NOT LIKE ''##%'' ORDER BY name;', 'SQL8+ User List', NULL);
INSERT INTO Prm_SqlQueries (SqlID, SqlQuery, SqlName, Comment) VALUES (14, 'SELECT o.loginname as name, N''principal_id'' = convert(int, suser_sid(o.name)),o.dbname as default_database_name, type_desc = CASE WHEN o.isntgroup = 1 THEN ''GROUP'' ELSE ''LOGIN'' END, isSysadmin = CASE WHEN o.sysadmin = 1 THEN ''True'' ELSE ''False'' END , isServeradmin = CASE WHEN o.serveradmin = 1 THEN ''True'' ELSE ''False'' END ,isProcessadmin = CASE WHEN o.processadmin = 1 THEN ''True'' ELSE ''False'' END,isSecurityadmin = CASE WHEN o.securityadmin = 1 THEN ''True'' ELSE ''False'' END,isSetupadmin = CASE WHEN o.setupadmin = 1 THEN ''True'' ELSE ''False'' END,isDiskadmin = CASE WHEN o.diskadmin = 1 THEN ''True'' ELSE ''False'' END,isBulkadmin = ''False'',isDbcreator = CASE WHEN o.dbcreator = 1 THEN ''True'' ELSE ''False'' END ,status = CASE WHEN denylogin = 1 THEN ''Disabled'' ELSE ''Enabled'' END, o.createdate as create_date, o.updatedate as modify_date from master.dbo.syslogins o, master.dbo.syslanguages l where (o.language like l.alias or o.language like l.name)  union select o.loginname as username, N''principal_id'' = convert(int, suser_sid(o.name)),o.dbname as default_database_name, type_desc = CASE WHEN o.isntgroup = 1 THEN ''GROUP'' ELSE ''LOGIN'' END, isSysadmin = CASE WHEN o.sysadmin = 1 THEN ''True'' ELSE ''False'' END , isServeradmin = CASE WHEN o.serveradmin = 1 THEN ''True'' ELSE ''False'' END ,isProcessadmin = CASE WHEN o.processadmin = 1 THEN ''True'' ELSE ''False'' END, isSecurityadmin = CASE WHEN o.securityadmin = 1 THEN ''True'' ELSE ''False'' END,isSetupadmin = CASE WHEN o.setupadmin = 1 THEN ''True'' ELSE ''False'' END,isDiskadmin = CASE WHEN o.diskadmin = 1 THEN ''True'' ELSE ''False'' END,isBulkadmin = ''False'',isDbcreator = CASE WHEN o.dbcreator = 1 THEN ''True'' ELSE ''False'' END ,status = CASE WHEN denylogin = 1 THEN ''Disabled'' ELSE ''Enabled'' END, o.createdate as create_date, o.updatedate as modify_date from master.dbo.syslogins o, master.dbo.syslanguages l where o.language is NULL and l.langid = @@default_langid order by o.loginname ', 'SQL 7&8 User', NULL);

-- Index: Prm_SqlQueries_UQ__Prm_SqlQueries__164452B1
CREATE UNIQUE INDEX Prm_SqlQueries_UQ__Prm_SqlQueries__164452B1 ON Prm_SqlQueries (SqlID DESC);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;


-------------------------------------------------------
-- Table Prm_User
-------------------------------------------------------

--
-- File generated with SQLiteStudio v3.1.0 on jeu. déc. 1 14:46:15 2016
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Prm_User
CREATE TABLE Prm_User (UserID integer NOT NULL PRIMARY KEY, userName nvarchar (50) NOT NULL COLLATE NOCASE, userPass nvarchar (50) NOT NULL COLLATE NOCASE, Comment nvarchar (50) COLLATE NOCASE);
INSERT INTO Prm_User (UserID, userName, userPass, Comment) VALUES (1, 'baduser', 'badpass', NULL);

-- Index: Prm_User_UQ__Prm_User__182C9B23
CREATE UNIQUE INDEX Prm_User_UQ__Prm_User__182C9B23 ON Prm_User (UserID DESC);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;

