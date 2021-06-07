CREATE TABLE czytelnik( czytelnik_id SERIAL PRIMARY KEY, 
					imie VARCHAR(32) NOT NULL,
					nazwisko VARCHAR(32) NOT NULL,
					naliczone_oplaty numeric DEFAULT 0.00);
					
INSERT INTO czytelnik(imie, nazwisko) values('Adam','Abacki');
INSERT INTO czytelnik(imie, nazwisko) values('Baam','Backi');
INSERT INTO czytelnik(imie, nazwisko) values('Czadam','Corbacki');
INSERT INTO czytelnik(imie, nazwisko) values('Dariusz','Dudek');