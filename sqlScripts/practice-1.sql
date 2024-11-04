CREATE TABLE tblCharacters
(
	CharacterID VARCHAR(50),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    ShowTitle VARCHAR(100),
    PRIMARY KEY (CharacterID)
);
DROP table tblCharacters;
CREATE TABLE tblShows
(
		ShowID VARCHAR(25),
        ShowTitle VARCHAR(250),
        StartYear INT,
        PRIMARY KEY (ShowID)
);
SELECT * FROM tblShows;
SELECT * FROM tblCharacters;
CREATE TABLE tblCharacters 
(
	CharacterID VARCHAR(25),
    FirstName VARCHAR(25),
    LastName VARCHAR(35),
    ShowID VARCHAR(25),
    PRIMARY KEY(CharacterID),
    FOREIGN KEY(ShowID) REFERENCES tblShows(ShowID)
);

INSERT INTO tblShows VALUES('TMNT1','Teenage Mutant Ninja Turtles',1987);
INSERT INTO tblShows VALUES('TSIMP1','The Simpsons',1989);
INSERT INTO tblShows VALUES('FUT1','FUTURAMA',TRUE);
DELETE FROM tblShows WHERE ShowID='TMNT1';
UPDATE tblShows SET StartYear = 1999 WHERE ShowID='FUT1';

INSERT INTO tblCharacters VALUES ('Mike87','Michaelangelo','Turtle','TMNT1');
-- When encountering stuff like referencing, there is such a thing as a constraint, that blocks incorrect foriegn keys from being entered
INSERT INTO tblCharacters VALUES ('Leo87','Leonardo','Turtle','TMNT1');
INSERT INTO tblCharacters VALUES ('Bend99','Bender','Rodreiguez','FUT1');
-- Join something that will allow you to mesh two tables together (in an imaginary table) so you can visualize stuff
SELECT * FROM tblCharacters JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID;
-- doing it opposite inverts the table
SELECT * FROM tblShows JOIN tblCharacters ON tblShows.ShowID = tblCharacters.ShowID;
-- doing a left join sets the 
SELECT * FROM tblCharacters LEFT JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID;
-- doing a right join attaches the new on to the right of the original
SELECT * FROM tblCharacters RIGHT JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID;
-- Only shows the TMNT characters
SELECT * FROM tblCharacters LEFT JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID WHERE tblCharacters.ShowID='TMNT1';
-- Shows nothing since no simpsons charactters were not inserted
SELECT * FROM tblCharacters LEFT JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID WHERE tblCharacters.ShowID='SIMP1';
-- You have to think about the effct this is going to have when you try to run the join
SELECT * FROM tblCharacters LEFT JOIN tblShows ON tblCharacters.ShowID = tblShows.ShowID WHERE tblCharacters.ShowID='FUT1';

CREATE TABLE tblArtists
(
	ArtistGUID VARCHAR(32),
    Name VARCHAR(100),
    Genre VARCHAR(32),
    PRIMARY KEY (ArtistGUID)
);
CREATE TABLE tblAlbum
(
	AlbumID VARCHAR(32),
    AlbumName VARCHAR(100),
    PrimaryArtist VARCHAR(32),
    PrimaryGenre VARCHAR(32),
    PRIMARY KEY (AlbumID),
    FOREIGN KEY(PrimaryArtist) REFERENCES tblArtists(ArtistGUID),
    FOREIGN KEY(PrimaryGenre) REFERENCES tblGenre(GenreID)
);
CREATE TABLE tblGenre
(
	GenreID VARCHAR(32),
    Description VARCHAR(50),
    PRIMARY KEY(GenreID)
);



