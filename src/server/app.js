const express = require("express");
const mongoose = require("mongoose");
const swaggerUI = require("swagger-ui-express");
const dotenv = require("dotenv");

dotenv.config();

const CarRoutes = require("./routes/carRoutes");
const swaggerDocument = require("./swagger");

const app = express();

app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET");
  next();
});

app.use("/docs", swaggerUI.serve, swaggerUI.setup(swaggerDocument));

app.use("/cars", CarRoutes);

if (require.main === module) {
  mongoose
    .connect("mongodb://localhost:27017/car_rental")
    .then(() => {
      console.log("server started");
      app.listen(3000);
    })
    .catch((err) => console.log(err));
}

module.exports = app;
