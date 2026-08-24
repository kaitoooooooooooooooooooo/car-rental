const Car = require("../models/car");
const { ObjectId } = require("mongodb");

exports.getCars = (req, res, next) => {
    Car.find().then(result => res.status(200).json(result));
};

exports.getCarById = (req, res, next) => {
    if(ObjectId.isValid(req.params.id)){
        Car.findOne({_id: req.params.id})
        .then(car => {
            if(car != null){
                res.status(200).json(car)
            }else{
                res.status(500).json({error: "Aucun document trouvé"});
            }
        })
    }else{
        res.status(500).json({error: "L'id reçu est invalide"})
    }
};
