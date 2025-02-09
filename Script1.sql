create table if not exist Genres(
    genre_id serial primary key,
    VARCHAR(30) NOT  NULL
);
create table if not exist Musicians(
    musician_id serial primary key,
    VARCHAR(30) NOT  NULL
);
create table if not exist GenresMusicians(
   genre_id int not null references Genres(genre_id),
   musician_id int not null references Musicians(musician_id),
   primary key(genre_id, musician_id)
);
create table if not exist Albums(
    album_id serial primary key,
    VARCHAR(30) NOT  NULL,
    album_year INTEGER
);
create table if not exist AlbumMusician(
    album_id int not null references Album(album_id),
    primary key(album_id)
);
create table if not exist Collections(
    collection_id serial primary key,
    collection_name VARCHAR(30) NOT  NULL,
    collection_year VARCHAR(30) NOT  NULL,
);
create table if not exist Songs(
    songs_id serial primary key,
    song_name VARCHAR(30) NOT  NULL,
    duration INTEGER
    album_id INT REFERENCES Album(album_id)
);
create table if not exist MusicCollections(
    collection_id int not null references Collections(collection_id),
    songs_id int not null references Songs(songs_id),
    primary key(collection_id, songs_id)
);




select song_name, duration
from Songs
order by duration desk
limit 1;

select song_name, duration
from Songs
where duration >= 210;

select collection_name 
from Collection
where collection_yaer beetween 2018 and 2020;

select musician_name
from Musicians
where musician_name not like "%%";

select song
from Songs
where song_name like "%мой%" or like "%my%";

select g.genre_name count (a.musician_id) as musician_count
from genres.g
join album_id al on g.genre_id = al.genre_id
join songs_id s on al.album_id = s.album_id
join musicians_id ms on s.musicians_id = ms.musicians_id
group by g.genre_name;

select count(s.song_id) on song_count
from s.song
join album al on s.album_id = al.album_id
where song_name between 2019 and 2020;

SELECT al.album_name, AVG(s.duration) as average_duration
FROM albums al
JOIN songs s ON al.album_id = s.album_id
GROUP BY al.album_name;

SELECT a.name
FROM musicians a
WHERE a.musicians_id NOT IN (
    SELECT DISTINCT s.musician_id
    FROM songs s
    JOIN albums al ON s.album_id = al.album_id
    WHERE al.slbum_year = 2020
);

SELECT DISTINCT al.album_name
FROM albums al
JOIN songs s ON al.album_id = s.album_id
JOIN musicians ms ON s.artist_id = ms.musicians_id
WHERE ms.name = 'Klaus';
