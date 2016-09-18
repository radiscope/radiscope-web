Dumping the database schema
===========================

The file `createDb.sql` contains the database schema creation.

Generating the createDb.sql and setupDb.sql out of the database
---------------------------------------------------------------

The `setupDb.sql` file will create all objects (tables, constraints) in an existing `radiscope` database.
The `createDb.sql` file will do the same thing, except that it will create the `radiscope` database first.

In order to generate the above files, these commands should be executed:

    SET PGPASSWORD=@Radiscope // export PGPASSWORD="@Radiscope" on Linux
    
    REM Create the createDb.sql file // not sure how to comment in Linux
    pg_dump --schema-only  -w -C -f createDb.sql -p 5432 -U postgres radiscope
    
    REM Create the setupDb.sql file // not sure how to comment in Linux
    pg_dump --schema-only -w -f setupDb.sql -p 5432 -U postgres radiscope
    
First, make sure that `pg_dump` is on your PATH. On Windows, it's in `C:\Program Files\PostgreSQL\9.5\bin` if you're using PG 9.5

Now, here is the description of the arguments:

- `--schema-only`: Includes only the schema, not the data.
- `-w`: Will not ask for the password. The password is expected to be in the PGPASSWORD env variable or on the `.pgpass` file.
- `-C`: Will include the `create database` command.
- `-f createDb.sql`: Specifies the output file.
- `-p 5432`: Specifies the port. This is the default one.
- `postgres`: The user name.
- `radiscope`: The database name.

Every time the database schema changes, the above script to be executed and the `createDb.sql` and `setupDb.sql` files should be pushed to the repo.