const express = require("express")
const router = express.Router()

const fetch = require("./fetch")
const create = require("./create")

router.get("/", fetch)
router.post("/", create)

module.exports = router
