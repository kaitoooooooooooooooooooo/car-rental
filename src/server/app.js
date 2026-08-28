import express from "express";
import swaggerUI from "swagger-ui-express";

import CarRoutes from "./routes/carRoutes.js";
import swaggerDocument from "./swagger.js";
import { connectToDatabase, disconnectFromDatabase } from "./db.js";

export const app = express();
app.use(express.json());

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET");
    next();
});

app.use("/docs", swaggerUI.serve, swaggerUI.setup(swaggerDocument));

app.use("/cars", CarRoutes);

if (process.env.NODE_ENV !== "test") {
    await connectToDatabase();
    app.listen(3000, () => {
        console.log("Server running on port 3000");
    });
    process.on("SIGINT", async () => {
        await disconnectFromDatabase();
        process.exit();
    });
}

export default app;
