const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const connection = require('./src/database');

app.route('/config')
    .get(function (req, res, next) {
        res.json({
            host: process.env.DB_HOST,
            databasae: process.env.DB_DATABASE
        })
    });

app.route('/showdatabases')
    .get(function (req, res, next) {
        let mysql = require('mysql');

        let newConnection = mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASS
        });

        newConnection.connect(function (err) {
            if (err) {
                console.error('Error connecting: ' + err.stack);
                return;
            }
            console.log('Connected as thread id: ' + newConnection.threadId);

            newConnection.query(
                "SHOW DATABASES;", {},
                function (error, results, fields) {
                    if (error) throw error;
                    res.json(results);
                }
            );
        });
    });

app.route('/showdatabases/:hostname/:user/:password')
    .get(function (req, res, next) {
        let mysql = require('mysql');

        let newConnection = mysql.createConnection({
            host: req.params.hostname,
            user: req.params.user,
            password: req.params.password
        });

        newConnection.connect(function (err) {
            if (err) {
                console.error('Error connecting: ' + err.stack);
                return;
            }
            console.log('Connected as thread id: ' + newConnection.threadId);

            newConnection.query(
                "SHOW DATABASES;", {},
                function (error, results, fields) {
                    if (error) throw error;
                    res.json(results);
                }
            );
        });

    });

app.get('/', (req, res) => res.send('Working!'));
app.get('/status', (req, res) => res.send('Working!'));

app.listen(8080, () => console.log('App listening on port 8080!'));