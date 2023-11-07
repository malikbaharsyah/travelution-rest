require('dotenv').config();

const express = require('express');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/test', (req, res) => {
    res.status(200).send('Hello Babi!');
});

app.post('/nodelogin', (req, res) => {
    const username = req.body.username;
    const password = req.body.password;

    const user = {
        username: username,
        password: password
    };

    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
    res.json({accessToken: accessToken});
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})