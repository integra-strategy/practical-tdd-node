const request = require("supertest")

const app = require("../../src/app")
const buildOrders = require("../../src/functions/build-orders")

describe("Orders", () => {
  it("formats the orders nicely for Joe", async () => {
    const firstPerson = "Don Schrimsher"
    const secondPerson = "Jamie Doe"
    await createOrder({ person: firstPerson })
    await createOrder({ person: secondPerson })

    const orders = await fetchOrders()

    expect(orders).toContain(firstPerson)
    expect(orders).toContain(secondPerson)
  })

  it("tells Joe which tacos each person wants", async () => {
    const person = "Jamie Smith"
    const taco = { name: "PHILLY CHEESESTEAK", quantity: 1 }
    await createOrder({ person, tacos: [taco] })

    const orders = await buildOrders()

    const firstOrder = orders[0]
    expect(firstOrder.person).toEqual(person)
    expect(firstOrder.tacos[0].name).toEqual(taco.name)
  })

  it("tells Joe how many tacos each person wants", async () => {
    const person = "Jamie Smith"
    const taco = { name: "PHILLY CHEESESTEAK", quantity: 1 }
    await createOrder({ person, tacos: [taco] })
    await createOrder({ person, tacos: [taco] })

    const orders = await buildOrders()

    const firstOrder = orders[0]
    expect(firstOrder.person).toEqual(person)
    expect(firstOrder.tacos[0].quantity).toEqual(2)
  })
})

const fetchOrders = async () => {
  const res = await request(app)
    .get("/orders")
    .expect(200)
  return res.text
}

const createOrder = async body => {
  const res = await request(app)
    .post("/orders")
    .expect(201)
    .send(body)
  return res.body
}
