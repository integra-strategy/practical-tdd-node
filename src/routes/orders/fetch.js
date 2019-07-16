const _ = require("lodash")

const User = require("../../models/user")

module.exports = (req, res) => {
  User.find()
    .lean()
    .then(users => {
      const orders = buildOrders(users)
      res.status(200).send(JSON.stringify(orders, null, 2))
    })
}

const buildOrders = users => _.map(users, user => _.pick(user, ["name"]))
