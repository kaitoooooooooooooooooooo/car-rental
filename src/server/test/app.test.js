const supertest = require("supertest");
const mongoose = require("mongoose");
const { MongoMemoryServer } = require("mongodb-memory-server");

const app = require("../app");
const Car = require("../models/car");

const PORSCHE_ID = "68a1f0000000000000000101";
const RANGE_ROVER_ID = "68a1f0000000000000000102";
const UNKNOWN_ID = "68a1f00000000000000009ff";

const cars = [
    {
        _id: PORSCHE_ID,
        id: 1,
        marque: "Porsche",
        modele: "911 Carrera S",
        annee: 2023,
        categorie: "sport",
        statut: "valide",
        proprietaireId: "68a1f0000000000000000001",
        immatriculation: "BE 145 892",
        description: "Coupé sportif emblématique, boîte PDK 8 rapports.",
        localisation: { ville: "Bienne", canton: "BE", codePostal: "2502", adresse: "Rue de la Gare 24" },
        caracteristiques: { transmission: "automatique", carburant: "essence", places: 4, puissanceCh: 450 },
        equipements: ["gps", "bluetooth"],
        tarifs: { devise: "CHF", jour: 450, semaine: 2700, mois: 9200, caution: 5000 },
        conditions: { ageMinimum: 25, animauxAutorises: false },
        indisponibilites: [{ debut: "2026-09-14T00:00:00.000Z", fin: "2026-09-20T00:00:00.000Z" }],
        photos: [{ url: "porsche911-a.png", principale: true }],
        note: { moyenne: 4.9, nombre: 27 },
        nombreLocations: 31,
        createdAt: "2026-03-11T09:24:00.000Z",
        updatedAt: "2026-08-01T09:24:00.000Z",
    },
    {
        _id: RANGE_ROVER_ID,
        id: 2,
        marque: "Land Rover",
        modele: "Range Rover Sport",
        annee: 2022,
        categorie: "suv",
        statut: "valide",
        proprietaireId: "68a1f0000000000000000002",
        immatriculation: "VD 908 331",
        description: "SUV familial spacieux, quatre roues motrices.",
        localisation: { ville: "Lausanne", canton: "VD", codePostal: "1003", adresse: "Avenue de la Gare 12" },
        caracteristiques: { transmission: "automatique", carburant: "diesel", places: 5, puissanceCh: 300 },
        equipements: ["gps", "camera_recul"],
        tarifs: { devise: "CHF", jour: 260, semaine: 1560, mois: 5400, caution: 3000 },
        conditions: { ageMinimum: 23, animauxAutorises: true },
        indisponibilites: [],
        photos: [{ url: "rangerover-a.png", principale: true }],
        note: { moyenne: 4.6, nombre: 14 },
        nombreLocations: 18,
        createdAt: "2026-04-02T10:00:00.000Z",
        updatedAt: "2026-08-01T10:00:00.000Z",
    },
];

let mongodb;

beforeAll(async () => {
    mongodb = await MongoMemoryServer.create();
    await mongoose.connect(mongodb.getUri());
});

afterAll(async () => {
    await mongoose.disconnect();
    await mongodb.stop();
});

describe("GET /cars", () => {
    beforeAll(() => Car.insertMany(cars));
    afterAll(() => Car.deleteMany({}));

    it("should return a list of two cars", async () => {
        const response = await supertest(app).get("/cars").expect(200);

        expect(response.body.length).toBe(2);
    });

    it("should return cars with the expected fields", async () => {
        const response = await supertest(app).get("/cars").expect(200);
        const porsche = response.body.find(car => car.marque === "Porsche");

        expect(porsche.modele).toBe("911 Carrera S");
        expect(porsche.tarifs.jour).toBe(450);
        expect(porsche.localisation.ville).toBe("Bienne");
        expect(porsche.photos.length).toBeGreaterThan(0);
    });

    it("should return json content type", async () => {
        await supertest(app)
            .get("/cars")
            .expect(200)
            .expect("Content-Type", /json/);
    });

    it("should expose CORS headers to the Flutter client", async () => {
        const response = await supertest(app).get("/cars").expect(200);

        expect(response.headers["access-control-allow-origin"]).toBe("*");
    });
});

describe("GET /cars/:id", () => {
    beforeAll(() => Car.insertMany(cars));
    afterAll(() => Car.deleteMany({}));

    it("should return the car matching the given id", async () => {
        const response = await supertest(app).get(`/cars/${RANGE_ROVER_ID}`).expect(200);

        expect(response.body._id).toBe(RANGE_ROVER_ID);
        expect(response.body.marque).toBe("Land Rover");
        expect(response.body.caracteristiques.carburant).toBe("diesel");
    });

    it("should return 400 when the id is not a valid ObjectId", async () => {
        const response = await supertest(app).get("/cars/abc").expect(400);

        expect(response.body.error).toBe("L'id reçu est invalide");
    });

    it("should return 404 when no car matches a valid id", async () => {
        const response = await supertest(app).get(`/cars/${UNKNOWN_ID}`).expect(404);

        expect(response.body.error).toBe("Aucun document trouvé");
    });

    it("should return a car whose dates are serialized in ISO format", async () => {
        const response = await supertest(app).get(`/cars/${PORSCHE_ID}`).expect(200);

        expect(response.body.createdAt).toBe("2026-03-11T09:24:00.000Z");
    });
});

describe("GET /cars with an empty database", () => {
    it("should return an empty list when no car is stored", async () => {
        const response = await supertest(app).get("/cars").expect(200);

        expect(response.body).toEqual([]);
    });
});
