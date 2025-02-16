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
    FROM Genremusicians gm
    JOIN Albums al ON gm.album_id = al.album_id
    WHERE al.album_year = 2020
);

SELECT DISTINCT co.collection_name /* Имена сборников */
FROM Collections co /* Из таблицы сборников */
JOIN AlbumMusician am ON co.collection_id = am.collection_id /* Объединяем с промежуточной таблицей между сборниками и альбомами */
JOIN Albums al ON am.album_id = al.album_id /* Объединяем с альбомами (необходимо с этим исправлением) */
JOIN Songs s ON al.album_id = s.album_id /* Объединяем с треками */
JOIN GenresMusicians gm ON s.genre_id = gm.genre_id /* Объединение с таблицей жанров и музыкантов */
JOIN Musicians ms ON gm.musician_id = ms.musician_id /* Объединяем с исполнителями */
WHERE ms.musician_name = 'Klaus';