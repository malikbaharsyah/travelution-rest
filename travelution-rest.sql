CREATE TABLE Account(
    Username VARCHAR(40) NOT NULL PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

CREATE TABLE Voucher(
    VoucherID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    VoucherName VARCHAR(100) NOT NULL,
    VoucherDesc VARCHAR(1000) NOT NULL,
    VoucherDiscount INT NOT NULL,
);

CREATE TABLE Package(
    PackageID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PackageName VARCHAR(100) NOT NULL,
    PackageDesc VARCHAR(1000) NOT NULL,
    PackageRoute VARCHAR(1000) NOT NULL,
    PackageStartDate DATE NOT NULL,
    PackageEndDate DATE NOT NULL,
    City VARCHAR(100) NOT NULL,
    Price INT NOT NULL
);

CREATE TABLE ListVoucher(
    ListVoucherID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(40) NOT NULL,
    VoucherID INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES Account(Username),
    FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
);

insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('dleithharvey0', 'gC1<c@lM', 'Dulci', 'Leith-Harvey', 'dleithharvey0@merriam-webster.com', '748-748-8345', 'User');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('wdykes1', 'yB8}lfq4e', 'Winny', 'Dykes', 'wdykes1@ox.ac.uk', '234-432-9697', 'User');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('oshannahan2', 'yK7()3+#v4', 'Orv', 'Shannahan', 'oshannahan2@bloglines.com', '213-908-2001', 'Admin');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('btrivett3', 'uJ6(X*FcEHxJ$', 'Burg', 'Trivett', 'btrivett3@si.edu', '160-643-5982', 'User');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('eelphinston4', 'cK3%Iyz,rJ', 'Elicia', 'Elphinston', 'eelphinston4@cafepress.com', '579-972-4046', 'User');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('admin', 'admin', 'Admin', 'Admin', 'eelphinston4@cafepress.com', '579-972-4046', 'Admin');
insert into Account (Username, Password, FirstName, LastName, Email, PhoneNumber, Role) values ('malik', 'malik123', 'Malik', 'Baharsyah', '13521029@std.stei.itb.ac.id', '08123456789', 'User');

insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherDiscount) values (1, 'Diskon 10%', 'Nikmati diskon 10% untuk rencana perjalanan', 10);
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherDiscount) values (2, 'Diskon 15%', 'Nikmati diskon 25% untuk rencana perjalanan', 15);
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherDiscount) values (3, 'Diskon 20%', 'Nikmati diskon 50% untuk rencana perjalanan', 20);
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherDiscount) values (4, 'Diskon 25%', 'Nikmati diskon 25% untuk rencana perjalanan', 25);
insert into Voucher(VoucherID, VoucherName, VoucherDesc, VoucherDiscount) values (5, 'Diskon 50%', 'Nikmati diskon 50% untuk rencana perjalanan', 50);

insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values ('Sample Package 1', 'A wonderful package to visit.', 'Tempat A - Tempat B - Tempat C', '2020-01-01', '2020-01-03', 'City A', 1000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values ('Sample Package 2', 'Explore the beauty of nature.', 'Tempat X - Tempat Y - Tempat Z', '2020-01-01', '2020-01-03', 'City B', 2000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values ('Sample Package 3', 'A historical landmark.', 'Tempat P - Tempat Q - Tempat R', '2020-01-01', '2020-01-03', 'City C', 3000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values ('Sample Package 4', 'A family-friendly amusement park.', 'Tempat M - Tempat N - Tempat O', '2020-01-01', '2020-01-03', 'City D', 4000000);
insert into Package(PackageID, PackageName, PackageDesc, PackageStartDate, PackageEndDate, City, Price) values ('Sample Package 5', 'Experience fine dining.', 'Tempat G - Tempat H - Tempat I', '2020-01-01', '2020-01-03', 'City E', 5000000);

insert into ListVoucher(Username, VoucherID) values ('dleithharvey0', 1);
insert into ListVoucher(Username, VoucherID) values ('wdykes1', 1);
insert into ListVoucher(Username, VoucherID) values ('wdykes1', 1);
insert into ListVoucher(Username, VoucherID) values ('oshannahan2', 2);
insert into ListVoucher(Username, VoucherID) values ('btrivett3', 2);
insert into ListVoucher(Username, VoucherID) values ('eelphinston4', 2);
insert into ListVoucher(Username, VoucherID) values ('eelphinston4', 1);