const _ = require("lodash")

const buildOrders = require("../../functions/build-orders")

module.exports = (req, res) => {
  buildOrders().then(orders =>
    res.status(200).send(JSON.stringify(orders, null, 2))
  )
}
