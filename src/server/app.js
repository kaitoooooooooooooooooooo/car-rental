const express = require('express');
const mongoose = require('mongoose');
const swaggerUI = require('swagger-ui-express');

const CarRoutes = require('./routes/carRoutes');
const swaggerDocument = require("./swagger");

const app = express();
app.use(express.json());

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET");
    next();
});

app.use("/docs", swaggerUI.serve, swaggerUI.setup(swaggerDocument));

app.use("/cars", CarRoutes);

mongoose
    .connect("mongodb://localhost:27017/car_rental")
    .then(result => {
        console.log("server started");
        app.listen(3000);
    }).catch(err => console.log(err));
