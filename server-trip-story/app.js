const express = require('express')
const bodyParser = require('body-parser')
const randomString = require('randomstring')
const app = express()
app.use(bodyParser.json());
const port = 3000

app.get('/', (req, res) => {res.send('Hello World!')} )

app.post('/user/login', 
    (req, res) => {
        const id = req.body.id;
        const pw = req.body.pw;
        console.log(id,pw);
        if (req.body.id == "1111") {
            if (req.body.pw == "1111") {
                res.json(randomString.generate(19))
            } else {
                res.status(401).json("failed")
            }
        } else {
            res.status(400).json("failed")
        }
    }
)

app.get('/user/login', 
    (req, res) => {
        if (req.query.id == "1111") {
            if (req.query.pw == "1111") {
                res.json(randomString.generate(19))
            } else {
                res.status(401).json("failed")
            }
            
        } else {
            res.status(400).json("failed")
        }
    }
)

app.listen(port, () => { console.log(`Server on http://localhost:${port}`)})