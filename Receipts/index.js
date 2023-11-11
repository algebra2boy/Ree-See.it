import express from 'express'
import router from './routes/routes.js'
import client from './modules/db_connect.js'

const app = express()

app.use(router)

async function go(){
  try {
    // Send a ping to confirm a successful connection
    await client.db("admin").command({ ping: 1 });
    console.log("Pinged your deployment. You successfully connected to MongoDB!");
  } catch(e) {
    console.log(e)
  }
}

app.listen(54102, () => {
  console.log('Server started on port 54102')
  go().then(() => console.log('DB connection established')).catch(e => console.log(e));
})