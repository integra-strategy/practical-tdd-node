const db = require("./src/db")
const User = require("./src/models/user")

afterAll(async () => {
  try {
    await User.remove({})
  } finally {
    await db.close()
  }
})
