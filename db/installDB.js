const exec = require('child_process');

const selectedCommand = process.env.COMMAND;

const commands = {
    create_dev_dbs: `
        echo ===Creating the radiscope dev db===
        createDb -E UTF8 --lc-collate C --lc-ctype C -U postgres -T template0 radiscope
        echo ===Creating the radiscope_tests dev db===
        createDb -E UTF8 --lc-collate C --lc-ctype C -U postgres -T template0 radiscope_tests
        echo ===Setting up the radiscope dev db===
        psql -f db/setupDb.sql -U postgres -d radiscope
        echo ===Setting up the radiscope_tests dev db===
        psql -f db/setupDb.sql -U postgres -d radiscope_tests
    `,
    drop_dev_dbs: `
        echo ===dropping the radiscope dev db===
        dropdb -U postgres radiscope
        echo ===dropping the radiscope_tests dev db===
        dropdb -U postgres radiscope_tests
    `,
    generate_scripts: `
        echo ===Create the setupDb.sql file===
        pg_dump --schema-only -W -w -f db/setupDb.sql -p 5432 -U postgres radiscope
    `
};

console.log("===Starting DB Command===");
console.log(`Executing ${selectedCommand}`);

commands[selectedCommand].split('\n').forEach(command => {
    console.log(exec.execSync(command).toString());
});



