const request = require("supertest")

const app = require("../src/app")
const User = require("../src/models/user")

test("the server is wired up correctly", async () => {
  const name = "Don Schrimsher"
  await createUser({ name })

  const user = await User.findOne().lean()

  expect(user.name).toEqual(name)
})

const createUser = async body => {
  const res = await request(app)
    .post("/users")
    .expect(201)
    .send(body)
  return res.body
}
