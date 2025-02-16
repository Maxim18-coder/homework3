INSERT INTO Musicians (musician_name, alias, country) VALUES
('Scorpions', 'Klaus Alias', 'Germany'),
('TheWeeknd', 'Abel', 'Canada'),
('Rammstein', 'Till', 'Germany'),
('Aeterna', 'Anastasiya', 'Russia');

INSERT INTO Genres (genres_name) VALUES
('Rock'),
('Pop'),
('Rock'),
('Folk');

INSERT INTO Albums (album_name, album_year) VALUES
('Peacemaker', '2020'),
('Starboy', '2018'),
('Sonne', '2014'),
('Confession Of Loki', '2019');

INSERT INTO Songs (song_name, duration, album_id) values
('Peacemaker', '239', '1'),
('When you know', '246', '1'),
('intro', '92', '4'),
('my main', '177','2'),
('Confession Loki', '416', '4'),
('мой путь', '209', '3');


INSERT INTO Collections (collection_name , collection_year) values
('GoldBallads', '2020'),
('Aeternastory', '2018'),
('Sonne', '2018'),
('NormalGuy', '2017');

INSERT INTO GenresMusicians (genre_id, musician_id) values
('1', '1'),
('2', '2'),
('3', '1'),
('4', '3');

INSERT INTO AlbumMusician (album_id, musician_id) values
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4');

INSERT INTO MusicCollections (collection_id, songs_id) values
('1', '1'),
('1', '2'),
('2', '3'),
('2', '5'),
('3', '4'),
('4', '6');

CREATE TABLE IF NOT EXISTS Genres (
    genre_id serial PRIMARY KEY,
    genres_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Musicians (
    musician_id serial PRIMARY KEY,
    musician_name VARCHAR(30) NOT NULL,
    alias VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL 
);

CREATE TABLE IF NOT EXISTS GenresMusicians (
    album_id int NOT NULL references Albums(album_id),
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
    album_id INT REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS MusicCollections (
    collection_id int NOT NULL REFERENCES Collections(collection_id),  
    songs_id int NOT NULL REFERENCES Songs(songs_id),
    PRIMARY KEY (collection_id, songs_id)
);

SELECT song_name, duration
    FROM Songs
    ORDER BY duration desc 
    LIMIT 1;

SELECT song_name, duration
    FROM Songs
    WHERE duration >= 210;

SELECT collection_name 
FROM Collections 
WHERE collection_year::INTEGER >= 2018 AND collection_year::INTEGER <= 2020;

SELECT musician_name
   FROM Musicians
   WHERE musician_name IS NOT NULL AND musician_name <> '';

SELECT song_name /* Имя трека из таблицы треков */
FROM Songs
WHERE song_name ILIKE 'мой %' /* Где слово в начале строки */
OR song_name ILIKE '% мой' /* Где слово в конце строки */
OR song_name ILIKE '% мой %' /* Где слово в середине строки */
OR song_name ILIKE 'мой' /* Где название трека состоит из одного искомого слова */
OR song_name ILIKE 'my %' /* Где слово в начале строки для "my" */
OR song_name ILIKE '% my' /* Где слово в конце строки для "my" */
OR song_name ILIKE '% my %' /* Где слово в середине строки для "my" */
OR song_name ILIKE 'my'; /* Где название трека состоит из одного искомого слова для "my" */;

SELECT g.genres_name, COUNT(ms.musician_id) AS musician_count
   FROM Genres g
   JOIN GenresMusicians gm ON g.genre_id = gm.genre_id
   JOIN Musicians ms ON gm.musician_id = ms.musician_id
   GROUP BY g.genres_name;

SELECT COUNT(s.songs_id) AS song_count
   FROM Songs s
   JOIN Albums al ON s.album_id = al.album_id
   WHERE al.album_year BETWEEN 2019 AND 2020;

SELECT al.album_name, AVG(s.duration) as average_duration
    FROM albums al
    JOIN songs s ON al.album_id = s.album_id
    GROUP BY al.album_name;

SELECT m.musician_name
FROM Musicians m
WHERE m.musician_id NOT IN (
    SELECT gm.musician_id
    FROM GenresMusicians gm
    JOIN Albums al ON al.album_id = al.album_id
    WHERE al.album_year = 2020
);

SELECT DISTINCT co.collection_name /* Имена сборников */
FROM Collections co /* Из таблицы сборников */
JOIN AlbumMusician am ON co.collection_id = co.collection_id /* Объединяем с промежуточной таблицей между сборниками и альбомами */
JOIN Albums al ON am.album_id = al.album_id /* Объединяем с альбомами (необходимо с этим исправлением) */
JOIN Songs s ON al.album_id = s.album_id /* Объединяем с треками */
JOIN GenresMusicians gm ON gm.genre_id = gm.genre_id /* Объединение с таблицей жанров и музыкантов */
JOIN Musicians ms ON gm.musician_id = ms.musician_id /* Объединяем с исполнителями */
WHERE ms.musician_name = 'Klaus';