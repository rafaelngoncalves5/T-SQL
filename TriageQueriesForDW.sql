-- Triage queries

-- 1) List all databases with name, ID, and creation date
SELECT name, database_id, create_date
FROM sys.databases;

-- 2) Check users in the db
SELECT * 
FROM sys.database_principals;

-- 2.1) Check users in server
SELECT *
FROM sys.server_principals;

-- 3) -- Role membership
SELECT *
FROM sys.database_role_members;

-- 4) Query pool performance
SELECT *
FROM queryinsights.sql_pool_insights;

-- 5) Long runners
SELECT TOP 5 *
FROM queryinsights.long_running_queries
ORDER BY last_run_total_elapsed_time_ms DESC;

-- 6) View my permissions
SELECT *
FROM fn_my_permissions(NULL, 'Database'); -- Second parameter = scope

-- 7) New metadata sync: Once activated - you can query to check status of last syncing
SELECT *
FROM sys.dm_db_external_tables_log_status;

-- 8) DMVs to identify and kill long-running queries
SELECT *
FROM sys.dm_exec_requests
WHERE status = 'running'
ORDER BY total_elapsed_time DESC;

-- 8.1) You can then grab the session and kill them
KILL 142;

-- 9) Top 10 expensive queries (queryinsights not DMVs - prefix queryinsights, not sys)
SELECT TOP 10 *
FROM queryinsights.exec_requests_history
ORDER BY allocated_cpu_time_ms DESC;

-- 9.1) Top 10 most expensive within last 24 hours
SELECT TOP 10 *
FROM queryinsights.exec_requests_history
WHERE submit_time >= DATEADD(DAY, -1, GETUTCDATE())
ORDER BY allocated_cpu_time_ms DESC;