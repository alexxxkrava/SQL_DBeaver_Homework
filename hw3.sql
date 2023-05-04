CREATE TABLE IF NOT EXISTS Genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60)
	);

CREATE TABLE IF NOT EXISTS Performers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60)
	);

CREATE TABLE IF NOT EXISTS Albums (
	id SERIAL PRIMARY KEY,
	Name VARCHAR(60),
	Year_of_issue INT
	);

CREATE TABLE IF NOT EXISTS Songs (
	id SERIAL PRIMARY KEY,
	album_id INT NOT NULL REFERENCES Albums(id),
	name VARCHAR(60),
	duration INT
	);

CREATE TABLE IF NOT EXISTS Collections (
	id SERIAL PRIMARY KEY,
	Name VARCHAR(60),
	Year_of_issue INT
	);

CREATE TABLE IF NOT EXISTS Genre_Performer (
	Performer_id INT REFERENCES Performers(id),
	Genres_id INT REFERENCES Genres(id),
	CONSTRAINT pk1 PRIMARY KEY(Performer_id, Genres_id)
	);

CREATE TABLE IF NOT EXISTS Performer_Album (
	Performer_id INT REFERENCES Performers(id),
	Album_id INT REFERENCES Albums(id),
	CONSTRAINT pk2 PRIMARY KEY(Performer_id, Album_id)
	);

CREATE TABLE IF NOT EXISTS Collection_Song (
	Collection_id INT REFERENCES Collections(id),
	Song_id INT REFERENCES Songs(id),
	CONSTRAINT pk3 PRIMARY KEY(Collection_id, Song_id)
	);

INSERT INTO genres (name)
VALUES ('Rock'),('Rap'),('Pop'),('Jazz'),('Chanson');

INSERT INTO performers (name)
VALUES ('Linkin park'),
	   ('Green Day'),
       ('Fall out boy'), 
       ('Eminem'),
       ('BTS'),
       ('Rihanna'),
   	   ('Louis Armstrong'),
  	   ('Mikhail Krug');
 
INSERT INTO genre_performer (Performer_id, Genres_id)
VALUES(1,1),(1,2),(2,1),(3,1),(3,2),(4,2),(5,2),(5,3),(6,3),(7,4),(8,5);

INSERT INTO albums  (name, year_of_issue)
VALUES  ('Minutes to Midnight', 2007),
		('American Idiot', 2004),
		('Infinity on High', 2007), 
		('Revival', 2017),
		('Love Yourself: Tear', 2020),
		('Unapologetic', 2012),
		('Ella and Louis', 1956),
		('Rose', 1999);
		
INSERT INTO performer_album  (Performer_id, album_id)
VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8);

INSERT INTO songs (album_id, name, duration)
VALUES (1,'Leave Out All the Rest',	209),
	   (1,'Shadow of the Day', 289),
	   (2,'Holiday', 232),
	   (2,'Boulevard of Broken Dreams',	260),
	   (3,'Hum Hallelujah',	230),
	   (3,'Thnks fr th Mmr', 201),	   
	   (4,'Believe in my love', 315),
	   (4,'Heat', 250),	   
	   (5,'Fake love', 242),
	   (5,'Believe in my love', 234),	   
	   (6,'Diamonds', 226),
	   (6,'Pour It Up',	161),	   
	   (7,'Moonlight in Vermont', 220),
	   (7,'April in Pari', 393),	   
	   (8,'Summer day',	135);
	  
INSERT INTO collections (name, year_of_issue)
VALUES ('First', 2013),
	   ('Second', 2018),
	   ('Third', 2000),
	   ('Four', 2022),
	   ('Five', 2019),
	   ('Six', 2010),
	   ('Seven', 2016),
	   ('Eight', 2014);
	  
INSERT INTO collection_song (collection_id, song_id)
VALUES (1,1), (1,3), (2,4), (2,6), (3,14), (3,15), (4,16), (4,10), (5,12), (5,7), (6,6), (6,15), (7,1), (7,11), (8,2), (8,6);

SELECT name, year_of_issue
FROM albums
WHERE year_of_issue = 2018;

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

Количество исполнителей в каждом жанре.+++++
Количество треков, вошедших в альбомы 2019–2020 годов.+++++
Средняя продолжительность треков по каждому альбому.+++++
Все исполнители, которые не выпустили альбомы в 2020 году.+++++
Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).+++++
Названия альбомов, в которых присутствуют исполнители более чем одного жанра.+++++
Наименования треков, которые не входят в сборники.+++++
Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.+++++
Названия альбомов, содержащих наименьшее количество треков.+++++

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


SELECT a.name 
FROM (SELECT a2.name,  COUNT(s2.id) FROM albums a2
	LEFT JOIN songs s2 ON s2.album_id = a2.id
	GROUP BY a2.name) AS aq
WHERE count = (SELECT MIN(aq.count) FROM aq);

SELECT a2.name,  COUNT(s2.id) FROM albums a2
LEFT JOIN songs s2 ON s2.album_id = a2.id
GROUP BY a2.name
HAVING COUNT(s2.id) = (SELECT MIN(a2.COUNT) FROM a2)




















		















