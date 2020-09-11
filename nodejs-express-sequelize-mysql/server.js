//Setup Express Web Server

const express = require('express'); //for building the Rest apis
const bodyParser = require('body-parser'); //to parse the request and create the req.body object
const cors = require('cors'); //provides Express middleware to enable CORS with various options
const db = require('./app/models/index'); // inilize database

//create an Express app
const app = express();

var corsOptions = {
    origin: "http://localhost:8081"
};

//add body-parser and cors middlewares using app.use() method
//add cors
app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

//to sync database in server
db.sequelize.sync();

//to drop existing tables and re-sync database. Just use force: true
// db.sequelize.sync({ force: true }).then(() => {
//     console.log("Drop and re-sync db.");
// });

//simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome to node express sequelize CRUD application" });
})

//add route before app.listen
require('./app/routes/tutorial.route')(app);

//set port, listen for requests
const port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
