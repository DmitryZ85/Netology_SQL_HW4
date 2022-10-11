
 --   количество исполнителей в каждом жанре;
SELECT name, COUNT(singer_id) singer_q FROM typeofmusic t
JOIN singertypeofmusic st ON st.typeofmusic_id = t.id 
GROUP BY t.name;

 --   количество треков, вошедших в альбомы 2019-2020 годов;
SELECT COUNT(t.name) track_q from track t
JOIN album a ON a.id = t.album_id
WHERE a.year BETWEEN 2019 AND 2020;
	
 --   средняя продолжительность треков по каждому альбому;
SELECT a.name album_name, AVG(length) length_avg from track t
JOIN album a ON a.id = t.album_id
GROUP BY a.name;
	
 --   все исполнители, которые не выпустили альбомы в 2020 году;
SELECT s.name singer_nm, a.year from singer s
JOIN albumsinger a2 ON a2.singer_id = s.id
JOIN album a ON a.id = a2.album_id 
WHERE a.year != 2020;

 --   названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT h.name, s.name from somehits h
LEFT JOIN tracksomehits th ON h.id = th.hits_id
LEFT JOIN track t ON t.id = th.track_id
LEFT JOIN album a ON a.id = t.album_id
LEFT JOIN albumsinger a2 ON a2.album_id = a.id
LEFT JOIN singer s ON s.id = a2.singer_id
WHERE s.name LIKE '%Eminem%'
GROUP BY h.name, s.name;

--   название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT a.name FROM album a 
LEFT JOIN albumsinger a2 ON a2.album_id = a.id
LEFT JOIN singer s ON s.id = a2.singer_id
LEFT JOIN singertypeofmusic st ON st.singer_id = s.id
GROUP BY a.name
HAVING COUNT(DISTINCT st.typeofmusic_id) > 1;

--   наименование треков, которые не входят в сборники;
SELECT t.name FROM track t
LEFT JOIN tracksomehits th ON th.track_id = t.id
WHERE th.track_id IS NULL;
	
 --   исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT s.name, t.length FROM track t
LEFT JOIN album a ON a.id = t.album_id
LEFT JOIN albumsinger a2 ON a2.album_id = a.id
LEFT JOIN singer s ON s.id = a2.singer_id
GROUP BY s.name, t.length 
HAVING t.length = (
	SELECT MIN(length) FROM track
)
ORDER BY s."name";

-- название альбомов, содержащих наименьшее количество треков.
SELECT DISTINCT a.name FROM album a
LEFT JOIN track t ON t.album_id = a.id
WHERE t.album_id IN (
	SELECT album_id FROM track
	GROUP BY album_id
	HAVING COUNT(id) = (
		SELECT COUNT(id) FROM track
		GROUP BY album_id
		ORDER BY COUNT
		LIMIT 1
	)
)
ORDER BY a.name;

