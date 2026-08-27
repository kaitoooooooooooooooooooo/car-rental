import mongoose from "mongoose";

import Car from "../models/car.js";

export const getCars = async (req, res, next) => {
    try {
        const cars = await Car.find();
        res.status(200).json(cars);
    } catch (error) {
        next(error);
    }
};

export const getCarById = async (req, res, next) => {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
        return res.status(400).json({ error: "L'id reçu est invalide" });
    }

    try {
        const car = await Car.findOne({ _id: req.params.id });

        if (car == null) {
            return res.status(404).json({ error: "Aucun document trouvé" });
        }

        res.status(200).json(car);
    } catch (error) {
        next(error);
    }
};
