const mongoose = require("mongoose")

const tacoSchema = new mongoose.Schema({
  name: String,
  quantity: Number
})

const orderSchema = new mongoose.Schema({
  person: String,
  tacos: [tacoSchema]
})

module.exports = mongoose.model("Order", orderSchema)
