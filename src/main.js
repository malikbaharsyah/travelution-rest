require('dotenv').config();

const secret_token = process.env.ACCESS_TOKEN_SECRET;

const dbcontroller = require('./controllers/dbcontroller');
const subscribeController = require('./controllers/subscribeController');
const packageController = require('./controllers/packageController');
const voucherController = require('./controllers/voucherController');
const auth = require('./controllers/auth');

const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(morgan('combined'));
app.use(express.json());

app.get('/test', (req, res) => {
    res.status(200).send('Hello!');
});

app.post('/login', async (req, res) => {
    const username = req.body.username;
    const password = req.body.password;

    try {
        const account = await dbcontroller.getAccount(username, password);
        if (account) {
            const accessToken = auth.generateToken(account, secret_token);
            res.status(200).json({ accessToken: accessToken });
        } else {
            res.status(401).json({ error: 'Check username and password' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Error logging in' });
    }

});

app.post('/logout', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    try {
        res.status(200).json({ message: 'Logout success' });
        
    } catch (error) {
        res.status(500).json({ error: 'Error logging out' });
    }
});

app.post('/register', async (req, res) => {
    try {
        const newAccount = await dbcontroller.createAccount(req.body);
        res.status(200).json({ message: 'Account created!', data: newAccount });
    } catch (error) {
        console.error('Error creating account:', error);
        res.status(500).json({ error: 'Error creating account' });
    }
});

app.get('/user-voucher/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    try {
        const userVoucher = await dbcontroller.getUserVoucher(req.user.Username, req.params.id);
        res.status(200).json({ data: userVoucher });
    } catch (error) {
        res.status(500).json({ error: 'Error getting user voucher' });
    }
});

app.get('user-voucher', async (req, res) => {
    auth.verifyToken(req, res, secret_token);
    try {
        const userVouchers = await dbcontroller.getUserVouchers(req.user.Username);
        res.status(200).json({ data: userVouchers });
    } catch (error) {
        res.status(500).json({ error: 'Error getting user vouchers' });
    }
});

app.delete('/user-voucher/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);
    try {
        const deletedVoucher = await dbcontroller.deleteUserVoucher(req.user.Username, req.params.id);
        res.status(200).json({ data: deletedVoucher });
    } catch (error) {
        res.status(500).json({ error: 'Error deleting user voucher' });
    }
})

app.get('/voucher', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const allVouchers = await dbcontroller.getAllVouchers();
        res.status(200).json({ data: allVouchers });
    } catch (error) {
        console.error('Error getting vouchers:', error);
        res.status(500).json({ error: 'Error getting vouchers' });
    }
});

app.get('/voucher/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    const id = req.params.id;

    try {
        const voucher = await dbcontroller.getVoucher(id);
        res.status(200).json({ data: voucher });
    } catch (error) {
        console.error('Error getting voucher:', error);
        res.status(500).json({ error: 'Error getting voucher' });
    }
});

app.post('/voucher', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    const {Name, Desc, Disc, Start, End } = req.body;

    try {
        const newVoucher = await dbcontroller.createVoucher(Name, Desc, Disc, Start, End);
        res.status(200).json({ message: 'Voucher created!', data: newVoucher });
    } catch (error) {
        console.error('Error creating voucher:', error);
        res.status(500).json({ error: 'Error creating voucher' });
    }
});

app.delete('/voucher/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    const id = req.params.id;

    try {
        const deletedVoucher = await dbcontroller.deleteVoucher(id);
        res.status(200).json({ message: 'Voucher deleted!', data: deletedVoucher });
    } catch (error) {
        console.error('Error deleting voucher:', error);
        res.status(500).json({ error: 'Error deleting voucher' });
    }
});

app.get('/package', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    try {
        const allPackages = await dbcontroller.getAllPackages();
        res.status(200).json({ data: allPackages });
    } catch (error) {
        console.error('Error getting packages:', error);
        res.status(500).json({ error: 'Error getting packages' });
    }
});

app.get('/package/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    try {
        const package = await dbcontroller.getPackage(req.params.id);
        res.status(200).json({ data: package });
    } catch (error) {
        console.error('Error getting package:', error);
        res.status(500).json({ error: 'Error getting package' });
    }
});

app.put('/package/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const updatedPackage = await dbcontroller.updatePackage(req.params.id, req.body);
        res.status(200).json({ message: 'Package updated!', data: updatedPackage });
    } catch (error) {
        console.error('Error updating package:', error);
        res.status(500).json({ error: 'Error updating package' });
    }

});

app.delete('/package/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const deletedPackage = await dbcontroller.deletePackage(req.params.id);
        res.status(200).json({ message: 'Package deleted!', data: deletedPackage });
    } catch (error) {
        console.error('Error deleting package:', error);
        res.status(500).json({ error: 'Error deleting package' });
    }

});

app.post('/package', async (req, res) => {
    auth.verifyToken(req, res, secret_token);
    
    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const newPackage = await dbcontroller.createPackage(req.body);
        res.status(200).json({ message: 'Package created!', data: newPackage });
    } catch (error) {
        console.error('Error creating package:', error);
        res.status(500).json({ error: 'Error creating package' });
    }
});

app.get('/package-place/:id', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    try {
        const places = await dbcontroller.getPlacesFromPackage(req.params.id);
        res.status(200).json({ data: places });
    } catch (error) {
        console.error('Error getting places:', error);
        res.status(500).json({ error: 'Error getting places' });
    }
});

app.post('package-place', async (req, rest) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const packageId = req.body.packageId;
        const placeId = req.body.placeId;
        newPlace = await dbcontroller.addPlaceToPackage(packageId, placeId);
        res.status(200).json({ message: 'Place added to package', data: newPlace });
    } catch (error) {
        console.error('Error adding place to package:', error);
        res.status(500).json({ error: 'Error adding place to package' });
    }
});

app.delete('/package-place/:packageId/:placeId', async (req, res) => {
    auth.verifyToken(req, res, secret_token);

    if (!auth.isAdmin(req.user)) {
        return res.status(403).json({ message: 'Admin only'});
    }

    try {
        const deletedPlace = await dbcontroller.deletePlaceFromPackage(req.params.packageId, req.params.placeId);
        res.status(200).json({ message: 'Place deleted from package', data: deletedPlace });
    } catch (error) {
        console.error('Error deleting place from package:', error);
        res.status(500).json({ error: 'Error deleting place from package' });
    }
});


app.post('/decode', async (req, res) => {
    try {
        const token = req.body.token;
        const decoded = auth.decodeToken(token, secret_token);
        res.status(200).json({ decoded: decoded });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Error decoding token' });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});