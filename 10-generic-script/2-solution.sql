-- Generic Script with Variable Substitution for SnowSQL
-- =====================================================
-- snowsql -c demo_conn -f 2-solution.sql -D tenant=HP -D env=PROD
-- see https://medium.com/snowflake/variable-substitution-for-multi-tenant-apps-and-deployment-environments-8d6c0f89d11a

-- have variable substitution ON
!SET VARIABLE_SUBSTITUTION=true;

-- drop local objects
USE ROLE SYSADMIN;
DROP DATABASE IF EXISTS &{tenant}_DB_&{env};
DROP WAREHOUSE IF EXISTS &{tenant}_APP_&{env};

-- create local admin role
USE ROLE SECURITYADMIN;
DROP ROLE IF EXISTS &{tenant}_ADM_&{env};
CREATE ROLE &{tenant}_ADM_&{env};
GRANT ROLE &{tenant}_ADM_&{env} TO ROLE SYSADMIN;

-- create local objects
USE ROLE SYSADMIN;
CREATE DATABASE &{tenant}_DB_&{env};
CREATE SCHEMA &{tenant}_DB_&{env}.&{tenant}_SCH_&{env};
DROP SCHEMA PUBLIC;
CREATE WAREHOUSE &{tenant}_APP_&{env} WAREHOUSE_SIZE = XSMALL;

-- transfer ownership to local admin
USE ROLE SECURITYADMIN;
GRANT OWNERSHIP ON DATABASE &{tenant}_DB_&{env} TO ROLE &{tenant}_ADM_&{env};
GRANT OWNERSHIP ON SCHEMA &{tenant}_DB_&{env}.&{tenant}_SCH_&{env} TO ROLE &{tenant}_ADM_&{env};
GRANT OWNERSHIP ON WAREHOUSE &{tenant}_APP_&{env} TO ROLE &{tenant}_ADM_&{env};

-- create local database roles
USE ROLE &{tenant}_ADM_&{env};
CREATE DATABASE ROLE &{tenant}_APP_&{env};
CREATE DATABASE ROLE &{tenant}_RW_&{env};
CREATE DATABASE ROLE &{tenant}_RO_&{env};
 
-- create the hierarchy of database roles
GRANT DATABASE ROLE &{tenant}_RO_&{env} TO DATABASE ROLE &{tenant}_RW_&{env};
GRANT DATABASE ROLE &{tenant}_RO_&{env} TO DATABASE ROLE &{tenant}_APP_&{env};
GRANT DATABASE ROLE &{tenant}_APP_&{env} TO ROLE &{tenant}_ADM_&{env};

-- grant privileges on local databaae roles
GRANT USAGE ON DATABASE &{tenant}_DB_&{env} TO DATABASE ROLE &{tenant}_RW_&{env};
GRANT USAGE ON DATABASE &{tenant}_DB_&{env} TO DATABASE ROLE &{tenant}_RO_&{env};
 
GRANT USAGE ON SCHEMA &{tenant}_DB_&{env}.&{tenant}_SCH_&{env} TO DATABASE ROLE &{tenant}_RO_&{env};
GRANT USAGE ON SCHEMA &{tenant}_DB_&{env}.&{tenant}_SCH_&{env} TO DATABASE ROLE &{tenant}_RW_&{env};
