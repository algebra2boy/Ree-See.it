import express from "express";
import morgan from "morgan";
import helmet from "helmet";
import cors from "cors";
import expressWinston from "express-winston";
import * as dotenv from 'dotenv';
import logger from "../logs/logger.js";
import imageProcessingAPI from "../Routers/imageProcessingAPI.js"


dotenv.config()  // load environment variables 

const app = express();
const PORT = 3002;

pp.use(helmet());
app.use(cors());
app.use(express.json());

app.use(expressWinston.logger({
    winstonInstance: logger,
    statusLevels: true
}));

app.use("/api/image", imageProcessingAPI);

app.listen(PORT, () => {
    logger.info(`running the server on port ${PORT}`);
});