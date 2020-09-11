module.exports = (sequelize, Sequelize) => {
    const Tutorial = sequelize.define("tutorial", {
        title: {
            type: Sequelize.STRING
        },
        description: {
            type: Sequelize.STRING
        },
        published: {
            type: Sequelize.BOOLEAN
        }
    });

    return Tutorial;
};
/*
This Sequelize Model represents tutorials table in MySQL database.
-> define table name is not have "s" character , 
->but Sequelize create table name is always add "s" character at the end of table define name
These columns will be generated automatically: id, title, description, published, createdAt, updatedAt.
*/