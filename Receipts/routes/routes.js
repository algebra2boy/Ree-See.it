import express from 'express'
import { MongoClient } from 'mongodb';
import client from '../modules/db_connect.js';

const router = express.Router()
// await client.connect()

router.post('/api/receipt/:user_id', (req, res) => {
  // const receipt = {}
  // client.receipts
})

router.get('/api/receipt/:user_id', async (req, res) => {
  const collection = client.db('Ree-See-it').collection('receipts')
  const doc = await collection.findOne({ 'user_id': req.params.user_id })
  res.send(doc)
})

export default router