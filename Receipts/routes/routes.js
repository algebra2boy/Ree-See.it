import express from 'express'
import client from '../modules/db_connect.js'
import multer from 'multer'

const router = express.Router()
const collection = client.db('Ree-See-it').collection('receipts')

const storage = multer.memoryStorage()
const upload = multer({ storage: storage })

router.post('/api/receipt/:user_id', async (req, res) => {
  const geoRes = await fetch(
    `http://127.0.0.1:3000/get-geocode?address=${req.body.address}`
  )
  const geoData =
    geoRes.status === 200
      ? await geoRes.json()
      : {
          lat: 42.3912498,
          lon: -72.5262829,
        }
  const user_id = req.params.user_id
  const receipt = {
    id: req.body.id,
    name: req.body.name,
    address: req.body.address,
    coordinate: geoData,
    date: req.body.date,
    items: req.body.items,
    totalPrice: Number(req.body.totalPrice),
    category: req.body.category,
    message: req.body.message,
    isVerified: Boolean(req.body.isVerified),
    receiptMethod: req.body.receiptMethod,
  }

  const doc = await collection.findOne({ user_id: user_id })
  doc?.receipts.push(receipt)
  await collection.updateOne(
    { user_id: user_id },
    { $set: { receipts: doc ? doc.receipts : [receipt] } },
    { upsert: true }
  )
  res.sendStatus(200)
})

router.post(
  '/api/imageUpload/:user_id',
  upload.single('image'),
  async (req, res) => {
    const imageData = new FormData()
    let blob = new Blob([req.file.buffer], { type: req.file.mimetype })
    imageData.append('image', blob)

    const response = await fetch('http://localhost:3003/api/posts', {
      method: 'POST',
      body: imageData,
    })

    const dataJSON = await response.json()
    const receiptID = req.body.id
    const doc = await collection.findOne({ user_id: req.params.user_id })
    const receipt = doc.receipts.find((elem) => elem.id === receiptID)
    const otherReceipts = doc.receipts.filter((elem) => elem.id !== receiptID)
    receipt['imageUrl'] = dataJSON.imageUrl
    receipt['imageName'] = dataJSON.imageName
    otherReceipts.push(receipt)
    await collection.updateOne(
      { user_id: req.params.user_id },
      { $set: { receipts: otherReceipts } },
      { upsert: true }
    )
    res.send(dataJSON)
  }
)

router.post('/api/ocr/:user_id', upload.single('image'), async (req, res) => {
  // 1. receive the image from endpoint
  const imageBlob = new Blob([req.file.buffer], { type: req.file.mimetype })
  const sendData = new FormData()
  sendData.append('image', imageBlob)
  console.log('1 done')
  // 2. semd the image to imageprocesing
  const response = await fetch('http://localhost:3002/api/image/translate/', {
    method: 'POST',
    body: sendData,
  })
  console.log('2 done')
  // 3. receive json response from image processing
  const resJson = await response.json()
  console.log('3 done')
  console.log(resJson)
  resJson['name'] = resJson.storeName
  resJson['totalPrice'] = resJson.subtotal
  resJson['date'] = '11/12/2023'
  resJson['receiptMethod'] = 'OCR'
  resJson.category = 'Groceries'
  // 4. use erica's API again to get the lat and long
  const geoRes = await fetch(
    `http://127.0.0.1:54101/get-geocode?address=${resJson.address}`
  )
  const geoData =
    geoRes.status === 200
      ? await geoRes.json()
      : {
          lat: 42.3912498,
          lon: -72.5262829,
        }
  resJson.coordinate = geoData
  console.log('4 done')
  // 5.
  await fetch(`http://localhost:54102/api/receipt/${req.params.user_id}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(resJson),
  })
  console.log('5 done')
  res.sendStatus(200)
})

router.get('/api/receipt/:user_id', async (req, res) => {
  const doc = await collection.findOne({ user_id: req.params.user_id })
  res.send(doc)
})

export default router
