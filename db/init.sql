CREATE TABLE Users (
    Username VARCHAR(255) PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Name VARCHAR(255),
    Age INT
);

-- Create Licences first since Artists references it
CREATE TABLE Licences (
    Id SERIAL PRIMARY KEY,
    Genre VARCHAR(100)
);

CREATE TABLE Artists (
    Username VARCHAR(255) PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Name VARCHAR(255),
    Age INT,
    LicenceID INT,
    FOREIGN KEY (LicenceID) REFERENCES Licences(Id)
);

CREATE TABLE Songs (
    Path VARCHAR(500) PRIMARY KEY,
    Name VARCHAR(255),
    Genre VARCHAR(100),
    Type BOOLEAN,                        -- TRUE = Local, FALSE = Stream
    LyricsPath VARCHAR(500),
    ArtistUsername VARCHAR(255),
    LicenceID INT,
    FOREIGN KEY (ArtistUsername) REFERENCES Artists(Username),
    FOREIGN KEY (LicenceID) REFERENCES Licences(Id)
);

CREATE TABLE Playlists (
    PlaylistID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    OwnerUsername VARCHAR(255),          
    Type VARCHAR(10) NOT NULL CHECK (Type IN ('user', 'artist')),
    IsPublic BOOLEAN
);

CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongPath VARCHAR(500),
    PRIMARY KEY (PlaylistID, SongPath),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongPath) REFERENCES Songs(Path)
);

CREATE TABLE Follows (
    FollowerUsername VARCHAR(255),
    FolloweeUsername VARCHAR(255),
    PRIMARY KEY (FollowerUsername, FolloweeUsername),
    FOREIGN KEY (FollowerUsername) REFERENCES Users(Username),
    FOREIGN KEY (FolloweeUsername) REFERENCES Users(Username)
);