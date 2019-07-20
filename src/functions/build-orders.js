const _ = require("lodash")

const Order = require("../models/order")

const buildOrders = async () => {
  const orders = await Order.find().lean()
  return _.chain(orders)
    .groupBy("person")
    .mapValues(orders => ({
      person: orders[0].person,
      tacos: _.chain(orders)
        .flatMap("tacos")
        .groupBy("name")
        .mapValues(tacos => ({ name: tacos[0].name, quantity: tacos.length }))
        .values()
        .value(),
      drink: orders[0].drink
    }))
    .values()
    .value()
}

module.exports = buildOrders
