const express = require('express')
const path = require('path')
const PORT = process.env["NOMAD_PORT_http"] || 5000

express()
  .get('/**', (req, res) => res.send(`Got request to ${req.path}. Hello World!`))
  .listen(PORT, () => console.log(`Listening on ${ PORT }`))
