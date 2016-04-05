DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS ParticipatedInMovie;

CREATE TABLE Directors (
    DirID           INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name            TEXT,
    Address         varchar(255),
    SpouseName      TEXT,
    FilmSchool      varchar(255),
    DGADate         DATE,
    FavLensMaker    varchar(255)
);

CREATE TABLE Actors (
    ActorID         INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name            TEXT,
    Address         varchar(255),
    DOB             DATE,
    HairColor       varchar(20),
    EyeColor        varchar(20),
    HeightIN       INT,
    Weight          INT,
    SpouseName      TEXT,
    FavColor        varchar(20),
    SAGADate        DATE
);

CREATE TABLE Movies (
    MovieID         INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name            TEXT,
    YearReleased    DATE,
    MPAANum         INT,
    DBOSales        DOUBLE,
    FBOSales        DOUBLE,
    DVDBRaySales    DOUBLE
);

CREATE TABLE ParticipatedInMovie (
    DirID int NOT NULL,
    ActorID int NOT NULL,
    MovieID int NOT NULL,
    FOREIGN KEY (DirID) REFERENCES Director(DirID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),  
);

/*

Functional Dependencies

Directors table
DirID --> Name, Address, SpouseName, FilmSchool, DGADate, FavLensMaker

Actors Table
ActorID --> Name, Address, DOB, HairColor, EyeColor, HeightIN, Weight, SpouseName, FavColor, SAGADate

Movies Table
MovieID --> Name, YearReleased, MPAANum, DBOSalesUSD, FBOSales, DVDBRaySales

ParticipatedInMovie
(DirID, ActorID, MovieID) --> Role

*/

SELECT *
FROM Directors d,
     Actors a,
     ParticipatedInMovie p
WHERE d.DirID = p.DirID,
      a.ActorID = p.ActorID,
      a.Name = 'Sean Connery';