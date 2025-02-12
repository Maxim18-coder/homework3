CREATE TABLE IF NOT EXISTS Genres (
    genre_id serial PRIMARY KEY,
    genres_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Musicians (
    musician_id serial PRIMARY KEY,
    musician_name VARCHAR(30) NOT NULL,
    alias VARCHAR(30) NOT NULL,
    genre_id INT REFERENCES Genres(genre_id),
    country VARCHAR(30) NOT NULL 
);

CREATE TABLE IF NOT EXISTS GenresMusicians (
    genre_id int NOT NULL REFERENCES Genres(genre_id),
    musician_id int NOT NULL REFERENCES Musicians(musician_id),
    PRIMARY KEY (genre_id, musician_id)
);

CREATE TABLE IF NOT EXISTS Albums (
    album_id serial PRIMARY KEY,
    album_name VARCHAR(30) NOT NULL,
    album_year INTEGER  
);

CREATE TABLE IF NOT exists AlbumMusician (
    album_id INT,
    musician_id INT,
    PRIMARY KEY (album_id, musician_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (musician_id) REFERENCES Musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS Collections (
    collection_id serial PRIMARY KEY,
    collection_name VARCHAR(30) NOT NULL,
    collection_year INTEGER
);

CREATE TABLE IF NOT EXISTS Songs (
    songs_id serial PRIMARY KEY,
    song_name VARCHAR(30) NOT NULL,
    duration INTEGER,
    album_id INT REFERENCES Albums(album_id),
    genre_id INT REFERENCES Genres(genre_id),
    UNIQUE (album_id, genre_id)  
);

CREATE TABLE IF NOT EXISTS MusicCollections (
    collection_id int NOT NULL REFERENCES Collections(collection_id),  
    songs_id int NOT NULL REFERENCES Songs(songs_id),
    PRIMARY KEY (collection_id, songs_id)
);