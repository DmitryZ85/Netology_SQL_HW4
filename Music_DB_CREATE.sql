CREATE TABLE IF NOT EXISTS TypeOfMusic (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Singer (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS SingerTypeOfMusic (
	id SERIAL PRIMARY KEY,
	singer_id INTEGER NOT NULL REFERENCES Singer(id),
	typeofmusic_id INTEGER NOT NULL REFERENCES TypeOfMusic(id)
);

CREATE TABLE IF NOT EXISTS Album (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year INTEGER CHECK
		(year>1900)
);
	
CREATE TABLE IF NOT EXISTS AlbumSinger (
	id SERIAL PRIMARY KEY,
	singer_id INTEGER NOT NULL REFERENCES Singer(id),
	album_id INTEGER NOT NULL REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS Track (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	length NUMERIC(3, 2) CHECK
		(length>1.0 and length<20.0),
	album_id INTEGER NOT NULL REFERENCES Album(id)
);

CREATE TABLE IF NOT EXISTS SomeHits (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year INTEGER CHECK
		(year>1900)
);

CREATE TABLE IF NOT EXISTS TrackSomeHits (
	id SERIAL PRIMARY KEY,
	track_id INTEGER NOT NULL REFERENCES Track(id),
	hits_id INTEGER NOT NULL REFERENCES SomeHits(id)
);