DROP DATABASE IF EXISTS HotelReservation;

CREATE DATABASE HotelReservation;

USE HotelReservation;

CREATE TABLE IF NOT EXISTS `Customer` (
	`CustomerId` int(11) not null auto_increment,
	`FirstName` varchar(40) not null,
    `LastName` varchar(40) not null,
    `Phone` varchar(20) not null,
    `Email` varchar(45) not null,
    PRIMARY KEY (`CustomerId`)
); 

CREATE TABLE IF NOT EXISTS `PromoCode` (
	`PromoCodeId` int(11) not null auto_increment,
    `Description` varchar(40) not null,
    `DateBegin` date null,
    `DateEnd` date null,
    `Percent` decimal(4, 2) null, 
    `Dollar` decimal(6, 2) null,
    PRIMARY KEY (`PromoCodeId`)
);

CREATE TABLE IF NOT EXISTS `Guest` (
	`GuestId` int(11) not null auto_increment,
    `FirstName` varchar(40) not null,
    `LastName` varchar(40) not null,
    `Age` int(3) not null,
    PRIMARY KEY (`GuestId`)
);

CREATE TABLE IF NOT EXISTS `AddOnCost` (
	`AddOnCostId` int(11) not null auto_increment,
    `Description` varchar(40) not null,
    `DateBegin` date null,
    `DateEnd` date null,
    `Cost` decimal(6,2) not null,
    PRIMARY KEY (`AddOnCostId`)
);

CREATE TABLE IF NOT EXISTS `RoomType` (
	`RoomTypeId` int(11) not null auto_increment,
    `Description` varchar(15) not null,
    `OccupancyLimit` int(2) not null,
    PRIMARY KEY (`RoomTypeId`)
); 

CREATE TABLE IF NOT EXISTS `Amenities` (
	`AmenitiesId` int(11) not null auto_increment,
    `Description` varchar(20) not null,
    PRIMARY KEY (`AmenitiesId`)
); 

CREATE TABLE IF NOT EXISTS `Room` (
	`RoomId` int(11) not null auto_increment,
    `RoomTypeId` int(11) not null,
    `RoomFloor` int(2) not null,
    `RoomNumber` int(4) not null,
    PRIMARY KEY(`RoomId`)
);
ALTER TABLE `Room`
	ADD CONSTRAINT `fk_Room_RoomType` FOREIGN KEY(`RoomTypeId`) REFERENCES `RoomType`
    (`RoomTypeId`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `RoomTypeCost` (
	`RoomTypeCostId` int(11) not null auto_increment,
    `RoomTypeId` int(11) not null,
    `DateBegin` date null,
    `DateEnd` date null,
    `Cost` decimal(6,2) not null,
    PRIMARY KEY(`RoomTypeCostId`)
);
ALTER TABLE `RoomTypeCost`
	ADD CONSTRAINT `fk_RoomTypeCost_RoomType` FOREIGN KEY(`RoomTypeId`) REFERENCES `RoomType`
    (`RoomTypeId`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `RoomAmenities` (
	`RoomTypeId` int(11) not null,
    `AmenitiesId` int(11) not null,
    PRIMARY KEY(`RoomTypeId`, `AmenitiesId`)
);
ALTER TABLE `RoomAmenities` 
	ADD CONSTRAINT `fk_RoomAmenities_RoomType` FOREIGN KEY(`RoomTypeId`) REFERENCES `RoomType`
    (`RoomTypeId`) ON DELETE NO ACTION;
ALTER TABLE `RoomAmenities`
	ADD CONSTRAINT `fk_RoomAmenities_Amenities` FOREIGN KEY(`AmenitiesId`) REFERENCES `Amenities`
    (`AmenitiesId`) ON DELETE NO ACTION;
    
CREATE TABLE IF NOT EXISTS `Reservation` (
	`ReservationId` int(11) not null auto_increment,
    `CustomerId` int(11) not null,
    `PromoCodeId` int(11) not null,
	`DateBegin` date not null,
    `DateEnd` date not null,
    PRIMARY KEY(`ReservationId`)
);
ALTER TABLE `Reservation`
	ADD CONSTRAINT `fk_Reservation_Customer` FOREIGN KEY(`CustomerId`) REFERENCES `Customer`
    (`CustomerId`) ON DELETE NO ACTION;
ALTER TABLE `Reservation`
	ADD CONSTRAINT `fk_Reservation_Promo` FOREIGN KEY(`PromoCodeId`) References `PromoCode`
    (`PromoCodeId`) ON DELETE NO ACTION;
    
CREATE TABLE IF NOT EXISTS `OccupiedRoom`(
	`OccupiedRoomId` int(11) not null auto_increment,
    `RoomId` int (11) not null,
	`ReservationId` int(11) not null,
    PRIMARY KEY(`OccupiedRoomId`)
);
ALTER TABLE `OccupiedRoom`
	ADD CONSTRAINT `fk_OccupiedRoom_Room` FOREIGN KEY(`RoomId`) REFERENCES `Room`
    (`RoomId`) ON DELETE NO ACTION;
ALTER TABLE `OccupiedRoom`
	ADD CONSTRAINT `fk_OccupiedRoom_Reservation` FOREIGN KEY(`ReservationId`) REFERENCES `Reservation`
    (`ReservationId`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `ReservationGuests`(
	`ReservationId` int(11) not null,
    `GuestId` int(11) not null,
    PRIMARY KEY(`ReservationId`, `GuestId`)
);
ALTER TABLE `ReservationGuests` 
	ADD CONSTRAINT `fk_ReservationGuests_Reservation` FOREIGN KEY(`ReservationId`) REFERENCES `Reservation`
    (`ReservationId`) ON DELETE NO ACTION;
ALTER TABLE `ReservationGuests`
	ADD CONSTRAINT `fk_ReservationGuests_Guests` FOREIGN KEY(`GuestId`) REFERENCES `Guest`
    (`GuestId`) ON DELETE NO ACTION;

CREATE TABLE IF NOT EXISTS `AddOn` (
	`AddOnId` int(11) not null auto_increment,
    `Description` varchar(40) not null,
    `AddOnCostId` int(11) not null,
    PRIMARY KEY (`AddOnId`)
);
ALTER TABLE `AddOn`
	ADD CONSTRAINT `fk_AddOn_AddOnCost` FOREIGN KEY(`AddOnCostId`) REFERENCES `AddOnCost`
    (`AddOnCostId`) ON DELETE NO ACTION;
    
CREATE TABLE IF NOT EXISTS `ReservationAddOn`(
	`ReservationAddOnId` int(11) not null auto_increment,
    `ReservationId` int (11) not null,
    `AddOnId` int(11) not null,
    `Date` date not null,
    PRIMARY KEY(`ReservationAddOnId`)
);

ALTER TABLE `ReservationAddOn`
	ADD CONSTRAINT `fk_ReservationAddOn_Reservation` FOREIGN KEY(`ReservationId`) REFERENCES `Reservation`
    (`ReservationId`) ON DELETE NO ACTION;
ALTER TABLE `ReservationAddOn`
	ADD CONSTRAINT `fk_ReservationAddOn_AddOn` FOREIGN KEY(`AddOnId`) REFERENCES `AddOn`
    (`AddOnId`) ON DELETE NO ACTION;






    