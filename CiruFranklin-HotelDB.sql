-- Cirũ Franklin (she/they), Software Engineer 11/09/2022
-- Assessment: Hotel Schema

DROP DATABASE IF EXISTS CiruFranklinHotelDB;

CREATE DATABASE CiruFranklinHotelDB;

USE CiruFranklinHotelDB;

DROP TABLE IF EXISTS roomAmenity;
DROP TABLE IF EXISTS guestReservation;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS roomType;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS guest;
DROP TABLE IF EXISTS amenity;


CREATE TABLE roomType(
    typeId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL
);

CREATE TABLE room(
    roomId INT PRIMARY KEY AUTO_INCREMENT,
    roomNumber INT,
    typeId INT NOT NULL,
    FOREIGN KEY fk_room_roomType (typeId)
        REFERENCES roomType(typeId),
    adaAccessible boolean NOT NULL,
    standardOccupancy INT NOT NULL,
    maxOccupancy INT NOT NULL,
    basePrice Decimal(6, 2),
    pricePerAdditionalPerson Decimal(5,2)
);

CREATE TABLE amenity(
    amenityId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE roomAmenity(
    roomId INT,
    amenityId INT,
    PRIMARY KEY (roomId, amenityId),
    FOREIGN KEY fk_roomAmenity_room (roomId)
        REFERENCES room(roomId),
    FOREIGN KEY fk_roomAmenity_amenity (amenityId)
        REFERENCES amenity(amenityId)
);

CREATE TABLE guest(
    guestId INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    address VARCHAR(250),
    city VARCHAR(25),
    stateAbbr VARCHAR(25),
    zip VARCHAR(10),
    phoneNumber VARCHAR(10) NOT NULL
);

CREATE TABLE reservation(
    reservationId INT PRIMARY KEY AUTO_INCREMENT,
    roomId INT NOT NULL,
    FOREIGN KEY fk_reservation_room (roomId)
        REFERENCES room(roomId)
);

CREATE TABLE guestReservation(
    guestId INT,
    reservationId INT,
    PRIMARY KEY(guestId, reservationId),
    FOREIGN KEY fk_guestReservation_guest (guestId)
        REFERENCES guest(guestId),
    FOREIGN KEY fk_guestReservation_reservation (reservationId)
        REFERENCES reservation(reservationId)
);