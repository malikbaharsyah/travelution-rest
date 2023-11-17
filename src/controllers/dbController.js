const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function createVoucher(vName, vDesc, vDisc, vStart, vEnd) {
    try {
        const newVoucher = await prisma.voucher.create({
            data: {
                VoucherName: vName,
                VoucherDesc: vDesc,
                VoucherDiscount: vDisc,
                VoucherStartDate: vStart,
                VoucherEndDate: vEnd
            }
        });
        // create voucher for all user inside listVoucher
        const accounts = await prisma.account.findMany();
        for (const account of accounts) {
            await prisma.listVoucher.create({
                data: {
                    Username: account.Username,
                    VoucherID: newVoucher.VoucherID
                }
            });
        }
        return newVoucher;
    } catch (error) {
        throw error;
    }
}

async function getVoucher(id) {
    try {
        const voucher = await prisma.voucher.findFirst({
            where: {
                VoucherID: id
            }
        });
        return voucher;
    } catch (error) {
        throw error;
    }
}

async function deleteVoucher(id) {
    try {
        // delete voucher for all user inside listVoucher
        await prisma.listVoucher.deleteMany({
            where: {
                VoucherID: id
            }
        });
        const deletedVoucher = await prisma.voucher.delete({
            where: {
                VoucherID: id
            }
        });
        return deletedVoucher;
    } catch (error) {
        throw error;
    }
}

async function deleteUserVoucher(username, id) {
    try {
        const deletedVoucher = await prisma.listVoucher.delete({
            where: {
                Username_VoucherID: {
                    Username: username,
                    VoucherID: id
                }
            }
        });
        return deletedVoucher;
    } catch (error) {
        throw error;
    }
}

async function getAllVouchers() {
    try {
        const allVouchers = await prisma.voucher.findMany();
        return allVouchers;
    } catch (error) {
        throw error;
    }
}

async function getUserVouchers(username) {
    try {
        const userVouchers = await prisma.listVoucher.findMany({
            where: {
                Username: username
            }
        });
        return userVouchers;
    } catch (error) {
        throw error;
    }
}

async function getUserVoucher(username, id) {
    try {
        const userVoucher = await prisma.listVoucher.findFirst({
            where: {
                Username: username,
                VoucherID: id
            }
        });
        return userVoucher;
    } catch (error) {
        throw error;
    }
}

async function getAccount(username, password) {
    try {
        const account = await prisma.account.findFirst({
            where: {
                Username: username,
                Password: password
            }
        });
        return account;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

async function createPackage(pName, pDesc, pStart, pEnd, pCity, pPrice) {
    try {
        const newPackage = await prisma.package.create({
            data: {
                PackageName: pName,
                PackageDesc: pDesc,
                PackageStartDate: pStart,
                PackageEndDate: pEnd,
                PackageCity: pCity,
                PackagePrice: pPrice
            }
        });
        return newPackage;
    } catch (error) {
        throw error;
    }
}

async function getPackage(id) {
    try {
        const package = await prisma.package.findFirst({
            where: {
                PackageID: id
            }
        });
        return package;
    } catch (error) {
        throw error;
    }
}

async function getAllPackages() {
    try {
        const allPackages = await prisma.package.findMany();
        return allPackages;
    } catch (error) {
        throw error;
    }
}

async function updatePackage(id, pName, pDesc, pStart, pEnd, pCity, pPrice) {
    try {
        // Create an object to store non-null values
        const updateData = {};

        // Check each parameter and add to the updateData object if not null
        if (pName !== null) {
            updateData.PackageName = pName;
        }
        if (pDesc !== null) {
            updateData.PackageDesc = pDesc;
        }
        if (pStart !== null) {
            updateData.PackageStartDate = pStart;
        }
        if (pEnd !== null) {
            updateData.PackageEndDate = pEnd;
        }
        if (pCity !== null) {
            updateData.PackageCity = pCity;
        }
        if (pPrice !== null) {
            updateData.PackagePrice = pPrice;
        }

        // Check if there are any non-null values to update
        if (Object.keys(updateData).length === 0) {
            // No non-null values, return the existing package
            const existingPackage = await prisma.package.findUnique({
                where: {
                    PackageID: id
                }
            });
            return existingPackage;
        }

        // Update the package with the non-null values
        const updatedPackage = await prisma.package.update({
            where: {
                PackageID: id
            },
            data: updateData
        });

        return updatedPackage;
    } catch (error) {
        throw error;
    }
}

async function addPlaceToPackage(packageId, placeId) {
    try {
        const packagePlace = await prisma.packagePlace.create({
            data: {
                PackageID: packageId,
                PlaceID: placeId
            }
        });
        return packagePlace;
    } catch (error) {
        throw error;
    }
}

async function deletePlaceFromPackage(packageId, placeId) {
    try {
        const deletedPackagePlace = await prisma.packagePlace.delete({
            where: {
                PackageID_PlaceID: {
                    PackageID: packageId,
                    PlaceID: placeId
                }
            }
        });
        return deletedPackagePlace;
    } catch (error) {
        throw error;
    }
}

async function getPlacesFromPackage(packageId) {
    try {
        const packagePlaces = await prisma.packagePlace.findMany({
            where: {
                PackageID: packageId
            }
        });
        for (let i = 0; i < packagePlaces.length; i++) {
            const place = await prisma.place.findFirst({
                where: {
                    PlaceID: packagePlaces[i].PlaceID
                }
            });
            packagePlaces[i].Place = place;
        }
        return packagePlaces;
    } catch (error) {
        throw error;
    }
}


async function deletePackage(id) {
    try {
        const deletedPackage = await prisma.package.delete({
            where: {
                PackageID: id
            }
        });
        return deletedPackage;
    } catch (error) {
        throw error;
    }
}

async function createAccount(req) {
    try {
        const newAccount = await prisma.account.create({
            data: {
                Username: req.Username,
                Password: req.Password,
                FirstName: req.FirstName,
                LastName: req.LastName,
                Email: req.Email,
                PhoneNumber: req.PhoneNumber,
                Role: "User"
            }
        });
        return newAccount;
    } catch (error) {
        throw error;
    }
}

module.exports = {
    getUserVouchers,
    getUserVoucher,
    getAccount,
    createPackage,
    getPackage,
    getAllPackages,
    updatePackage,
    deletePackage,
    getVoucher,
    deleteVoucher,
    createVoucher,
    getAllVouchers,
    deleteUserVoucher,
    addPlaceToPackage,
    deletePlaceFromPackage,
    getPlacesFromPackage,
    createAccount
}