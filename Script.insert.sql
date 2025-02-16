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


