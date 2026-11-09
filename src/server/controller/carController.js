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

exports.getCarLocation = (req, res, next) => {
  if (!ObjectId.isValid(req.params.id)) {
    return res.status(400).json({ error: "L'id reçu est invalide" });
  }

  const apiKey = process.env.GOOGLE_MAPS_API_KEY;
  if (!apiKey) {
    return res.status(500).json({ error: "Clé API manquante" });
  }

  Car.findOne({ _id: req.params.id })
    .then((car) => {
      if (car == null) {
        return res.status(404).json({ error: "Aucun document trouvé" });
      }

      const { adresse, codePostal, ville, canton } = car.localisation;
      const address = `${adresse}, ${codePostal} ${ville}, ${canton}, Suisse`;
      const params = new URLSearchParams({ address: address, key: apiKey });

      return fetch(`https://maps.googleapis.com/maps/api/geocode/json?${params}`)
        .then((response) => response.json())
        .then((result) => {
          if (result.status !== "OK") {
            return res.status(400).json({ error: result.error_message ?? result.status });
          }
          res.status(200).json(result.results[0].geometry.location);
        });
    })
    .catch(next);
};
