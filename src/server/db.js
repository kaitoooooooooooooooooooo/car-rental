import mongoose from "mongoose";
import { MongoMemoryServer } from "mongodb-memory-server";


let mongodb = null;

const isTest = () => process.env.NODE_ENV === "test";

export async function connectToDatabase() {
    if (isTest()) {
        mongodb = await MongoMemoryServer.create();
        await mongoose.connect(mongodb.getUri());
        console.log("Connected to in-memory database");
        return;
    }

    try {
        await mongoose.connect("mongodb://localhost:27017/car_rental");
        console.log("Connected to database");
    } catch (error) {
        console.error("Error connecting to database", error);
    }
}

export async function disconnectFromDatabase() {
    if (isTest()) {
        await mongoose.connection.dropDatabase();
        await mongoose.connection.close();
        await mongodb.stop();
        mongodb = null;
        console.log("Disconnected from database");
        return;
    }

    await mongoose.disconnect();
    console.log("Disconnected from database");
}

export const PORSCHE_ID = "68a1f0000000000000000101";
export const RANGE_ROVER_ID = "68a1f0000000000000000102";
export const UNKNOWN_ID = "68a1f00000000000000009ff";

export async function prepareDatabase() {
    if (!isTest()) {
        throw new Error("prepareDatabase is only used in test environment");
    }

    await mongoose.connection.collection("cars").insertMany([
        {
            _id: new mongoose.Types.ObjectId(PORSCHE_ID),
            id: 1,
            marque: "Porsche",
            modele: "911 Carrera S",
            annee: 2023,
            categorie: "sport",
            statut: "valide",
            proprietaireId: new mongoose.Types.ObjectId("68a1f0000000000000000001"),
            immatriculation: "BE 145 892",
            description: "Coupé sportif emblématique, boîte PDK 8 rapports.",
            localisation: { ville: "Bienne", canton: "BE", codePostal: "2502", adresse: "Rue de la Gare 24" },
            caracteristiques: { transmission: "automatique", carburant: "essence", places: 4, puissanceCh: 450 },
            equipements: ["gps", "bluetooth"],
            tarifs: { devise: "CHF", jour: 450, semaine: 2700, mois: 9200, caution: 5000 },
            conditions: { ageMinimum: 25, animauxAutorises: false },
            indisponibilites: [{ debut: new Date("2026-09-14T00:00:00.000Z"), fin: new Date("2026-09-20T00:00:00.000Z") }],
            photos: [{ url: "porsche911-a.png", principale: true }],
            note: { moyenne: 4.9, nombreAvis: 27 },
            nombreLocations: 31,
            createdAt: new Date("2026-03-11T09:24:00.000Z"),
            updatedAt: new Date("2026-08-01T09:24:00.000Z"),
        },
        {
            _id: new mongoose.Types.ObjectId(RANGE_ROVER_ID),
            id: 2,
            marque: "Land Rover",
            modele: "Range Rover Sport",
            annee: 2022,
            categorie: "suv",
            statut: "valide",
            proprietaireId: new mongoose.Types.ObjectId("68a1f0000000000000000002"),
            immatriculation: "VD 908 331",
            description: "SUV familial spacieux, quatre roues motrices.",
            localisation: { ville: "Lausanne", canton: "VD", codePostal: "1003", adresse: "Avenue de la Gare 12" },
            caracteristiques: { transmission: "automatique", carburant: "diesel", places: 5, puissanceCh: 300 },
            equipements: ["gps", "camera_recul"],
            tarifs: { devise: "CHF", jour: 260, semaine: 1560, mois: 5400, caution: 3000 },
            conditions: { ageMinimum: 23, animauxAutorises: true },
            indisponibilites: [],
            photos: [{ url: "rangerover-a.png", principale: true }],
            note: { moyenne: 4.6, nombreAvis: 14 },
            nombreLocations: 18,
            createdAt: new Date("2026-04-02T10:00:00.000Z"),
            updatedAt: new Date("2026-08-01T10:00:00.000Z"),
        },
    ]);
}

export async function clearDatabase() {
    if (!isTest()) {
        throw new Error("clearDatabase is only used in test environment");
    }
    await mongoose.connection.collection("cars").deleteMany({});
}
