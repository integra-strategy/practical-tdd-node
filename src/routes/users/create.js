const User = require("../../models/user")

module.exports = (req, res) => User.create(req.body).then(res.status(201).end())
