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