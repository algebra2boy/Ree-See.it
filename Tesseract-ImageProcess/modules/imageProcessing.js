import { createWorker } from 'tesseract.js';
import path from "path";

const LANGUAGE_FOLDER = path.resolve(process.cwd(), "language");
const IMAGE_FOLDER = path.resolve(process.cwd(), "images");
const IMAGE_URL = path.join(IMAGE_FOLDER, "cvs.png"); // use this for testing

const LANGUAGE = "eng"; // detecting only english words
const OCR_ENGINE_MODE = 1; // OEM
const PSM = 6; // Page Segmentation Modes

// Create worker
const workerGeneration = async () => {
    const worker = await createWorker(LANGUAGE, OCR_ENGINE_MODE, {
        PSM: PSM,
        langPath: LANGUAGE_FOLDER, // use the 4.0 OCR (best accuracy)
    });
    return worker;
}