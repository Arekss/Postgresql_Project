CREATE TABLE gatunek( gatunek_id SERIAL, 
					nazwa_gatunku VARCHAR(32) NOT NULL,
					gatunek_nadrzedny VARCHAR(32),
					CONSTRAINT gatunek_pk PRIMARY KEY(gatunek_id));
					

INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('epika', null);
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('liryka', null);
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('dramat', null);
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('nowela', 'epika');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('opowiadanie', 'epika');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('powiesc', 'epika');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('tren', 'liryka');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('fraszka', 'liryka');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('tragedia', 'dramat');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('komedia', 'dramat');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('powiesc_auktorialna', 'powiesc');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('powiesc_pierwszoosobowa', 'powiesc');
INSERT INTO gatunek(nazwa_gatunku, gatunek_nadrzedny) values ('powiesc_personalna', 'powiesc');

