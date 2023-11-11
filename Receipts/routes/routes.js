import express from 'express'
import client from '../modules/db_connect.js';
import multer from 'multer';
import XMLHttpRequest from 'xhr2'

const router = express.Router()
const collection = client.db('Ree-See-it').collection('receipts')


const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

router.post('/api/receipt/:user_id', async (req, res) => {
  const geoRes = await fetch(`http://127.0.0.1:54101/get-geocode?address=${req.body.address}`)
  const geoData = await geoRes.json()
  const user_id = req.params.user_id
  const receipt = {
    'id': req.body.id,
    'name':req.body.name,
    'address':req.body.address,
    'coordinate':geoData,
    'date':req.body.date,
    'items':req.body.items,
    'totalPrice':Number(req.body.totalPrice),
    'category':req.body.category,
    'message':req.body.message,
    'isVerified':Boolean(req.body.isVerified),
    'receiptMethod':req.body.receiptMethod
  }

  const doc = await collection.findOne({ 'user_id': user_id })
  doc?.receipts.push(receipt)
  await collection.updateOne({ 'user_id': user_id }, {$set:{receipts: doc ? doc.receipts : [receipt] }}, {upsert: true})
  res.sendStatus(200)
})

router.post('/api/imageUpload/:user_id', upload.single("image"), async (req, res) => {
  const file = req.file
  const formData = new FormData()
  formData.append('image', file)

  const content = '<q id="a"><span id="b">hey!</span></q>';
  const blob = new Blob([content], { type: 'text/xml' })
  formData.append('webmasterfile', blob)
  const request = new XMLHttpRequest()
  request.open('POST', 'http://localhost:3003/api/posts')
  request.send(formData)
  // let data = new FormData()
  // const data = {
  //   file: {
  //     value: file.buffer,
  //     options: {
  //       filename: file.originalname,
  //       contentType: file.mimetype,  // Adjust the content type based on your file type
  //     },
  //   },
  // };
  // data.append('image', file)
  // console.log(data)
  // const awsRes = await fetch('http://localhost:3003/api/posts', {
  //   method: 'POST',
  //   headers: {
  //     'Content-type': 'multipart/form-data'
  //   },
  //   body: JSON.stringify(file),
  // })
  // const awsData = await awsRes.json()
  // res.send(awsData)
  // res.sendStatus(200)
})

router.get('/api/receipt/:user_id', async (req, res) => {
  const doc = await collection.findOne({ 'user_id': req.params.user_id })
  res.send(doc)
})

function createFormData(formData) {
  const boundary = '----WebKitFormBoundary' + new Date().getTime();
  const boundaryString = '\r\n--' + boundary + '\r\n';
  const endBoundaryString = '\r\n--' + boundary + '--';

  let body = '';

  for (const key in formData) {
    if (formData.hasOwnProperty(key)) {
      body += boundaryString;
      if (formData[key].options.filename) {
        body += 'Content-Disposition: form-data; name="' + key +
                '"; filename="' + formData[key].options.filename + '"\r\n';
      } else {
        body += 'Content-Disposition: form-data; name="' + key + '"\r\n';
      }

      if (formData[key].options.contentType) {
        body += 'Content-Type: ' + formData[key].options.contentType + '\r\n';
      }

      body += '\r\n' + formData[key].value.toString('binary') + '\r\n';
    }
  }

  body += endBoundaryString;

  return body;
}

export default router