import express from "express";
import morgan from "morgan"
import axios from "axios";
import * as dotenv from 'dotenv';

dotenv.config();

const app = express();

app.use(express.json());
app.use(morgan("dev"));


let parsed_strings = "";
let content = `
Give me a JSON data that contains receipt info. 
I need an object with only these key names: name, address, items, subtotal, category. items are an array of item. category should just be a string. Each item has name and price.`

// Configure the headers for your POST request.
const config = {
    headers: {
        'Authorization': `Bearer ${process.env.openaiApiKey}`,
        'Content-Type': 'application/json'
    }
};

// set up post Data
const postData = {
    // very great gpt 4
    model: 'gpt-4-1106-preview',
    response_format: {
        // must use to enable json
        type: "json_object",
    },
    messages: [
        { role: 'user', content: content + parsed_strings }
    ]
};

const sendPostRequest = async () => {
    try {
        const response = await axios.post('https://api.openai.com/v1/chat/completions', postData, config);
        console.log('Response from OpenAI:', JSON.stringify(response.data));

        res.status(200).json(response.data.choices[0]["message"]["content"]);

    } catch (err) {

        res.status(500).json({ "message": "fail to call GPT4" });
    }
};

app.post("/api/gpt", async (req, res) => {
    const receiptStrings = req.body.receiptString;
    parsed_strings = receiptStrings;

    const response = sendPostRequest();

    parsed_strings = "";
    return response;
})

app.listen(3005, () => console.log("gpt is listensing on port 3005"));