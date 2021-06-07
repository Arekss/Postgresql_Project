

CREATE TABLE kolejka( czytelnik_id INTEGER NOT NULL REFERENCES czytelnik(czytelnik_id),
				      ksiazka_id INTEGER NOT NULL REFERENCES ksiazka(ksiazka_id));
					  



CREATE OR REPLACE FUNCTION sprawdz_duplikaty() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN 
 
PERFORM * FROM kolejka WHERE czytelnik_id = NEW.czytelnik_id AND ksiazka_id = NEW.ksiazka_id;
  IF NOT FOUND THEN
  ELSE
   raise exception 'Czytelnik o id % już czeka na ksiazke o id % !!', NEW.czytelnik_id, NEW.ksiazka_id;
  END IF;

 
 RETURN NEW;
END;
$$;


CREATE TRIGGER trig_duplikaty_BI BEFORE INSERT ON kolejka
FOR EACH ROW EXECUTE PROCEDURE sprawdz_duplikaty(); 