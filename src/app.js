const express = require("express")
const app = express()
const bodyParser = require("body-parser")

const port = 3000
require("./db")
const routes = require("./routes")

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(routes)

module.exports = app
