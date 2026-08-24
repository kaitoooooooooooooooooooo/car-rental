const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CarSchema = new Schema({
    id: {
        type: Number,
        required: true,
    },
    marque: {
        type: String,
        required: true,
    },
    modele: {
        type: String,
        required: true,
    },
    annee: {
        type: Number,
        required: true,
    },
    categorie: {
        type: String,
        required: true,
    },
    statut: {
        type: String,
        required: true,
    },
    proprietaireId: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    immatriculation: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    localisation: {
        type: Object,
        required: true,
    },
    caracteristiques: {
        type: Object,
        required: true,
    },
    equipements: {
        type: Array,
        required: true,
    },
    tarifs: {
        type: Object,
        required: true,
    },
    conditions: {
        type: Object,
        required: true,
    },
    indisponibilites: {
        type: Array,
        required: true,
    },
    photos: {
        type: Array,
        required: true,
    },
    note: {
        type: Object,
        required: true,
    },
    nombreLocations: {
        type: Number,
        required: true,
    },
    createdAt: {
        type: Date,
        required: true,
    },
    updatedAt: {
        type: Date,
        required: true,
    },
});

module.exports = mongoose.model("Car", CarSchema);
