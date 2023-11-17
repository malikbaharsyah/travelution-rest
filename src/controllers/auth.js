const jwt = require('jsonwebtoken');

function generateToken(user, accessTokenSecret) {
  return jwt.sign(user, accessTokenSecret);
}

const verifyToken = (req, res, secret) => {
    const token = req.headers['authorization'];

    if (!token) {
        return res.status(403).json({ message: 'Token required' });
    }

    jwt.verify(token, secret, (err, decoded) => {
        if (err) {
            return res.status(401).json({ message: 'Failed to authenticate token' });
        }

        req.user = decoded;

    });
};

function decodeToken(token, secret) {
    return jwt.verify(token, secret);
};

function isAdmin(user) {
    return user.Role === 'Admin';
}

function getUsername(token) {
    const decoded = decodeToken(token);
    return decoded.Username;
}

module.exports = {
    generateToken,
    decodeToken,
    verifyToken,
    isAdmin,
    getUsername
}