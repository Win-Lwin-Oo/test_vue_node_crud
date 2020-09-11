//Initialize Sequelize

const dbConfig = require('../config/db.config');
const Sequelize = require('sequelize');
const sequelize = new Sequelize(dbConfig.db, dbConfig.user, dbConfig.password, {
    host: dbConfig.host,
    dialect: dbConfig.dialect,
    operatorsAliases: false,
    pool: {
        max: dbConfig.pool.max,
        min: dbConfig.pool.min,
        acquire: dbConfig.pool.acquire,
        idle: dbConfig.pool.idle
    }
});

const db = {};
db.Sequelize = Sequelize; // to used Sequelize database sql operator(eg: like) in controller
db.sequelize = sequelize; // to synce database in server.js

// to used Sequelize databse sql method  in controller
db.tutorials = require('../models/tutorial.model')(sequelize,Sequelize);

module.exports = db;