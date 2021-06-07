CREATE TABLE autor
             (
                          autor_id SERIAL PRIMARY KEY
                        , imie           VARCHAR(32) NOT NULL
                        , nazwisko       VARCHAR(32) NOT NULL
                        , data_urodzenia DATE
             )
;

INSERT INTO autor
       (imie
            , nazwisko
            , data_urodzenia
       )
       values
       ('Henryk'
            ,'Sienkiewicz'
            , TO_DATE('05/05/1846', 'DD/MM/YYYY')
       )
;

INSERT INTO autor
       (imie
            , nazwisko
            , data_urodzenia
       )
       values
       ('Julian'
            ,'Tuwim'
            , TO_DATE('13/09/1894', 'DD/MM/YYYY')
       )
;