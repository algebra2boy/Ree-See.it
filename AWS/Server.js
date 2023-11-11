import express from "express";

import multer from "multer";
import sharp from "sharp"; // modify the image by resizing the image
import crypto from 'crypto'; // use this to generate random unique names
import morgan from "morgan";

import { getObjectSignedUrl, uploadFile, deleteFile } from "./S3Client.js";

const app = express();
app.use(morgan("dev"));

// set up storage to store images
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

const generateFileName = (bytes = 32) => crypto.randomBytes(bytes).toString('hex');

app.get("/api/posts/:imageName", async (req, res) =>
{
    const imageName = req.params.imageName
    if (!imageName)
    {
        res.status(404).json({ "message": "Failure" });
    }

    // use the random generated image name to get the url from Amazon AWS
    const imageUrlFromAWS_S3 = await getObjectSignedUrl(imageName);
    res.status(200).json({ "imageUrl": imageUrlFromAWS_S3 });
});

app.post("/api/posts", upload.single("image"), async (req, res) =>
{
    const file = req.file; // Multer object file
    const imageName = generateFileName();

    // write to the file to the buffer
    // image is stored in memory as a buffer.
    const fileBuffer = await sharp(file.buffer)
        .resize({ height: 1920, width: 1080, fit: "contain" })
        .toBuffer();

    // upload the file to the AWS
    await uploadFile(fileBuffer, imageName, file.mimetype);

    // send a request to get the image url on the AWS server
    const response = await fetch(`http://localhost:3003/api/posts/${imageName}`);
    const json = await response.json();

    if (response.ok)
    {
        res.send({
            "message": "successfully upload the image to AWS server",
            "imageUrl": json["imageUrl"],
            "imageName": imageName
        });
    }
    else {
        res.send(json);
    }
});

app.delete("/api/posts:imageName", async (req, res) =>
{
    const imageName = req.params.imageName
    if (!imageName)
    {
        res.status(404).json({ "message": "Failure" });
    }

    const response = await deleteFile(imageName);
    
    if (response.DeleteMarker)
    {
        res.send({
            "message": "Successfully deleted the image from AWS server",
            "Object": response
        });
    }
    else {
        res.send(response);
    }
});

app.listen(3003, () => console.log("the app listens on port 3003"));
