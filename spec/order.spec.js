const request = require("supertest")

const app = require("../src/app")
const User = require("../src/models/user")

test("Joe should be able to see who wants tacos", async () => {
  const firstName = "Don Schrimsher"
  const secondName = "Jamie Doe"
  await createPerson({ name: firstName })
  await createPerson({ name: secondName })

  const orders = await fetchOrders()

  expect(orders).toContain(firstName)
  expect(orders).toContain(secondName)
})

const createPerson = async body => {
  const res = await request(app)
    .post("/users")
    .expect(201)
    .send(body)
  return res.body
}

const fetchOrders = async () => {
  const res = await request(app)
    .get("/orders")
    .expect(200)
  return res.text
}
