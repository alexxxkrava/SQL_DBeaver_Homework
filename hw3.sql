SELECT name, year_of_issue
FROM albums
WHERE year_of_issue = 2020;

SELECT name, duration
FROM songs
WHERE duration = (SELECT max(duration) FROM songs);

SELECT name
FROM songs
WHERE duration > 209;

SELECT name 
FROM collections
WHERE year_of_issue BETWEEN 2018 AND 2020;

SELECT name 
FROM performers
WHERE name NOT LIKE '% %';

SELECT name
FROM songs
WHERE name LIKE '%my%';

SELECT name, count(performer_id) FROM genre_performer gp
LEFT JOIN genres g ON gp.genres_id = g.id
GROUP BY name
ORDER BY count DESC;

SELECT a.name, COUNT(s.id) FROM albums a 
LEFT JOIN songs s ON a.id = s.album_id 
WHERE year_of_issue BETWEEN 2018 AND 2020
GROUP BY a.name;

SELECT a.name, AVG(s.duration) FROM albums a 
LEFT JOIN songs s ON a.id = s.album_id
GROUP BY a.name;

SELECT p.name, a.year_of_issue FROM performer_album pa  
JOIN performers p ON pa.performer_id = p.id 
JOIN albums a ON pa.album_id = a.id
WHERE year_of_issue <> 2020; 

SELECT c.name FROM collection_song cs 
JOIN collections c ON c.id = cs.collection_id 
JOIN songs s ON s.id = cs.song_id
JOIN albums a ON a.id = s.album_id 
JOIN performer_album pa ON a.id = pa.album_id 
JOIN performers p ON pa.performer_id = p.id 
WHERE p.name LIKE 'Linkin park'; 

SELECT DISTINCT a.name FROM albums a 
JOIN performer_album pa ON a.id = pa.album_id 
JOIN performers p ON pa.performer_id = p.id
JOIN genre_performer gp ON p.id = gp.performer_id 
JOIN genres g ON gp.genres_id = g.id 
WHERE (SELECT COUNT(gp2.genres_id) FROM genre_performer gp2) > 1;

SELECT s.name  FROM songs s 
LEFT JOIN collection_song cs ON cs.song_id = s.id
WHERE cs.collection_id IS NULL; 

SELECT p.name FROM performers p
JOIN performer_album pa ON p.id = pa.performer_id
JOIN albums a ON a.id = pa.album_id
JOIN songs s ON a.id = s.album_id
WHERE s.duration = (SELECT MIN(s2.duration) FROM songs s2);

SELECT a.name, count(s.album_id)  FROM albums a 
JOIN songs s ON a.id = s.album_id 
GROUP BY a."name"
HAVING  count(s.album_id) = (SELECT count(s2.id)  FROM songs s2 GROUP BY s2.album_id ORDER BY s2.album_id DESC LIMIT 1)































		















