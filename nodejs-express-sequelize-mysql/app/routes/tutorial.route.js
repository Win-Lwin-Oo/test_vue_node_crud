module.exports = app => {
    const tutorials = require('../controllers/tutorial.controller.js');

    var router = require('express').Router();
    const swaggerUI = require('swagger-ui-express');
    const swaggerJsDocs = require('swagger-jsdoc');
    const swaggerOptions = require('../../swagger.option');

    const swaggerDocs = swaggerJsDocs(swaggerOptions);

    //swagger setup
    router.use('/docs', swaggerUI.serve);
    router.get(
        '/docs',
        swaggerUI.setup(swaggerDocs, {
            explorer: true
        })
    );

    //simple api
    router.get("/welcome", (req, res) => {
        res.json({ message: "Welcome to node express sequelize CRUD application" });
    })

    // Create a new Tutorial
    router.post("/", tutorials.create);

    // Retrieve all Tutorials
    router.get("/", tutorials.findAll);

    // Retrieve all published Tutorials
    router.get("/published", tutorials.findAllPublished);

    // Retrieve a single Tutorial with id
    router.get("/:id", tutorials.findOne);

    // Update a Tutorial with id
    router.put("/:id", tutorials.update);

    // Delete a Tutorial with id
    router.delete("/:id", tutorials.delete);

    // Delete all Tutorials
    router.delete("/", tutorials.deleteAll);

    // define initial/default api call url
    app.use('/api/tutorials', router);
};