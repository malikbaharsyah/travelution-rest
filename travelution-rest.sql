CREATE TABLE SubsAccount(
    Username VARCHAR(40) NOT NULL PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

CREATE TABLE SpecialPlace(
    PlaceID INT NOT NULL PRIMARY KEY,
    PlaceName VARCHAR(100) NOT NULL,
    PlaceLocation VARCHAR(100) NOT NULL,
    PlaceDescription VARCHAR(1000) NOT NULL,
    PlaceType VARCHAR(50) NOT NULL,
    PlacePrice INT NOT NULL,
    PlaceOpenTime TIME NOT NULL,
    PlaceCloseTime TIME NOT NULL,
    PlaceContact VARCHAR(20) NOT NULL,
    PlaceEmail VARCHAR(50),
    PlaceWebsite VARCHAR(500),
    Speciality VARCHAR(1000) NOT NULL
);

CREATE TABLE PlaceImage(
    PlaceID INT NOT NULL,
    PlaceImg VARCHAR(15) NOT NULL,
    FOREIGN KEY (PlaceID) REFERENCES SpecialPlace(PlaceID)
);

CREATE TABLE Voucher(
    VoucherID INT NOT NULL PRIMARY KEY,
    VoucherName VARCHAR(100) NOT NULL,
    VoucherDesc VARCHAR(1000) NOT NULL,
    VoucherType VARCHAR(20) NOT NULL,
    VoucherStartDate DATE NOT NULL,
    VoucherEndDate DATE NOT NULL
);

CREATE TABLE Package(
    PackageID INT NOT NULL PRIMARY KEY,
    PackageName VARCHAR(100) NOT NULL,
    PackageDesc VARCHAR(1000) NOT NULL,
    PackageStartDate DATE NOT NULL,
    PackageEndDate DATE NOT NULL,
    City VARCHAR(100) NOT NULL,
    Price INT NOT NULL
);

CREATE TABLE ListVoucher(
    Username VARCHAR(40) NOT NULL,
    VoucherID INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES SubsAccount(Username),
    FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
);

CREATE TABLE ListPackage(
    Username VARCHAR(40) NOT NULL,
    PackageID INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES SubsAccount(Username),
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

CREATE TABLE PackagePlace(
    PackageID INT NOT NULL,
    PlaceID INT NOT NULL,
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID),
    FOREIGN KEY (PlaceID) REFERENCES SpecialPlace(PlaceID)
);

CREATE TABLE TravelPlan(
    TravelPlanID INT NOT NULL PRIMARY KEY,
    Username VARCHAR(40) NOT NULL,
    DateStart DATE NOT NULL,
    DateEnd DATE NOT NULL,
    TotalPrice INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES SubsAccount(Username)
);

CREATE TABLE PlaceList(
    PlaceListID INT NOT NULL PRIMARY KEY,
    TravelPlanID INT NOT NULL,
    PlaceID INT NOT NULL,
    DateStart DATE NOT NULL,
    DateEnd DATE NOT NULL,
    TimeStart TIME NOT NULL,
    TimeEnd TIME NOT NULL,
    FOREIGN KEY (TravelPlanID) REFERENCES TravelPlan(TravelPlanID),
    FOREIGN KEY (PlaceID) REFERENCES SpecialPlace(PlaceID)
);

insert into SubsAccount (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('dleithharvey0', 'gC1<c@lM', 'Dulci', 'Leith-Harvey', 'dleithharvey0@merriam-webster.com', '748-748-8345', 'User');
insert into SubsAccount (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('wdykes1', 'yB8}lfq4e', 'Winny', 'Dykes', 'wdykes1@ox.ac.uk', '234-432-9697', 'User');
insert into SubsAccount (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('oshannahan2', 'yK7()3+#v4', 'Orv', 'Shannahan', 'oshannahan2@bloglines.com', '213-908-2001', 'Admin');
insert into SubsAccount (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('btrivett3', 'uJ6(X*FcEHxJ$', 'Burg', 'Trivett', 'btrivett3@si.edu', '160-643-5982', 'User');
insert into SubsAccount (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('eelphinston4', 'cK3%Iyz,rJ', 'Elicia', 'Elphinston', 'eelphinston4@cafepress.com', '579-972-4046', 'User');

insert into SpecialPlace(PlaceID, PlaceName, PlaceLocation, PlaceDescription, PlaceType, PlacePrice, PlaceOpenTime, PlaceCloseTime, PlaceContact, PlaceEmail, PlaceWebsite, Speciality) values (1, 'Sample Place 1', 'City A', 'A wonderful place to visit.', 'Attraction', 20000, '09:00:00', '18:00:00', '123-456-7890', 'sample1@example.com', 'www.sampleplace1.com', 'Free Souvenir');
insert into SpecialPlace(PlaceID, PlaceName, PlaceLocation, PlaceDescription, PlaceType, PlacePrice, PlaceOpenTime, PlaceCloseTime, PlaceContact, PlaceEmail, PlaceWebsite, Speciality) values (2, 'Sample Place 2', 'City B', 'Explore the beauty of nature.', 'Park', 0, '07:00:00', '21:00:00', '987-654-3210', 'sample2@example.com', 'www.sampleplace2.com', 'Free Souvenir');
insert into SpecialPlace(PlaceID, PlaceName, PlaceLocation, PlaceDescription, PlaceType, PlacePrice, PlaceOpenTime, PlaceCloseTime, PlaceContact, PlaceEmail, PlaceWebsite, Speciality) values (3, 'Sample Place 3', 'City C', 'A historical landmark.', 'Museum', 15000, '10:00:00', '17:00:00', '555-123-4567', 'sample3@example.com', 'www.sampleplace3.com', 'Free Food and Drink');
insert into SpecialPlace(PlaceID, PlaceName, PlaceLocation, PlaceDescription, PlaceType, PlacePrice, PlaceOpenTime, PlaceCloseTime, PlaceContact, PlaceEmail, PlaceWebsite, Speciality) values (4, 'Sample Place 4', 'City D', 'A family-friendly amusement park.', 'Amusement Park', 30000, '11:00:00', '20:00:00', '111-222-3333', 'sample4@example.com', 'www.sampleplace4.com', 'Free Entry Ticket');
insert into SpecialPlace(PlaceID, PlaceName, PlaceLocation, PlaceDescription, PlaceType, PlacePrice, PlaceOpenTime, PlaceCloseTime, PlaceContact, PlaceEmail, PlaceWebsite, Speciality) values (5, 'Sample Place 5', 'City E', 'Experience fine dining.', 'Restaurant', 50000, '18:00:00', '23:00:00', '777-888-9999', 'sample5@example.com', 'www.sampleplace5.com', 'Free Entry Ticket');

insert into PlaceImage(PlaceID, PlaceImg) values (1, '0x831241247');
insert into PlaceImage(PlaceID, PlaceImg) values (2, '0x222144364');
insert into PlaceImage(PlaceID, PlaceImg) values (3, '0x112341249');
insert into PlaceImage(PlaceID, PlaceImg) values (4, '0x313658671');
insert into PlaceImage(PlaceID, PlaceImg) values (5, '0x241456457');

insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (1, 'Diskon 10%', 'Nikmati diskon 10% untuk rencana perjalanan', 'Discount', '2020-01-01', '2020-12-31');
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (2, 'Diskon 25%', 'Nikmati diskon 25% untuk rencana perjalanan', 'Discount', '2020-01-01', '2020-12-31');
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (3, 'Gratis 1 tiket', 'Gratis 1 tiket untuk tempat tertentu', 'Free Ticket', '2020-01-01', '2020-12-31');
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (4, 'Gratis 2 tiket', 'Gratis 2 tiket untuk tempat tertentu', 'Free Ticket', '2020-01-01', '2020-12-31');
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (5, 'Gratis makan minum', 'Gratis mendapatkan makan dan minum untuk tempat tertentu', 'Free Items', '2020-01-01', '2020-12-31');
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherType, VoucherStartDate, VoucherEndDate) values (6, 'Gratis souvenir', 'Gratis mendapatkan souvenir untuk tempat tertentu', 'Free Items', '2020-01-01', '2020-12-31');

insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values (1, 'Sample Package 1', 'A wonderful package to visit.', '2020-01-01', '2020-01-03', 'City A', 1000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values (2, 'Sample Package 2', 'Explore the beauty of nature.', '2020-01-01', '2020-01-03', 'City B', 2000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values (3, 'Sample Package 3', 'A historical landmark.', '2020-01-01', '2020-01-03', 'City C', 3000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values (4, 'Sample Package 4', 'A family-friendly amusement park.', '2020-01-01', '2020-01-03', 'City D', 4000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values (5, 'Sample Package 5', 'Experience fine dining.', '2020-01-01', '2020-01-03', 'City E', 5000000);

insert into ListVoucher(Username, VoucherID) values ('dleithharvey0', 1);
insert into ListVoucher(Username, VoucherID) values ('wdykes1', 1);
insert into ListVoucher(Username, VoucherID) values ('wdykes1', 4);
insert into ListVoucher(Username, VoucherID) values ('oshannahan2', 2);
insert into ListVoucher(Username, VoucherID) values ('btrivett3', 5);
insert into ListVoucher(Username, VoucherID) values ('eelphinston4', 3);
insert into ListVoucher(Username, VoucherID) values ('eelphinston4', 6);

insert into ListPackage(Username, PackageID) values ('dleithharvey0', 1);
insert into ListPackage(Username, PackageID) values ('wdykes1', 1);
insert into ListPackage(Username, PackageID) values ('wdykes1', 4);
insert into ListPackage(Username, PackageID) values ('oshannahan2', 2);
insert into ListPackage(Username, PackageID) values ('btrivett3', 3);
insert into ListPackage(Username, PackageID) values ('btrivett3', 5);

insert into PackagePlace(PackageID, PlaceID) values (1, 1);
insert into PackagePlace(PackageID, PlaceID) values (1, 2);
insert into PackagePlace(PackageID, PlaceID) values (2, 1);
insert into PackagePlace(PackageID, PlaceID) values (2, 3);
insert into PackagePlace(PackageID, PlaceID) values (2, 4);
insert into PackagePlace(PackageID, PlaceID) values (3, 1);
insert into PackagePlace(PackageID, PlaceID) values (3, 2);
insert into PackagePlace(PackageID, PlaceID) values (3, 5);
insert into PackagePlace(PackageID, PlaceID) values (4, 2);
insert into PackagePlace(PackageID, PlaceID) values (4, 4);
insert into PackagePlace(PackageID, PlaceID) values (5, 1);
insert into PackagePlace(PackageID, PlaceID) values (5, 3);
insert into PackagePlace(PackageID, PlaceID) values (5, 5);

insert into TravelPlan(TravelPlanID, Username, DateStart, DateEnd, TotalPrice) values (1, 'dleithharvey0', '2020-01-01', '2020-01-06', 1000000);
insert into TravelPlan(TravelPlanID, Username, DateStart, DateEnd, TotalPrice) values (2, 'wdykes1', '2020-01-02', '2020-01-07', 2000000);
insert into TravelPlan(TravelPlanID, Username, DateStart, DateEnd, TotalPrice) values (3, 'oshannahan2', '2020-01-03', '2020-01-08', 3000000);
insert into TravelPlan(TravelPlanID, Username, DateStart, DateEnd, TotalPrice) values (4, 'btrivett3', '2020-01-04', '2020-01-09', 4000000);
insert into TravelPlan(TravelPlanID, Username, DateStart, DateEnd, TotalPrice) values (5, 'eelphinston4', '2020-01-05', '2020-01-10', 5000000);

insert into PlaceList(PlaceListID, TravelPlanID, PlaceID, DateStart, DateEnd, TimeStart, TimeEnd) values (1, 1, 1, '2020-01-01', '2020-01-01', '08:00:00', '10:00:00');
insert into PlaceList(PlaceListID, TravelPlanID, PlaceID, DateStart, DateEnd, TimeStart, TimeEnd) values (2, 2, 2, '2020-01-01', '2020-01-01', '08:00:00', '10:00:00');
insert into PlaceList(PlaceListID, TravelPlanID, PlaceID, DateStart, DateEnd, TimeStart, TimeEnd) values (3, 3, 3, '2020-01-01', '2020-01-02', '08:00:00', '10:00:00');
insert into PlaceList(PlaceListID, TravelPlanID, PlaceID, DateStart, DateEnd, TimeStart, TimeEnd) values (4, 4, 4, '2020-01-02', '2020-01-02', '08:00:00', '10:00:00');
insert into PlaceList(PlaceListID, TravelPlanID, PlaceID, DateStart, DateEnd, TimeStart, TimeEnd) values (5, 5, 5, '2020-01-02', '2020-01-03', '08:00:00', '10:00:00');