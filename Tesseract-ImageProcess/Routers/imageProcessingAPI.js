import express from "express";
import multer from "multer"; // middleware for uploading files
import sharp from "sharp";
import fs from "fs/promises";
import os from 'os';
import path from 'path';


import { convertImageToStr } from "../modules/imageProcessing.js";

const router = express.Router();
const upload = multer({ storage: multer.memoryStorage() });


router.post("/translate", upload.single("image"), async (req, res) => {
    try {
        // Check if files were uploaded
        if (!req.file) {
            return res.status(400).json({ message: "Cannot find images in request" });
        }

        // Process the image from buffer using sharp
        const fileBuffer = await sharp(req.file.buffer)
            .resize({ height: 1920, width: 1080, fit: "contain" })
            .normalise() // stretch the image histogram to improve overall contrast
            .ensureAlpha() // removing transparency to ensure alpha channel
            .greyscale() // convert image to grayscale to reduce noise
            .sharpen() // sharpen the image to enhance edges
            .threshold(200) // apply thresholding to make the image more binary
            .toBuffer();

        // Get the path to the system's temporary directory
        // Write the buffer to a temporary file
        const tempFilePath = path.join(os.tmpdir(), req.file.originalname);
        await fs.writeFile(tempFilePath, fileBuffer);

        // Use the temporary file path for the image URL
        const receipt_text = await convertImageToStr(tempFilePath);

        // Remove the temporary file after processing, deallocating
        await fs.unlink(tempFilePath);


        // send a request to CHATGPT to parse the string to json

        const gptResponse = await fetch("http://localhost:3005/api/gpt", {
            method: "POST",
            body: JSON.stringify({
                "receiptString": receipt_text
            })
        });

        const json = await gptResponse.json();

        if (!gptResponse.ok) {
            res.status(400).json({ "message": "gpt is down API is down" });
        } else {
            res.status(200).json(json);
        }

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
});

export default router;
