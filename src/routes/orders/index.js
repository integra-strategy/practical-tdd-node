const express = require("express")
const router = express.Router()

const fetch = require("./fetch")

router.get("/", fetch)

module.exports = router
