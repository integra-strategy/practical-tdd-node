const db = require("./src/db")
const Order = require("./src/models/order")

afterEach(async () => {
  await Order.remove({})
})

afterAll(async () => {
  await db.close()
})
