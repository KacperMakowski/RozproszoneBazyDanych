select * from kursanci@dblinkfilia;

CREATE SYNONYM kursanciSiedziba FOR kursanci;
CREATE SYNONYM kursySiedziba FOR kursy;
CREATE SYNONYM rodzajeSiedziba FOR rodzaje;
CREATE SYNONYM wykladowcySiedziba FOR wykladowcy;

CREATE SYNONYM kursanciFilia FOR kursanci@dblinkfilia;
CREATE SYNONYM kursyFilia FOR kursy@dblinkfilia;
CREATE SYNONYM rodzajeFilia FOR rodzaje@dblinkfilia;
CREATE SYNONYM wykladowcyFilia FOR wykladowcy@dblinkfilia;

CREATE VIEW kursanciAll AS
SELECT imie, nazwisko from kursanciSiedziba 
UNION
SELECT imie, nazwisko from kursanciFilia;

CREATE VIEW wykladowcyAll AS
SELECT imie, nazwisko from wykladowcySiedziba 
UNION
SELECT imie, nazwisko from wykladowcyFilia;

--7 
CREATE OR REPLACE VIEW kursyAll AS
SELECT 
    r.nazwa AS nazwaKursu, 
    w.nazwisko AS prowadzacy, 
    (SELECT COUNT(*) FROM UMOWY u WHERE u.kurs_id = k.kurs_id) AS liczbaUczestnikow,
    'Siedziba' AS LOKALIZACJA 
FROM kursy k
JOIN rodzaje r ON k.rodzaj_id = r.rodzaj_id
JOIN wykladowcy w ON k.wykladowca_id = w.wykladowca_id

UNION ALL

SELECT 
    rf.nazwa AS nazwaKursu,
    wf.nazwisko AS prowadzacy,
    (SELECT COUNT(*) FROM umowy@dblinkfilia uf WHERE uf.KURS_ID = kf.KURS_ID) AS liczbaUczestnikow,
    'Filia' AS LOKALIZACJA
FROM KURSY@dblinkfilia kf
JOIN RODZAJE@dblinkfilia rf ON kf.RODZAJ_ID = rf.RODZAJ_ID
JOIN WYKLADOWCY@dblinkfilia wf ON kf.WYKLADOWCA_ID = wf.WYKLADOWCA_ID;



    


