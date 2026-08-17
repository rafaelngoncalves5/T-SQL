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