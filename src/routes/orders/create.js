const Order = require("../../models/order")

module.exports = (req, res) => {
  return Order.create(req.body).then(res.status(201).end())
}
