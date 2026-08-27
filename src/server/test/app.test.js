import supertest from "supertest";
import { jest } from "@jest/globals";

import { app } from "../app.js";
import {
    connectToDatabase,
    disconnectFromDatabase,
    prepareDatabase,
    clearDatabase,
    PORSCHE_ID,
    RANGE_ROVER_ID,
    UNKNOWN_ID,
} from "../db.js";

jest.spyOn(console, "log").mockImplementation(() => { });

describe("Car API GET /cars", () => {
    beforeAll(async () => {
        await connectToDatabase();
        await prepareDatabase();
    });

    afterAll(async () => {
        await clearDatabase();
        await disconnectFromDatabase();
    });

    it("should return a list of two Cars", async () => {
        const response = await supertest(app).get("/cars").expect(200);

        expect(response.body.length).toBe(2);
    });

    it("should return cars with the expected fields", async () => {
        const response = await supertest(app).get("/cars").expect(200);
        const porsche = response.body.find((car) => car.marque === "Porsche");

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

describe("Car API GET /cars/:id", () => {
    beforeAll(async () => {
        await connectToDatabase();
        await prepareDatabase();
    });

    afterAll(async () => {
        await clearDatabase();
        await disconnectFromDatabase();
    });

    it("should return the car matching the given id", async () => {
        const response = await supertest(app)
            .get(`/cars/${RANGE_ROVER_ID}`)
            .expect(200);

        expect(response.body._id).toBe(RANGE_ROVER_ID);
        expect(response.body.marque).toBe("Land Rover");
        expect(response.body.caracteristiques.carburant).toBe("diesel");
    });

    it("should return 400 when the id is not a valid ObjectId", async () => {
        const response = await supertest(app).get("/cars/abc").expect(400);

        expect(response.body.error).toBe("L'id reçu est invalide");
    });

    it("should return 404 when no car matches a valid id", async () => {
        const response = await supertest(app)
            .get(`/cars/${UNKNOWN_ID}`)
            .expect(404);

        expect(response.body.error).toBe("Aucun document trouvé");
    });

    it("should return a car whose dates are serialized in ISO format", async () => {
        const response = await supertest(app)
            .get(`/cars/${PORSCHE_ID}`)
            .expect(200);

        expect(response.body.createdAt).toBe("2026-03-11T09:24:00.000Z");
    });
});

describe("Car API - empty database", () => {
    beforeAll(async () => {
        await connectToDatabase();
    });

    afterAll(async () => {
        await disconnectFromDatabase();
    });

    it("should return an empty list when no car is stored", async () => {
        const response = await supertest(app).get("/cars").expect(200);

        expect(response.body).toEqual([]);
    });
});
