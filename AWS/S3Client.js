import { S3Client, PutObjectCommand, GetObjectCommand, DeleteObjectCommand } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";

import dotenv from "dotenv"; // load env variables

dotenv.config();

// a list of important AWS credentials to set up S3
const bucketName = process.env.AWS_BUCKET_NAME;
const region = process.env.AWS_BUCKET_REGION; // The AWS region to which this client will send requests

// The credentials used to sign requests.
const accessKeyId = process.env.AWS_ACCESS_KEY;
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

// esbtalish s3 client connection
const s3Client = new S3Client(
{
    region,
    credentials: {
        accessKeyId,
        secretAccessKey
    }
});

// fileBuffer: the image
// fileName: the name of the file
// mimetype: the content type of the image
export async function uploadFile(fileBuffer, fileName, mimetype)
{
    const uploadParameters = {
        Bucket: bucketName,
        Body: fileBuffer,
        Key: fileName,
        ContentType: mimetype
    }
    
    const command = new PutObjectCommand(uploadParameters);
    return await s3Client.send(command);
}

export async function getObjectSignedUrl(key)
{
    const params = {
        Bucket: bucketName,
        Key: key // the name of the image
    }

    const command = new GetObjectCommand(params);
    const seconds = 3600;
    // image url expires in 60 minutes
    return await getSignedUrl(s3Client, command, { expiresIn: seconds });
}

export async function deleteFile(key)
{
    const params = {
        Bucket: bucketName,
        key: key // name of image
    }

    const command = new DeleteObjectCommand(params);
    return await s3Client.send(command);
}