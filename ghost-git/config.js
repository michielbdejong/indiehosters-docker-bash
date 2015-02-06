// # Ghost Configuration
// Setup your Ghost install for various environments
// Documentation can be found at http://support.ghost.org/config/

var path = require('path'),
    fs = require('fs'),
    config;

config = {
    // ### Production
    // When running Ghost in the wild, use the production environment
    // Configure your URL and mail settings here
    production: {
        url: 'https://'+fs.readFileSync('/data/hostname'),
        mail: {},
        database: {
            client: 'sqlite3',
            connection: {
                filename: '/data/ghost.db'
            },
            debug: false
        },

        server: {
            // Host to be passed to node's `net.Server#listen()`
            host: '127.0.0.1',
            // Port to be passed to node's `net.Server#listen()`, for iisnode set this to `process.env.PORT`
            port: '80'
        }
    }
};

// Export config
module.exports = config;
