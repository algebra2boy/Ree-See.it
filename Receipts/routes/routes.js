import express from 'express'
import client from '../modules/db_connect.js';

const router = express.Router()
const collection = client.db('Ree-See-it').collection('receipts')

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

router.get('/api/receipt/:user_id', async (req, res) => {
  const doc = await collection.findOne({ 'user_id': req.params.user_id })
  res.send(doc)
})

export default router