const express = require("express");
const router = express.Router();

const carController = require("../controller/carController");

router.get("/", carController.getCars);
router.get("/featured", carController.getFeaturedCars);
router.get("/:id", carController.getCarById);
router.get("/:id/location", carController.getCarLocation);

module.exports = router;
