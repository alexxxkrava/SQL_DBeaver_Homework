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
		('Love Yourself: Tear', 2018),
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
	   (4,'Believe', 315),
	   (4,'Heat', 250),	   
	   (5,'Fake love', 242),
	   (5,'Believe in my love', 234),	   
	   (6,'Diamonds', 226),
	   (6,'Pour It Up',	161),	   
	   (7,'Moonlight in Vermont', 220),
	   (7,'April in Pari', 393),	   
	   (8,'Summer day',	135),
	   (8,'Honest thief', 199);
	  
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







		















