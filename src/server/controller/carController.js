const { ObjectId } = require("mongodb");
const Car = require("../models/car");

exports.getCars = (req, res, next) => {
  Car.find()
    .then((cars) => res.status(200).json(cars))
    .catch(next);
};

exports.getFeaturedCars = (req, res, next) => {
  Car.find()
    .sort({ "note.moyenne": -1, "note.nombre": -1 })
    .limit(10)
    .then((cars) => res.status(200).json(cars))
    .catch(next);
};
exports.getCarById = (req, res, next) => {
  if (!ObjectId.isValid(req.params.id)) {
    return res.status(400).json({ error: "L'id reçu est invalide" });
  }

  Car.findOne({ _id: req.params.id })
    .then((car) => {
      if (car == null) {
        return res.status(404).json({ error: "Aucun document trouvé" });
      }
      res.status(200).json(car);
    })
    .catch(next);
};
