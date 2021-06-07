CREATE TABLE wydawnictwo( wydawnictwo_id SERIAL PRIMARY KEY,
nazwa_wydawnictwa VARCHAR(32) NOT NULL );

INSERT INTO wydawnictwo(nazwa_wydawnictwa) values('Kruk');
INSERT INTO wydawnictwo(nazwa_wydawnictwa) values('Helion');
INSERT INTO wydawnictwo(nazwa_wydawnictwa) values('Znak');
