Dumping the database schema
===========================

The file `createDb.sql` contains the database schema creation.

Generating the createDb.sql out of the database
-----------------------------------------------

In order to generate the `createDb.sql` file, this command should be executed:

    pg_dump --schema-only -C -f createDb.sql -p 5432 -U postgres radiscope
    
First, make sure that `pg_dump` is on your PATH. On Windows, it's in `C:\Program Files\PostgreSQL\9.5\bin` if you're using PG 9.5

Now, here is the description of the arguments:

- `--schema-only`: Includes only the schema, not the data.
- `-C`: Will include the `create database` command.
- `-f createDb.sql`: Specifies the output file.
- `-p 5432`: Specifies the port. This is the default one.
- `postgres`: The user name.
- `radiscope`: The database name.

The above script will ask you the `postgres` password before it's completed.