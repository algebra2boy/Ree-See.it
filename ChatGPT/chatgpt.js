import express from "express";
import morgan from "morgan"
import axios from "axios";
import * as dotenv from 'dotenv';

dotenv.config();

const app = express();

app.use(express.json());
app.use(morgan("dev"));

const receiptText1 = `
=WHOLESALE
GREEN TOWN $ 5208
1212, Pine Wood Plaza Dr
Green Town, CA 34343
B7 Member 585635184442
E 3081064 BANANAS 1.67 E
A 7073705 Bluetooth Care 122.34 A
8143739 Dinning Table 422.9 §
8523605 Wine Bottle 9.99 E
8831466 Beer Case 19.90 E
SUBTOTAL 576.89
TAX 102.67
kk TOTAL
XXXXXXXXXXXX9999 CHIP Read
AID: LBG716KSFKGB
Seq# 463882 APP#: MAOZ
VISA Resp: APPROVED
Tran ID#: 2577049117
Merchant ID: 052587
APPROVED - Purchase
AMOUNT : £79.56
08/19/2021 17:58:17 5208 208 256 208
TUUTNISA TTT TTT TTT TeT9.56
CHANGE 0.00
S TAX 9.75% 89.99
E TAX 7.75% 8.78
A TAX 2.75% 3.9%
TOTAL TAX 102.67
TOTAL NUMBER OF ITEMS SOLD = 5
17:58:17 5208 208 256 208
205320144430711570000
OP: 208 NAME: SCO LANE #208
Thank You.
Please Come Again
Whse: 5208 Trm: 208 Trn: 256 OP: 208
Items Sold : 5
B7 08/19/2021 17:58:17
`;

let content = `Give me a JSON data that contains receipt info. An object with only these key names: storeName, address, items, subtotal, category. Items are an array of item. category should just be a string. Each item has name and price.`

// Configure the headers for your POST request.
const config = {
    headers: {
        'Authorization': `Bearer ${process.env.openaiApiKey}`,
        'Content-Type': 'application/json'
    }
};


const sendPostRequest = async (req, res, parsed_strings) => {

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

    try {
        const response = await axios.post('https://api.openai.com/v1/chat/completions', postData, config);
        console.log('Response from OpenAI:', JSON.stringify(response.data));

        res.status(200).json(JSON.parse(response.data.choices[0]["message"]["content"]));

    } catch (err) {

        res.status(500).json({ "message": "fail to call GPT4" });
    }
};

app.post("/api/gpt", async (req, res) => {
    const receiptStrings = req.body.receiptString;
    sendPostRequest(req, res, receiptStrings);
})

// sendPostRequest();

app.listen(3005, () => console.log("gpt is listensing on port 3005"));