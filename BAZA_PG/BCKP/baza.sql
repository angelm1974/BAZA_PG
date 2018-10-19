--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

-- Started on 2018-10-19 14:20:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 482 (class 1255 OID 6059047)
-- Name: akcja1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.akcja1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
IF TG_OP = 'UPDATE'  THEN
IF new.rozliczony= TRUE then
update r_plan_temp set zrobione = 1 where r_plan_temp.id_rysunek = old.id_rysunki ;
END IF ;

END IF ;

RETURN new ;
END ;$$;


ALTER FUNCTION public.akcja1() OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 6059048)
-- Name: cenarysunku(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cenarysunku(character varying) RETURNS numeric
    LANGUAGE sql
    AS $_$select CAST(cena as numeric) 
From ceny_rys 
Where rodzajrys = $1
$_$;


ALTER FUNCTION public.cenarysunku(character varying) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 6059049)
-- Name: createtreepath(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.createtreepath(integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
declare
in_leaf_id ALIAS FOR $1;
temprec RECORD;
reply TEXT;
BEGIN
reply := '/';
FOR temprec IN SELECT k.name FROM tree_categories k join tree_relations p on k.id = p.parent_id WHERE p.child_id = in_leaf_id ORDER BY p.depth desc LOOP
reply := reply || temprec.name || '/';
END LOOP;
RETURN reply;
END;
$_$;


ALTER FUNCTION public.createtreepath(integer) OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 6059050)
-- Name: dodaj_gotowe(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dodaj_gotowe() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
IF TG_OP = 'INSERT'  THEN
IF new.zliczony2= 'ROZLICZONY' then
update rysunki2 set zrobione = 1 where rysunki2.id = new.id ;
new.zrobione=1;
END IF ;

END IF ;

RETURN new ;
END ;$$;


ALTER FUNCTION public.dodaj_gotowe() OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 6059051)
-- Name: efekty_koszty_ogolne(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.efekty_koszty_ogolne() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

--# DOKUMENTACJE # --
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'DOKUMENTACJE',0,-1,0,'DOKUMENTACJE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Projekt mechaniczny',1,-1,2,'DOKUMENTACJE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Projekt uzbrojenia',2,-1,2,'DOKUMENTACJE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Projekt pneumatyki',3,-1,2,'DOKUMENTACJE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Projekt hydrauliczny',4,-1,2,'DOKUMENTACJE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Projekt elektryczny i sterowania',5,-1,2,'DOKUMENTACJE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Dokumentacja kooperacyjna',6,-1,0,'DOKUMENTACJE'); 

--# KOSZTY OGÓLNE #  EFEKTY--
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'KOSZTY OGÓLNE',0,98,0, 'KOSZTY OGÓLNE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Przygotowanie materiału',1,98,2, 'KOSZTY OGÓLNE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Pomocnicze',2,98,2, 'KOSZTY OGÓLNE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Piaskowanie',3,98,0, 'KOSZTY OGÓLNE'); 
--# usunięte na prośbę JL 12.06.16 INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Malowanie',4,98,2, 'KOSZTY OGÓLNE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Farba',5,98,0, 'KOSZTY OGÓLNE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Transport',6,98,0, 'KOSZTY OGÓLNE'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Pakowanie',7,98,2, 'KOSZTY OGÓLNE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Doradztwo',8,98,0, 'KOSZTY OGÓLNE');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Delegacje',9,98,0, 'KOSZTY OGÓLNE');

--# URUCHOMIENIE + SERWIS GWARANCYJNY # -- 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc,  el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'URUCHOMIENIE + SERWIS GWARANCYJNY',0,99,0, 'URUCHOMIENIE + SERWIS GWARANCYJNY'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc,  el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Montaż linii i testy produkcyjne',1,99,2, 'URUCHOMIENIE + SERWIS GWARANCYJNY'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc,  el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Uruchomienie u klienta',2,99,2, 'URUCHOMIENIE + SERWIS GWARANCYJNY');
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc,  el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Serwis gwarancyjny',3,99,2, 'URUCHOMIENIE + SERWIS GWARANCYJNY'); 
INSERT INTO efekty (id_kontrakt, of_ciez, of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc,  el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id,0,0,0,0,0,0, 'Dojazd do klienta',4,99,2, 'URUCHOMIENIE + SERWIS GWARANCYJNY'); 

--# KOSZTY OGÓLNE #  STRUKTURA--
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Przygotowanie wsadu', 'KOG'::character varying,1, (new.id), (new.id ),1);
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Pomocnicze', 'KOG'::character varying,2, (new.id ), (new.id ),2);
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Piaskowanie', 'KOG'::character varying,3, (new.id ), (new.id ),3);
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Gradowanie', 'KOG'::character varying,4, (new.id ), (new.id ),4);
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Malowanie', 'KOG'::character varying,5, (new.id), (new.id ),5);
INSERT INTO struktura_kontraktu (nazwa, rodzaj_objektu, id_obiektu, zaleznosc_obiektu, id_kontrakt, kolejnosc) VALUES ('Transport', 'KOG'::character varying,6, (new.id ), (new.id ),6);


 RETURN new ;
END ;
$$;


ALTER FUNCTION public.efekty_koszty_ogolne() OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 6059052)
-- Name: efekty_zespoly(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.efekty_zespoly() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

if new.numer =0 THEN

IF TG_OP = 'INSERT'  THEN
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Materiały' , 1, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Dostawy' , 2, new.numer,1,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Kooperacja' , 3, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Robocizna' , 4, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Montaż' , 5, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Koszty błędów' , 6, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Przygotowanie produkcji' , 7, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Malowanie' , 8, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
	INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt ,of_ciez,  of_wartosc, przew_ciez, przew_wartosc, rozl_ciez, rozl_wartosc) VALUES (new.id_kontrakt, new.id, 'Przygotowanie do malowania' , 9, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0,0,0,0,0,0) ; 
END IF ;

IF TG_OP = 'UPDATE'  THEN
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu, flaga1=0,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=0;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  obiekt= 'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu  WHERE id_zespol=old.id;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Materiały', flaga1=1,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=1;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Dostawy', flaga1=2,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=2;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Kooperacja', flaga1=3,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=3;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Robocizna', flaga1=4,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=4;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Montaż', flaga1=5,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=5;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Koszty błędów', flaga1=6,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=6;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Przygotowanie produkcji', flaga1=7,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=7;
	UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Malowanie', flaga1=8,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=8;
	
END IF ;


END IF ;





if new.numer <>0 THEN


	IF TG_OP = 'INSERT'  THEN
		if new.typ = 0 THEN
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Materiały' , 1, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Dostawy' , 2, new.numer,1,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Kooperacja' , 3, new.numer,0,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Robocizna' , 4, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Montaż' , 5, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Koszty błędów' , 6, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Przygotowanie produkcji' , 7, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Malowanie' , 8, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Przygotowanie do malowania' , 9, new.numer,2,'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
		END IF ;
		
		if new.typ = 1 THEN
		--# DOKUMENTACJE # --

			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ,0, new.numer,0,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Dokumentacja techniczna' , 1, new.numer,0,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Materiały' , 2, new.numer,0,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Dostawy' , 3, new.numer,1,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Kooperacja' , 4, new.numer,0,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Robocizna' , 5, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Montaż' , 6, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Koszty błędów' , 7, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Przygotowanie produkcji' , 8, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Malowanie' , 9, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Przygotowanie do malowania' , 10, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Przygotowanie materiału' , 11, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Farba' , 12, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Transport' , 13, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Pakowanie' , 14, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Delegacje' , 15, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
			INSERT INTO efekty (id_kontrakt, id_zespol, el_kalkulacji, flaga1,flaga2,flagatyp,obiekt) VALUES (new.id_kontrakt, new.id, 'Uruchomienie u klienta' , 16, new.numer,2,'SERWIS ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu ) ; 
		END IF;
	END IF;

IF TG_OP = 'UPDATE'  THEN
	if old.typ = 0 THEN
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu, flaga1=0,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=0;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  obiekt= 'ZESPÓŁ ' || to_char(new.numer, 'FM09') || '  ' || new.nazwa_zespolu  WHERE id_zespol=old.id;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Materiały', flaga1=1,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=1;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Dostawy', flaga1=2,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=2;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Kooperacja', flaga1=3,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=3;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Robocizna', flaga1=4,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=4;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Montaż', flaga1=5,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=5;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Koszty błędów', flaga1=6,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=6;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Przygotowanie produkcji', flaga1=7,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=7;
		UPDATE efekty set id_kontrakt= new.id_kontrakt,  el_kalkulacji='Malowanie', flaga1=8,flaga2= new.numer WHERE id_zespol=old.id AND flaga1=8;
	END IF ;
END IF ;


END IF ;

RETURN new ;
END;$$;


ALTER FUNCTION public.efekty_zespoly() OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 6059053)
-- Name: iff(boolean, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.iff(boolean, text, text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
   BEGIN
      IF $1 = true THEN
         RETURN $2;
      ELSE
         RETURN $3;
      END IF;
   END;
$_$;


ALTER FUNCTION public.iff(boolean, text, text) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 6059054)
-- Name: ifo(boolean, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ifo(boolean, integer, integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
   BEGIN
      IF $1 = true THEN
         RETURN $2;
      ELSE
         RETURN $3;
      END IF;
   END;
$_$;


ALTER FUNCTION public.ifo(boolean, integer, integer) OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 6059055)
-- Name: kontrah(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kontrah(text) RETURNS text
    LANGUAGE sql
    AS $_$select CAST (nazwa as TEXT) 

From kontrahent2 

Where znak = $1;$_$;


ALTER FUNCTION public.kontrah(text) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 6059056)
-- Name: kontrakt_lbl(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kontrakt_lbl(bigint) RETURNS text
    LANGUAGE sql
    AS $_$select CAST (nrlabel as TEXT) 

From kontrakt2 

Where id = $1;$_$;


ALTER FUNCTION public.kontrakt_lbl(bigint) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 6059057)
-- Name: kontrakt_temat(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kontrakt_temat(integer) RETURNS text
    LANGUAGE sql
    AS $_$select CAST (temat as TEXT) 

From kontrakt2 

Where id = $1;$_$;


ALTER FUNCTION public.kontrakt_temat(integer) OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 6059058)
-- Name: kontrtest(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kontrtest() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
 kontrkt kontrakt2%ROWTYPE;


BEGIN

if new.numer IS NULL OR new.numer <1
THEN RAISE EXCEPTION ' Pole [Numer kontraktu] ma złą wartość !!! ' ;
END IF;

if new.numer IS NULL OR length(trim(new.temat)) <1
THEN RAISE EXCEPTION ' Pole [Temat] nie może być puste !!! ' ;
END IF;


 
SELECT INTO kontrkt * FROM kontrakt2 WHERE kontrakt2.znak = new.znak AND kontrakt2.numer=new.numer; 
IF NOT FOUND 
THEN 
 RETURN new;
ELSE 
         IF TG_OP = 'INSERT'  THEN
             RAISE EXCEPTION ' Taki Identyfikator kontraktu już istnieje !!! '  ;
          END IF;
     
          IF TG_OP = 'UPDATE'  THEN
              IF new.znak = old.znak AND  new.numer = old.numer THEN
                  RETURN new ;
              ELSE 
                   RAISE EXCEPTION 'Taki Identyfikator kontraktu już istnieje !!! ' ;
              END IF;
          END IF;
END IF;

END;

$$;


ALTER FUNCTION public.kontrtest() OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 6059059)
-- Name: koszty_pola(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.koszty_pola() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
if new.numer <>0 THEN
INSERT INTO koszty_ogolne  (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Przygotowanie',null,null,new.id,1,1);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Pomocnicze',null,null,new.id,2,1);
-- INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc) VALUES ('Piaskowanie',null,null,new.id,3);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa)  VALUES ('Przygotowanie do malowania',null,null,new.id,4,1);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Malowanie',null,null,new.id,5,1);
-- INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc) VALUES ('Transport',null,null,new.id,6);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc,grupa) VALUES ('Montaż linii i testy produkcyjne',null,null,new.id,7,2);
-- INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc) VALUES ('Doradztwo',null,null,new.id,8);
-- INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc) VALUES ('Zbiorcza obróbka ślusarska',null,null,new.id,9);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Uruchomienie u klienta',null,null,new.id,10,2);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Pakowanie',null,null,new.id,11,1);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Dojazd do klienta',null,null,new.id,12,2);
INSERT INTO koszty_ogolne (nazwa, zaplanowane, wykonane, id_kontrakt, kolejnosc, grupa) VALUES ('Serwis gwarancyjny',null,null,new.id,13,1);

END IF ;
RETURN new ;
END ;$$;


ALTER FUNCTION public.koszty_pola() OWNER TO postgres;

--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION koszty_pola(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.koszty_pola() IS 'Trzeba dopisać procedure dla update''u';


--
-- TOC entry 494 (class 1255 OID 6059060)
-- Name: label_rysunki(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.label_rysunki() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
 rysnk rysunki2%ROWTYPE;
 zesp zespoly%ROWTYPE;
 mini INTEGER;
maxi INTEGER;
temp_str VARCHAR; 
mini_maks VARCHAR; 
label VARCHAR; 

rozn  INTEGER;
rysnr INTEGER;

BEGIN
if new.numer_rys=0
THEN new.nazwa_rysunku := 'RYSUNEK ZESTAWIENIOWY' ;
END IF;

if new.nazwa_rysunku IS NULL OR length(trim(new.nazwa_rysunku)) <1
THEN RAISE EXCEPTION ' Pole [*Nazwa Rysunku] nie może być puste !!! ' ;
END IF;

if new.rodzaj_rys  IS NULL
THEN RAISE EXCEPTION ' Pole [*Rodzaj rysunku] nie może być puste !!! ' ;
END IF;

if new.il_sztuk  IS NULL OR new.il_sztuk <0 THEN RAISE EXCEPTION ' Pole [*Ilość sztuk] ma nieprawidłową wartość !!! ' ;
END IF;

if new.ilosc_a1  IS NULL OR new.ilosc_a1 <0
THEN RAISE EXCEPTION ' Pole [*IloĹść A1] nie może być puste !!! ' ;
END IF;

if new.nr_edycji  IS NULL OR new.nr_edycji <1
THEN RAISE EXCEPTION ' Pole [*numer edycji] nie może być puste !!! ' ;
END IF;
 new.data:= current_date;

if new.osobaodp  IS NULL
THEN RAISE EXCEPTION ' Pole [*Osoba odpowiedzialna] nie może być puste !!! ' ;
END IF;

 new.data:= current_date;


SELECT INTO zesp * FROM zespoly WHERE zespoly.id = new.id_zespol; 
IF NOT FOUND 
THEN 
  RAISE EXCEPTION ' Wpisany znak Zespołu jest niepoprawny !!! '  ;
ELSE
new.id_kontrakt := zesp.id_kontrakt;
END IF;
SELECT  max (numer) INTO maxi from detale WHERE detale.id_rysunki = new.id ;

SELECT  min (numer) INTO mini from detale WHERE detale.id_rysunki = new.id ;
-- RAISE EXCEPTION ' %',mini ;


IF mini IS NULL THEN 
  temp_str := '0000';
  new.min_maks_nr := 'Dodaj Detal!' ;
  rysnr := new.numer_rys;
ELSE
rozn := maxi - mini ; 

	
if  rozn = 0  then
		temp_str := mini ;
		new.min_maks_nr := mini ;
                                rysnr := 0;
		new.kolejny_rys := 0;
	else
		temp_str := '0000';
		new.min_maks_nr := to_char(mini, 'FM0999' )  || '-' || to_char(maxi, 'FM0999' ) ;
                --                rysnr := new.numer_rys;
		
		select max(kolejny_rys) INTO rysnr from rysunki2 WHERE id_zespol = new.id_zespol ;
				rysnr := rysnr + 1 ;
                                                               new.kolejny_rys := rysnr ;

	end if ;	

END IF;

IF new.rodzaj_rys ='ZŁOŻENIOWY' THEN 
new.min_maks_nr := '' ;
END IF;
IF new.rodzaj_rys ='WIELOKROTNY' THEN 
SELECT  min_maks_nr INTO mini_maks from rysunki2 WHERE rysunki2.id = new.wielokrotny ;
new.min_maks_nr := mini_maks ;
END IF;

new.rys_label  := zesp.zesp_label || '-' || to_char(rysnr, 'FM09' ) || '-' || temp_str ;


RETURN new ;


END ;$$;


ALTER FUNCTION public.label_rysunki() OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 6059061)
-- Name: label_zespol(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.label_zespol() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
 kontrkt kontrakt2%ROWTYPE;
 zesp zespoly%ROWTYPE;
 znaczek varchar;

BEGIN
if new.numer=0
THEN new.nazwa_zespolu := 'ZESTAWIENIE LINII' ;
END IF;

SELECT INTO zesp * FROM zespoly WHERE zespoly.id_kontrakt = new.id_kontrakt AND zespoly.numer = new.numer; 
IF NOT FOUND 
THEN 

ELSE
IF TG_OP = 'INSERT'  THEN
             RAISE EXCEPTION ' Taki numer zespołu już istnieje w tym kontrakcie !!! '  ;
          END IF;
     
          IF TG_OP = 'UPDATE'  THEN
              IF new.id_kontrakt = old.id_kontrakt AND  new.numer = old.numer THEN
                 
              ELSE 
                   RAISE EXCEPTION 'Taki numer zespołu już istnieje w tym kontrakcie !!! !!! ' ;
              END IF;
          END IF;

END IF;


SELECT INTO kontrkt * FROM kontrakt2 WHERE kontrakt2.id = new.id_kontrakt; 
IF NOT FOUND 
THEN 
  RAISE EXCEPTION ' Wpisany znak Kontraktu jest niepoprawny !!! '  ;
ELSE 

IF kontrkt.numer > 99 THEN
	znaczek= to_char(kontrkt.numer,'FM999'); 
	
ELSE
	znaczek= to_char(kontrkt.numer,'FM009');    
	
END IF;

new.zesp_label  = kontrkt.znak || ' ' || znaczek || '-' || to_char(new.numer, 'FM09');

RETURN new ;

END IF;

END ;$$;


ALTER FUNCTION public.label_zespol() OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 6059062)
-- Name: labelnum(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.labelnum() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN


IF new.numer > 99 
THEN
	new.nrlabel= new.znak || to_char(new.numer , '909')
	|| (to_char(new.data, '-MM-YY')) ;    
	
ELSE
	new.nrlabel= new.znak || to_char(new.numer , '009')
	|| (to_char(new.data, '-MM-YY')) ;    
	
END IF;

RETURN new ;
 
END ; $$;


ALTER FUNCTION public.labelnum() OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 6059063)
-- Name: liczenie_gotowych(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.liczenie_gotowych() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
wynik FLOAT;
R_plan INTEGER ;
BEGIN


IF TG_OP = 'INSERT'  THEN
R_plan := new.id_robplan ;
END IF;

IF TG_OP = 'UPDATE'  THEN
R_plan := new.id_robplan ;
END IF;

IF TG_OP = 'DELETE'  THEN
R_plan := old.id_robplan ;
END IF;

IF R_plan IS NULL THEN
	Return null;
END IF;
SELECT SUM(wykonana)
	into wynik  from robocizna_wykonana where id_robplan = R_plan;

IF NOT FOUND THEN 

wynik := 0 ;
END IF;


UPDATE r_plan_temp SET zrobione = 1  WHERE id = R_plan and trunc(cast(planowana as numeric),2) <=   wynik;
UPDATE r_plan_temp SET zrobione = 0  WHERE id = R_plan and trunc(cast(planowana as numeric),2) >   wynik;

RETURN new ;
END;
$$;


ALTER FUNCTION public.liczenie_gotowych() OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 6059064)
-- Name: logowanie(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.logowanie() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
wartosc_specjalna VARCHAR; 

BEGIN

IF TG_OP = 'INSERT'  THEN
	IF TG_RELNAME ='rysunki2' THEN
		wartosc_specjalna:= new.rys_label;
	ELSE
		wartosc_specjalna:= new.numer;
	END IF;
INSERT INTO logi_danych (ld_czas, ld_user, ld_zdarzenie, id_zespol, numer, ld_element)VALUES (now(),current_user,'NOWY',new.id_zespol, wartosc_specjalna,TG_RELNAME);

END IF;

IF TG_OP = 'UPDATE'  THEN
	IF TG_RELNAME ='rysunki2' THEN
		wartosc_specjalna:= new.rys_label;
	ELSE
		wartosc_specjalna:= new.numer;
	END IF;
INSERT INTO logi_danych (ld_czas, ld_user, ld_zdarzenie, id_zespol, numer, ld_element)VALUES (now(),current_user,'ZMIANA',new.id_zespol, wartosc_specjalna,TG_RELNAME);

END IF;

IF TG_OP = 'DELETE'  THEN
	IF TG_RELNAME ='rysunki2' THEN
		wartosc_specjalna:= old.rys_label;
	ELSE
		wartosc_specjalna:= old.numer;
	END IF;
INSERT INTO logi_danych (ld_czas, ld_user, ld_zdarzenie, id_zespol, numer, ld_element)VALUES (now(),current_user,'USUNIĘCIE',old.id_zespol, wartosc_specjalna,TG_RELNAME);

END IF;

RETURN new ;
END;$$;


ALTER FUNCTION public.logowanie() OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 6059065)
-- Name: logowanie_rysunkow(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.logowanie_rysunkow() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

INSERT INTO log_rysunki(id_zespol, rys_label, nazwa_rysunku, numer_rys, rodzaj_rys, il_sztuk, czas_projektowania, data, komentarz, ilosc_a1, nr_edycji, min_maks_nr,
  osobaodp,  data_wpl,  id_kontrakt,  wielokrotny,  wieloczesc,  kolejny_rys,  wsp_korekcji,  wykonczenie,  podzespol,  rodz_kooperacji,  gotowe,  zrobione,  rozliczone,
  ins_data,  ins_user,  upd_data,  upd_user,  del_id,  arkusz,rys_id)
VALUES(
  old.id_zespol,
  old.rys_label,
  old.nazwa_rysunku,
  old.numer_rys,
  old.rodzaj_rys,
  old.il_sztuk,
  old.czas_projektowania,
  old.data,
  old.komentarz,
  old.ilosc_a1,
  old.nr_edycji,
  old.min_maks_nr,
  old.osobaodp,
  old.data_wpl,
  old.id_kontrakt,
  old.wielokrotny,
  old.wieloczesc,
  old.kolejny_rys,
  old.wsp_korekcji,
  old.wykonczenie,
  old.podzespol,
  old.rodz_kooperacji,
  old.gotowe,
  old.zrobione,
  old.rozliczone,
  old.ins_data,
  old.ins_user,
  now(),
  current_user,
  old.del_id,
  old.arkusz, old.id);
RETURN new;
  END;$$;


ALTER FUNCTION public.logowanie_rysunkow() OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 6059066)
-- Name: masa_wart(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.masa_wart(text) RETURNS double precision
    LANGUAGE sql
    AS $_$select CAST(masa as float8) 
From material 
Where nazwa = $1;$_$;


ALTER FUNCTION public.masa_wart(text) OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 6059067)
-- Name: nazwa_branzy(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nazwa_branzy(integer) RETURNS text
    LANGUAGE sql
    AS $_$select CAST(br_nazwa as text) 
From branza 
Where id_branza = $1;$_$;


ALTER FUNCTION public.nazwa_branzy(integer) OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 6059068)
-- Name: nazwa_zespol(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nazwa_zespol(integer) RETURNS text
    LANGUAGE sql
    AS $_$select CAST(nazwa_zespolu as text) 
From zespoly 
where id = $1;$_$;


ALTER FUNCTION public.nazwa_zespol(integer) OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 6059069)
-- Name: nowa_cena_robocizny(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nowa_cena_robocizny() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
UPDATE efekty set of_wartosc= to_number(of_ciez, 'FM99999.999') * new.kosztrbg  where el_kalkulacji IN('Robocizna','Montaż')and id_kontrakt=new.id ;
RETURN new ;
END;$$;


ALTER FUNCTION public.nowa_cena_robocizny() OWNER TO postgres;

--
-- TOC entry 505 (class 1255 OID 6059070)
-- Name: numer_czesci(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_czesci(integer) RETURNS integer
    LANGUAGE sql
    AS $_$select max (numer) 
From normalia
Where id_zespol = $1;$_$;


ALTER FUNCTION public.numer_czesci(integer) OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 6059071)
-- Name: numer_detalu(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_detalu(integer) RETURNS integer
    LANGUAGE sql
    AS $_$select max (numer) 
From detale
Where id_zespol = $1;$_$;


ALTER FUNCTION public.numer_detalu(integer) OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 6059072)
-- Name: numer_kontraktu(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_kontraktu(text) RETURNS integer
    LANGUAGE sql
    AS $_$select max (numer) 

From kontrakt2 

Where znak = $1;$_$;


ALTER FUNCTION public.numer_kontraktu(text) OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 6059073)
-- Name: numer_robo_plan(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_robo_plan() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE 
wynik INTEGER;
mini INTEGER;
maksi INTEGER;

BEGIN
IF TG_OP = 'INSERT' THEN
	SELECT Max(kolejnosc_nstd) INTO wynik FROM r_plan_temp WHERE klucz_obj = new.klucz_obj ;
	IF wynik IS NULL THEN
		new.kolejnosc_nstd :=1;
	ELSE
		new.kolejnosc_nstd := wynik +1;
	END IF;
	
RETURN new;

END IF;

END;$$;


ALTER FUNCTION public.numer_robo_plan() OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 6059074)
-- Name: numer_rysunku(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_rysunku(integer) RETURNS integer
    LANGUAGE sql
    AS $_$select max (numer_rys) 

From rysunki2

Where id_zespol = $1;$_$;


ALTER FUNCTION public.numer_rysunku(integer) OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 6059075)
-- Name: numer_zespolu(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numer_zespolu(integer) RETURNS integer
    LANGUAGE sql
    AS $_$select max (numer) 

From zespoly 

Where id_kontrakt = $1;$_$;


ALTER FUNCTION public.numer_zespolu(integer) OWNER TO postgres;

--
-- TOC entry 509 (class 1255 OID 6059076)
-- Name: numeracja2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numeracja2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
wynik INTEGER;
mini INTEGER;
maksi INTEGER;

BEGIN
IF TG_OP <> 'DELETE' THEN
	SELECT Max(numer) INTO wynik FROM detale WHERE detale.id_rysunki = new.id_rysunki ;
	IF wynik IS NULL THEN
		mini :=0;
		maksi :=0;
	ELSE
		if wynik < new.numer then maksi := new.numer; 
		else 
		maksi := wynik;
		mini :=0;
		end if;
	END IF;
	
	SELECT Min(numer) INTO wynik FROM detale WHERE detale.id_rysunki = new.id_rysunki;
	IF wynik IS NULL THEN
		mini :=0;
		maksi :=0;
	ELSE
		if wynik > new.numer then mini := new.numer; 
		else 
		mini := wynik;
		end if;
	END IF;
	

		UPDATE rysunki2 SET min_maks_nr = mini || '-' || maksi WHERE id = new.id_rysunki;

	
	RETURN new;
	
	
ELSE
	SELECT Max(numer) INTO wynik FROM detale WHERE detale.id_rysunki = old.id_rysunki ;
	IF wynik IS NULL THEN
		mini :=0;
		maksi :=0;
	ELSE
		maksi := wynik;
		mini :=0;
	end if;
	
	SELECT Min(numer) INTO wynik FROM detale WHERE detale.id_rysunki = old.id_rysunki;
	IF wynik IS NULL THEN
		mini :=0;
		maksi :=0;
	ELSE
		mini := wynik;
	END IF;

UPDATE rysunki2 SET min_maks_nr = mini || '-' || maksi WHERE id = old.id_rysunki;


RETURN NULL;

END IF;

END;$$;


ALTER FUNCTION public.numeracja2() OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 6059077)
-- Name: numeracja_rysunkow(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numeracja_rysunkow() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
det detale%ROWTYPE;
zesp zespoly%ROWTYPE;
wynik INTEGER;
a INTEGER;
b INTEGER;
BEGIN
-- SPRAWDZENIE SPÓJNOŚCI

if new.id_rysunki  IS NULL OR new.id_rysunki  <0 THEN 
RAISE EXCEPTION ' Pole kombi[Wybór rysunków] ma nieprawidłową wartość !!! ' ;
END IF;

if new.wsad IS NULL OR length(trim(new.wsad )) <1 THEN 
RAISE EXCEPTION ' Pole kombi[Postać wsadu] ma nieprawidłową wartość !!! ' ;
END IF;

if new.material IS NULL OR   length(trim(new.material)) <1 THEN 
RAISE EXCEPTION ' Pole kombi[Gatunek materiału] ma nieprawidłową wartość !!! ' ;
END IF;

if new.ilsztuk  IS NULL OR new.ilsztuk  <0 THEN 
RAISE EXCEPTION ' Pole [Ilość sztuk] ma nieprawidłową wartość !!! ' ;
END IF;

SELECT INTO det * FROM detale WHERE detale.id_kontrakt = new.id_kontrakt AND detale.numer = new.numer; 
IF NOT FOUND THEN 
        
ELSE
			IF TG_OP = 'INSERT'  THEN
						 RAISE EXCEPTION ' Taki numer detalu już istnieje w tym kontrakcie !!! '  ;
			END IF;		  				 
			IF TG_OP = 'UPDATE'  THEN
						  IF new.numer= old.numer AND  new.id_kontrakt = old.id_kontrakt THEN
						
						  ELSE 
							   RAISE EXCEPTION 'Taki numer detalu już istnieje w tym kontrakcie !!! !!! ' ;
						  END IF;
			 END IF;
END IF;

IF TG_OP = 'INSERT'  THEN
if new.numer IS NULL OR   length(trim(new.numer)) <1 THEN 


		SELECT Max(numer) INTO wynik FROM detale WHERE detale.id_zespol = new.id_zespol;
			
			IF wynik IS NULL THEN
				SELECT INTO zesp * FROM zespoly WHERE zespoly.id= new.id_zespol; 
					IF NOT FOUND 
					THEN 
						RAISE EXCEPTION ' Numer zespołu nie został znaleziony !!! '  ;
					ELSE 
						new.numer :=zesp.numer * 1000 + 1;


					END IF;

			ELSE
SELECT INTO zesp * FROM zespoly WHERE zespoly.id= new.id_zespol; 			
new.numer :=wynik +1;
a:=zesp.numer*1000+1;
b:=(zesp.numer+1)*1000-1;
IF (new.numer BETWEEN a AND b) IS FALSE then

				
			RAISE EXCEPTION ' Numer pozycji  nie należy do aktualnego zespołu. Należy go poprawić !!! '  ;
			ELSE	
				

			END IF;
		    END IF;
ELSE
SELECT INTO zesp * FROM zespoly WHERE zespoly.id= new.id_zespol; 	
a:=zesp.numer*1000+1;
b:=(zesp.numer+1)*1000-1;
	
IF (new.numer BETWEEN a AND b) IS FALSE then

				
			RAISE EXCEPTION ' Numer pozycji  nie należy do aktualnego zespołu. Należy go poprawić !!! '  ;
			ELSE	
				

			END IF;


END IF;
END IF;	
   
IF TG_OP = 'UPDATE' THEN
if new.numer IS NULL OR   length(trim(new.numer)) <1 THEN 
RETURN old;
END IF;

SELECT INTO zesp * FROM zespoly WHERE zespoly.id= new.id_zespol; 
a:=zesp.numer*1000+1;
b:=(zesp.numer+1)*1000-1;



IF (new.numer BETWEEN a AND b) IS FALSE then

				
			RAISE EXCEPTION ' Numer wpisany ręcznie nie należy do aktualnego zespołu !!! '  ;
			ELSE	
				

			END IF;

END IF;

RETURN new;
END ;$$;


ALTER FUNCTION public.numeracja_rysunkow() OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 6059078)
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

--
-- TOC entry 512 (class 1255 OID 6059079)
-- Name: podzespol_text(bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.podzespol_text(id_rysunek bigint, numer bigint, kieszen character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE
id_rysunek ALIAS FOR $1; 
numer ALIAS FOR $2;
kieszen ALIAS FOR $3;
tekst character varying;
BEGIN
SELECT into tekst cast ((substr(rys_label::text, 11, 3) ) as Text) FROM rysunki2 WHERE id = $1;
If $3 IS NULL THEN 
	tekst := tekst || $2 ;
ELSE
	tekst := tekst || $3 || $2 ;
END IF;
RETURN  TEKST;
END;$_$;


ALTER FUNCTION public.podzespol_text(id_rysunek bigint, numer bigint, kieszen character varying) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 6059080)
-- Name: pracownik_miejsce(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pracownik_miejsce() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN

if new.grupa_zaw  IS NULL OR new.grupa_zaw = 'PP' OR new.grupa_zaw = 'KS' OR new.grupa_zaw = 'OS' OR new.grupa_zaw = 'MT' OR new.grupa_zaw = 'KT' OR new.grupa_zaw = 'ML'

THEN 
 new.miejsce_p := 1;
ELSE
 new.miejsce_p := 2;
END IF;

 RETURN new;
END;$$;


ALTER FUNCTION public.pracownik_miejsce() OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 6059081)
-- Name: robwyk_id_zesp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.robwyk_id_zesp() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
zesp INTEGER ;
robp INTEGER ;

BEGIN
robp := new.id_robplan;

SELECT robocizna_plan.id_zespol INTO zesp  FROM public.robocizna_plan WHERE id = robp ; 
  

          IF TG_OP = 'INSERT'  THEN
            new.id_zespol := zesp ;
          END IF;
     
          IF TG_OP = 'UPDATE'  THEN
            new.id_zespol := zesp ;
          END IF;


RETURN new ;


END ;$$;


ALTER FUNCTION public.robwyk_id_zesp() OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 6059082)
-- Name: rozliczanie(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rozliczanie(id_rysunki integer) RETURNS integer
    LANGUAGE sql
    AS $_$select rozliczone

From rysunki2

Where id = $1;$_$;


ALTER FUNCTION public.rozliczanie(id_rysunki integer) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 6059083)
-- Name: rys_lbl(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rys_lbl(integer) RETURNS text
    LANGUAGE sql
    AS $_$

SELECT cast (( rys_label ) as Text) FROM rysunki2 WHERE id = $1;$_$;


ALTER FUNCTION public.rys_lbl(integer) OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 6059084)
-- Name: rysunek_lbl(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rysunek_lbl(integer) RETURNS text
    LANGUAGE sql
    AS $_$

SELECT cast ( (rys_label || ' [ ' || nazwa_rysunku || ' ] ') as Text) FROM rysunki2 WHERE id = $1;$_$;


ALTER FUNCTION public.rysunek_lbl(integer) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 6059085)
-- Name: rysunki_rob(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rysunki_rob() RETURNS opaque
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE 
zesp INTEGER ;
kontr INTEGER ;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

UPDATE robocizna_plan SET il_sztuk = new.il_sztuk WHERE id_kontrakt = kontr and id_zespol=new.id_zespol and id_rysunek=new.id and num_pozycji=-1;
RETURN new ;
END;$$;


ALTER FUNCTION public.rysunki_rob() OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 6059086)
-- Name: suma_bled_cen_montaz(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_bled_cen_montaz(integer) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE ret NUMERIC; 
 BEGIN 
  select  sum(rozliczenie_proj.montaz* kontrakt2.koszt_bledu)into ret
FROM 
  public.rozliczenie_proj, 
  public.kontrakt2
WHERE 
  rozliczenie_proj.id_kontrakt = kontrakt2.id AND
  rozliczenie_proj.id_zespol = $1;
  
IF ret IS NULL THEN 
	RETURN 0;
END IF;
RETURN ret; 
 END;
$_$;


ALTER FUNCTION public.suma_bled_cen_montaz(integer) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 6059087)
-- Name: suma_bled_cen_wyk(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_bled_cen_wyk(integer) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE ret NUMERIC; 
 BEGIN 
  select sum(rozliczenie_proj.rob_wyk* kontrakt2.koszt_bledu)into ret
FROM 
  public.rozliczenie_proj, 
  public.kontrakt2
WHERE 
  rozliczenie_proj.id_kontrakt = kontrakt2.id AND
  rozliczenie_proj.id_zespol = $1;
  
IF ret IS NULL THEN 
	RETURN 0;
END IF;
RETURN ret; 
 END;
$_$;


ALTER FUNCTION public.suma_bled_cen_wyk(integer) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 6059088)
-- Name: suma_bled_material(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_bled_material(integer) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE ret NUMERIC; 
BEGIN 
select sum (koszt_mat) into ret
From rozliczenie_proj
Where id_zespol = $1;
  
IF ret IS NULL THEN 
	RETURN 0;
END IF;
RETURN ret; 
END;
$_$;


ALTER FUNCTION public.suma_bled_material(integer) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 6059089)
-- Name: suma_bled_montaz(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_bled_montaz(integer) RETURNS numeric
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE ret NUMERIC; 
BEGIN 
select sum (montaz) into ret
From rozliczenie_proj
Where id_zespol = $1;
  
IF ret IS NULL THEN 
	RETURN 0;
END IF;
RETURN ret; 
END;
$_$;


ALTER FUNCTION public.suma_bled_montaz(integer) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 6059090)
-- Name: suma_bled_rob_wyk(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_bled_rob_wyk(integer) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
DECLARE ret NUMERIC; 
BEGIN 
select sum (rob_wyk) into ret
From rozliczenie_proj
Where id_zespol = $1;
  
IF ret IS NULL THEN 
	RETURN 0;
END IF;
RETURN ret; 
END;
$_$;


ALTER FUNCTION public.suma_bled_rob_wyk(integer) OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 6059091)
-- Name: suma_do_zrobienia(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_do_zrobienia(bigint) RETURNS double precision
    LANGUAGE sql
    AS $_$select sum(do_zrobienia)
From szef_raport
Where id_zespol = $1 and zrobione_j=0;$_$;


ALTER FUNCTION public.suma_do_zrobienia(bigint) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 6059092)
-- Name: suma_dostaw(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_dostaw() RETURNS opaque
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE 
wynik FLOAT;
zesp INTEGER ;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
END IF;

IF TG_OP = 'DELETE'  THEN
zesp := old.id_zespol ;
END IF;

SELECT sum (cena*ilosc_sztuk) into wynik from normalia where id_zespol = zesp;
IF NOT FOUND THEN 
wynik := 0;
END IF;

UPDATE efekty SET przew_wartosc= wynik  WHERE id_zespol = zesp and flaga1= 2;

RETURN new ;
END;
$$;


ALTER FUNCTION public.suma_dostaw() OWNER TO postgres;

--
-- TOC entry 524 (class 1255 OID 6059093)
-- Name: suma_efekty(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_efekty() RETURNS opaque
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
wynik NUMERIC(8, 2);
wynik2 NUMERIC(8, 2);
wynik3 NUMERIC(8, 2);
zesp INTEGER ;
kontr INTEGER ;
flg INTEGER ;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
flg := new.flaga2 ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
flg := new.flaga2 ;
END IF;

IF TG_OP = 'DELETE'  THEN
zesp := old.id_zespol ;
kontr := old.id_kontrakt ;
flg := old.flaga2 ;
END IF;



 RAISE EXCEPTION ' %', wynik  ;

IF wynik IS NULL THEN
wynik := 0;
END IF;
IF NOT FOUND THEN 
wynik := 0;
END IF;



RETURN new ;
END;$$;


ALTER FUNCTION public.suma_efekty() OWNER TO postgres;

--
-- TOC entry 525 (class 1255 OID 6059094)
-- Name: suma_masy(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_masy() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE 
wynik FLOAT;
zesp INTEGER ;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
END IF;

IF TG_OP = 'DELETE'  THEN
zesp := old.id_zespol ;
END IF;

SELECT sum (ciez_calkowity) into wynik from detale where id_zespol = zesp;
IF NOT FOUND THEN 
wynik := 0;
END IF;

UPDATE efekty SET przew_ciez =wynik  WHERE id_zespol = zesp and flaga1= 1;

SELECT sum (ciez_calkowity*cena) into wynik from detale where id_zespol = zesp;
IF NOT FOUND THEN 
wynik := 0;
END IF;


UPDATE efekty SET przew_wartosc =wynik  WHERE id_zespol = zesp and flaga1= 1;
RETURN new ;
END;
$$;


ALTER FUNCTION public.suma_masy() OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 6059095)
-- Name: suma_montazu(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_montazu(id_zespol integer) RETURNS numeric
    LANGUAGE sql
    AS $_$
SELECT 
  sum(public.rozliczenie_proj.montaz)
FROM
  public.rozliczenie_proj
WHERE
  public.rozliczenie_proj.id_zespol=$1;
$_$;


ALTER FUNCTION public.suma_montazu(id_zespol integer) OWNER TO postgres;

--
-- TOC entry 526 (class 1255 OID 6059096)
-- Name: suma_rob_plan(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_rob_plan() RETURNS opaque
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE 
wynik NUMERIC;
wynik2 NUMERIC;
wynik3 NUMERIC;
zesp INTEGER ;
kontr INTEGER ;
kontr2 kontrakt2%ROWTYPE;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

IF TG_OP = 'DELETE'  THEN
zesp := old.id_zespol ;
kontr := old.id_kontrakt ;
END IF;

SELECT INTO kontr2 * FROM kontrakt2 WHERE kontrakt2.id = kontr; 

SELECT sum (planowana*il_sztuk) into wynik from robocizna_plan where id_zespol = zesp and znak_operacji<>'MN' and znak_operacji<>'PW';

IF wynik IS NULL THEN
wynik := 0;
END IF;
IF NOT FOUND THEN 
wynik := 0;
END IF;

--Montaż
SELECT sum (planowana*il_sztuk) into wynik2 from robocizna_plan where id_zespol = zesp and znak_operacji='MN';
IF NOT FOUND THEN 
wynik2 := 0;
END IF;

--Przygotowanie wsadu
SELECT sum (planowana*il_sztuk) into wynik3 from robocizna_plan where id_kontrakt= kontr and znak_operacji='PW';
IF NOT FOUND THEN 
wynik3 := 0;
END IF;


UPDATE efekty SET przew_ciez =wynik, przew_wartosc = wynik* kontr2.kosztrbg WHERE id_zespol = zesp and flaga1= 4;

UPDATE efekty SET przew_ciez = wynik2, przew_wartosc = wynik2* kontr2.kosztrbg WHERE id_zespol = zesp and flaga1= 5;

UPDATE efekty SET przew_ciez = wynik3, przew_wartosc = wynik3* kontr2.kosztrbg WHERE id_kontrakt = kontr and flaga1= 1 and flaga2 = 99;
RETURN new ;
END;
$$;


ALTER FUNCTION public.suma_rob_plan() OWNER TO postgres;

--
-- TOC entry 527 (class 1255 OID 6059097)
-- Name: suma_robwyk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.suma_robwyk() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
wynik NUMERIC;
wynik2 NUMERIC;
wynik3 NUMERIC;
zesp INTEGER ;
kontr INTEGER ;
kontr2 kontrakt2%ROWTYPE;
BEGIN

IF TG_OP = 'INSERT'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

IF TG_OP = 'UPDATE'  THEN
zesp := new.id_zespol ;
kontr := new.id_kontrakt ;
END IF;

IF TG_OP = 'DELETE'  THEN
zesp := old.id_zespol ;
kontr := old.id_kontrakt ;
END IF;


SELECT INTO kontr2 * FROM kontrakt2 WHERE kontrakt2.id = kontr; 

SELECT sum (wykonana) into wynik from robocizna_wyk where id_zespol = zesp and znak_rob<>'MN' and znak_rob<>'PW';
IF wynik IS NULL THEN
wynik := 0;
END IF;
IF NOT FOUND THEN 
wynik := 0;
END IF;

--Montaż
SELECT sum (wykonana) into wynik2 from robocizna_wyk where id_zespol = zesp and znak_rob='MN';
IF NOT FOUND THEN 
wynik2 := 0;
END IF;

--Przygotowanie wsadu
SELECT sum (wykonana) into wynik3 from robocizna_wyk where id_kontrakt= kontr and znak_rob='PW';
IF NOT FOUND THEN 
wynik3 := 0;
END IF;

UPDATE efekty SET rozl_ciez = wynik, rozl_wartosc = wynik* kontr2.kosztrbg WHERE id_zespol = zesp and flaga1= 4;

UPDATE efekty SET rozl_ciez = wynik2, rozl_wartosc = wynik2* kontr2.kosztrbg WHERE id_zespol = zesp and flaga1= 5;

UPDATE efekty SET rozl_ciez = wynik3, rozl_wartosc = wynik3* kontr2.kosztrbg WHERE id_kontrakt = kontr and flaga1= 1 and flaga2 = 99;
RETURN new ;
END;$$;


ALTER FUNCTION public.suma_robwyk() OWNER TO postgres;

--
-- TOC entry 528 (class 1255 OID 6059098)
-- Name: szef_drill(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.szef_drill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

IF TG_OP = 'DELETE'  THEN
IF old.id<>0 THEN
delete from robocizna_wykonana where id_rysunek=old.id and id_kontrakt=old.id_kontrakt;
delete from r_plan_temp where id_rysunek = old.id and id_kontrakt=old.id_kontrakt;
delete from detale where id_rysunki = old.id ;
END IF;


 
END IF;

RETURN new ;

END;
$$;


ALTER FUNCTION public.szef_drill() OWNER TO postgres;

--
-- TOC entry 529 (class 1255 OID 6059099)
-- Name: test_material(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test_material() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
 mat material%ROWTYPE;

BEGIN
if new.nazwa  IS NULL OR length(trim(new.nazwa )) <1 THEN 

RAISE EXCEPTION ' Pole [Nazwa materiału] ma nieprawidłową wartość !!! ' ;
END IF;

if new.masa  IS NULL OR length(trim(new.masa )) <1 THEN 
RAISE EXCEPTION ' Pole [Masa] ma nieprawidłową wartość !!! ' ;
END IF;

SELECT INTO mat * FROM material WHERE material.nazwa = new.nazwa; 
IF NOT FOUND 
THEN 
RETURN new ;
ELSE
IF TG_OP = 'INSERT'  THEN
             RAISE EXCEPTION ' Taka nazwa materiału już istnieje !!! '  ;
          END IF;
     
          IF TG_OP = 'UPDATE'  THEN
              IF new.nazwa = old.nazwa   THEN
                 RETURN new ;
              ELSE 
                   RAISE EXCEPTION 'Taka nazwa materiału już istnieje !!! ' ;
              END IF;
          END IF;




END IF;

END ;$$;


ALTER FUNCTION public.test_material() OWNER TO postgres;

--
-- TOC entry 530 (class 1255 OID 6059100)
-- Name: trigger_insert_update_kontrah(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_insert_update_kontrah() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE
znaki kontrahent2%ROWTYPE ; 

BEGIN
if length(trim(new.nazwa)) <1
THEN RAISE EXCEPTION ' Pole [Nazwa kontrahenta] nie może być puste !!! ' ;
END IF;

if length(trim(new.miasto)) <1
THEN RAISE EXCEPTION ' Pole [Miasto] nie może być puste !!! ' ;
END IF;

if new.miasto IS NULL
THEN RAISE EXCEPTION ' Pole [Miasto] nie może być puste !!! ' ;
END IF;

if length(trim(new.znak)) <2
THEN RAISE EXCEPTION ' Pole [Identyfikator kontrahenta] powinno składać się z dwóch liter !!! ' ;
END IF;
IF new.znak IS NULL then 
      RAISE EXCEPTION ' Identyfikator kontrahenta nie może być pusty!!! ' ;
end if;

SELECT INTO znaki * FROM kontrahent2
WHERE kontrahent2.znak = new.znak ; 
IF NOT FOUND 
THEN 
IF new.nazwa IS NULL then 
      RAISE EXCEPTION ' Nazwa nie może być pusta!!! ' ;
end if;
RETURN new ; 
ELSE 
          IF TG_OP = 'INSERT'  THEN
             RAISE EXCEPTION ' Taki Identyfikator kontrahenta już istnieje !!! '  ;
          END IF;
     
          IF TG_OP = 'UPDATE'  THEN
              IF new.znak = old.znak THEN
                  RETURN new ;
              ELSE 
                   RAISE EXCEPTION ' Taki Identyfikator kontrahenta już istnieje !!! ' ;
              END IF;
          END IF;

END IF ;


END ; 
$$;


ALTER FUNCTION public.trigger_insert_update_kontrah() OWNER TO postgres;

--
-- TOC entry 531 (class 1255 OID 6059101)
-- Name: wika_drill(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.wika_drill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

IF TG_OP = 'DELETE'  THEN

delete from robocizna_wykonana where id_robplan =old.id and id_kontrakt=old.id_kontrakt;
delete from r_plan_temp where id = old.id and id_kontrakt=old.id_kontrakt;




 
END IF;

RETURN new ;

END;
$$;


ALTER FUNCTION public.wika_drill() OWNER TO postgres;

--
-- TOC entry 533 (class 1255 OID 6059102)
-- Name: wyplaty_opis_pracy(integer, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.wyplaty_opis_pracy(integer, integer, integer, character varying) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $_$DECLARE 
IDkontrakt ALIAS FOR $1; 
ID_zespol ALIAS FOR $2; 
ID_rysunek ALIAS FOR $3; 
ID_Klucz ALIAS FOR $4; 
TEKST text; 
TEKST_KLUCZ text;
Kwerenda RECORD;
BEGIN
--PRZYPADEK DLA OGOLNEJ ROBOCIZNY
TEKST_KLUCZ :=substring(ID_Klucz  from 4 for char_length(ID_Klucz));
IF substring(ID_Klucz from 1 for 3) = 'KKO' THEN
       select  into TEKST  substring(kontrakt2.nrlabel from 1 for 6 )|| ' ' || nazwa FROM koszty_ogolne, kontrakt2
	WHERE kolejnosc = CAST(TEKST_KLUCZ as int) and koszty_ogolne.id_kontrakt=kontrakt2.id
	and koszty_ogolne.id_kontrakt = IDkontrakt;
	TEKST := TEKST || '- PRACE OGÓLNE';
ELSE
		IF ID_rysunek IS NULL  OR ID_rysunek = 0 THEN
--PRZYPADEK DLA ROBOCIZNY W ZESPOLE
			SELECT into Tekst zespoly.zesp_label 
			FROM zespoly
			WHERE zespoly.id = ID_zespol; 
			RETURN  TEKST;
		
		ELSE
--PRZYPADEK DLA ROBOCIZNY W RYSUNKU I DETALU
			SELECT into Tekst rysunki2.rys_label
			FROM rysunki2
			WHERE id = ID_rysunek ;
			RETURN  TEKST;
		END IF;
END IF;
   RETURN TEKST;
END;
$_$;


ALTER FUNCTION public.wyplaty_opis_pracy(integer, integer, integer, character varying) OWNER TO postgres;

--
-- TOC entry 534 (class 1255 OID 6059103)
-- Name: zespol_lbl(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.zespol_lbl(integer) RETURNS text
    LANGUAGE sql
    AS $_$select CAST (zesp_label as TEXT) 

From zespoly 

Where id = $1;$_$;


ALTER FUNCTION public.zespol_lbl(integer) OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 6059104)
-- Name: znacznik_delete(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.znacznik_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
BEGIN
INSERT INTO del_log (tabela, id_tabeli, data_kasowania, skasowal) VALUES (TG_RELNAME, OLD.del_id, now() ,current_user); 
RETURN OLD;

END;$$;


ALTER FUNCTION public.znacznik_delete() OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 6059105)
-- Name: znacznik_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.znacznik_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
NEW.ins_data = now();
NEW.ins_user = current_user;
RETURN NEW; 
END;$$;


ALTER FUNCTION public.znacznik_insert() OWNER TO postgres;

--
-- TOC entry 532 (class 1255 OID 6059106)
-- Name: znacznik_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.znacznik_update() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN
new.upd_data := now();
new.upd_user := current_user;
RETURN new; 
END;$$;


ALTER FUNCTION public.znacznik_update() OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 6059107)
-- Name: zrobione_j(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.zrobione_j(bigint) RETURNS integer
    LANGUAGE sql
    AS $_$select zrobione
From rysunki2
Where id = $1;$_$;


ALTER FUNCTION public.zrobione_j(bigint) OWNER TO postgres;

--
-- TOC entry 1488 (class 1255 OID 6059108)
-- Name: mul(bigint); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE public.mul(bigint) (
    SFUNC = int8mul,
    STYPE = bigint
);


ALTER AGGREGATE public.mul(bigint) OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 6059109)
-- Name: biblio_cze_id_biblio_cze_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.biblio_cze_id_biblio_cze_seq
    START WITH 4750
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biblio_cze_id_biblio_cze_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 197 (class 1259 OID 6059111)
-- Name: biblioteka_czesci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biblioteka_czesci (
    id integer DEFAULT nextval(('"biblioteka_czesci_id_seq"'::text)::regclass) NOT NULL,
    id_branza integer NOT NULL,
    nazwa character varying(100) NOT NULL,
    symbol character varying(100) DEFAULT ''::character varying,
    norma character varying(60) DEFAULT ''::character varying,
    cena double precision DEFAULT 0,
    opis text DEFAULT ''::text,
    is_subbranza integer,
    sortowanie character varying(3),
    data_zmiany_ceny date,
    zmieniajacy character varying(50),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.biblioteka_czesci OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 6059122)
-- Name: biblioteka_czesci_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.biblioteka_czesci_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biblioteka_czesci_del_id_seq OWNER TO postgres;

--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 198
-- Name: biblioteka_czesci_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.biblioteka_czesci_del_id_seq OWNED BY public.biblioteka_czesci.del_id;


--
-- TOC entry 199 (class 1259 OID 6059124)
-- Name: biblioteka_czesci_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.biblioteka_czesci_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.biblioteka_czesci_id_seq OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 6059126)
-- Name: biblioteka_normaliow_biblioteka_normaliow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.biblioteka_normaliow_biblioteka_normaliow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biblioteka_normaliow_biblioteka_normaliow_id_seq OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 6059128)
-- Name: biblioteka_normaliow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biblioteka_normaliow (
    biblioteka_normaliow_id bigint DEFAULT nextval('public.biblioteka_normaliow_biblioteka_normaliow_id_seq'::regclass) NOT NULL,
    parent_id bigint NOT NULL,
    typ_elementu integer DEFAULT 0 NOT NULL,
    nazwa_elementu character varying(100) NOT NULL,
    symbol character varying(100),
    norma character varying(100),
    opis text,
    cena money,
    data_zmiany_ceny date,
    zmieniajacy character varying(100),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.biblioteka_normaliow OWNER TO postgres;

--
-- TOC entry 4019 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE biblioteka_normaliow; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.biblioteka_normaliow IS 'Zastosowane kodowanie:
typ_elementu
0 - BRANZA
1 - DOWOLNA SUBBRANZA
2 - CZĘŚĆ W BIBLIOTECE
';


--
-- TOC entry 202 (class 1259 OID 6059136)
-- Name: biblioteka_normaliow_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.biblioteka_normaliow_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biblioteka_normaliow_del_id_seq OWNER TO postgres;

--
-- TOC entry 4021 (class 0 OID 0)
-- Dependencies: 202
-- Name: biblioteka_normaliow_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.biblioteka_normaliow_del_id_seq OWNED BY public.biblioteka_normaliow.del_id;


--
-- TOC entry 203 (class 1259 OID 6059138)
-- Name: branza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branza (
    id_branza integer DEFAULT nextval(('"branza_id_branza_seq"'::text)::regclass) NOT NULL,
    br_nazwa character varying(30) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.branza OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 6059142)
-- Name: branza_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branza_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branza_del_id_seq OWNER TO postgres;

--
-- TOC entry 4024 (class 0 OID 0)
-- Dependencies: 204
-- Name: branza_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branza_del_id_seq OWNED BY public.branza.del_id;


--
-- TOC entry 205 (class 1259 OID 6059144)
-- Name: branza_id_branza_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branza_id_branza_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.branza_id_branza_seq OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 6059146)
-- Name: ceny_rys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ceny_rys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ceny_rys_id_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 207 (class 1259 OID 6059148)
-- Name: ceny_rys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ceny_rys (
    id integer DEFAULT nextval('public.ceny_rys_id_seq'::regclass) NOT NULL,
    rodzajrys character varying(20),
    cena numeric(6,2),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.ceny_rys OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 6059152)
-- Name: ceny_rys_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ceny_rys_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ceny_rys_del_id_seq OWNER TO postgres;

--
-- TOC entry 4029 (class 0 OID 0)
-- Dependencies: 208
-- Name: ceny_rys_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ceny_rys_del_id_seq OWNED BY public.ceny_rys.del_id;


SET default_with_oids = true;

--
-- TOC entry 209 (class 1259 OID 6059154)
-- Name: kontrahent2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kontrahent2 (
    znak character varying(2) NOT NULL,
    nazwa text NOT NULL,
    przedstawiciel text,
    stanowisko text,
    ulica text NOT NULL,
    nrdomu text,
    nrlokalu text,
    kodpoczt text,
    miasto text NOT NULL,
    tel text,
    telkom text,
    fax text,
    email text,
    www text,
    nip text,
    info text,
    kraj text DEFAULT 'Polska'::text NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.kontrahent2 OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 6059161)
-- Name: kontrakt2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kontrakt2 (
    id integer DEFAULT nextval(('"kontrakt2_id_seq"'::text)::regclass) NOT NULL,
    znak character varying(2) NOT NULL,
    numer integer NOT NULL,
    nrlabel character varying(12),
    temat text,
    data date,
    datastop date,
    osobaodp text,
    info text,
    wartosc numeric(10,2),
    nrfaktury text,
    konieckontr integer DEFAULT 0 NOT NULL,
    kosztrbg numeric(8,2),
    kosztproj numeric(8,2),
    zlats numeric(4,2),
    zleu numeric(4,2),
    procent_wyplaty bigint DEFAULT 50,
    data_przeliczenia date,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    katalog character varying(100),
    wartosc_euro numeric(10,2) DEFAULT 0,
    cena_stali numeric(5,2),
    koszt_bledu numeric(5,2) DEFAULT 42,
    rozliczony_status boolean DEFAULT false,
    rozliczony_data date
);


ALTER TABLE public.kontrakt2 OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 6059173)
-- Name: normalia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.normalia (
    id integer DEFAULT nextval(('"normalia_id_seq"'::text)::regclass) NOT NULL,
    id_rysunki integer,
    numer integer NOT NULL,
    nazwa text NOT NULL,
    ilosc_sztuk integer NOT NULL,
    opis text,
    edycja text,
    cena double precision,
    kosztcalkowity double precision,
    dostawca text,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    cena_rozl double precision DEFAULT 0,
    rozliczony boolean DEFAULT false,
    stan_czesci integer DEFAULT 0,
    symbol character varying(200),
    data_dostawy date,
    status integer DEFAULT 0,
    data_zaplaty date,
    uzytkownik_zmieniajacy character varying(50),
    forma_zaplaty integer,
    termin_platnosci integer,
    przelew double precision,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    branza character varying(30),
    subbranza character varying(30),
    il_z_magazynu integer DEFAULT 0,
    tymczasowa boolean,
    data_wpl date,
    faktura character varying(50)
);


ALTER TABLE public.normalia OWNER TO postgres;

--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN normalia.faktura; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.normalia.faktura IS 'dodane na prosbe Wiki 2018.05.30';


--
-- TOC entry 212 (class 1259 OID 6059185)
-- Name: zespoly; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zespoly (
    id integer DEFAULT nextval(('"zespoly_id_seq"'::text)::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    numer integer NOT NULL,
    zesp_label character varying(9) NOT NULL,
    nazwa_zespolu text NOT NULL,
    opis1 text,
    opis2 text,
    opis3 text,
    opis4 text,
    opis5 text,
    kategoria text,
    procent_wyplaty numeric(4,1) DEFAULT 0,
    zatwierdzony boolean DEFAULT false,
    data1raty date,
    rata1 numeric(10,2) DEFAULT 0,
    data2raty date,
    rata2 numeric(10,2) DEFAULT 0,
    databledu date,
    bledy numeric(10,2) DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    proj_wiodacy character varying(50),
    cena_stali numeric(5,2) DEFAULT 3.5,
    termin_wykonania date,
    typ integer
);


ALTER TABLE public.zespoly OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 6059198)
-- Name: czesci_raport; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.czesci_raport AS
 SELECT normalia.numer,
    normalia.nazwa,
    normalia.dostawca,
    normalia.ilosc_sztuk,
    zespoly.numer AS nr_zespol,
    zespoly.nazwa_zespolu,
    kontrakt2.temat,
    kontrakt2.nrlabel,
    kontrahent2.nazwa AS inwestor,
    normalia.id_zespol,
    normalia.id_kontrakt,
    normalia.symbol,
    public.iff((normalia.id_rysunki IS NULL), '-'::text, public.rys_lbl(normalia.id_rysunki)) AS rysunek
   FROM public.zespoly,
    public.kontrakt2,
    public.normalia,
    public.kontrahent2
  WHERE ((zespoly.id_kontrakt = kontrakt2.id) AND (zespoly.id = normalia.id_zespol) AND (kontrakt2.id = normalia.id_kontrakt) AND ((kontrakt2.znak)::text = (kontrahent2.znak)::text))
  ORDER BY normalia.numer;


ALTER TABLE public.czesci_raport OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 214 (class 1259 OID 6059203)
-- Name: czesci_zamienne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.czesci_zamienne (
    cz_id bigint NOT NULL,
    cz_lbl_element character varying(200),
    cz_nazwa character varying(200),
    cz_ilszt integer,
    cz_wartosc numeric(10,2),
    cz_jedn character varying(20)
);


ALTER TABLE public.czesci_zamienne OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 6059206)
-- Name: czesci_zamienne_cz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.czesci_zamienne_cz_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.czesci_zamienne_cz_id_seq OWNER TO postgres;

--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 215
-- Name: czesci_zamienne_cz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.czesci_zamienne_cz_id_seq OWNED BY public.czesci_zamienne.cz_id;


SET default_with_oids = true;

--
-- TOC entry 216 (class 1259 OID 6059208)
-- Name: del_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.del_log (
    id_del_log bigint NOT NULL,
    tabela character varying(30),
    id_tabeli bigint,
    data_kasowania date,
    skasowal character varying(50)
);


ALTER TABLE public.del_log OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 6059211)
-- Name: del_log_id_del_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.del_log_id_del_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.del_log_id_del_log_seq OWNER TO postgres;

--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 217
-- Name: del_log_id_del_log_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.del_log_id_del_log_seq OWNED BY public.del_log.id_del_log;


--
-- TOC entry 218 (class 1259 OID 6059213)
-- Name: delegacje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delegacje_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delegacje_id_seq OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 6059215)
-- Name: delegacje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delegacje (
    id_kontrakt integer NOT NULL,
    numer character varying(100),
    osoba character varying(50),
    kwota numeric(10,2),
    id integer DEFAULT nextval('public.delegacje_id_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.delegacje OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 6059219)
-- Name: delegacje_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delegacje_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delegacje_del_id_seq OWNER TO postgres;

--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 220
-- Name: delegacje_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delegacje_del_id_seq OWNED BY public.delegacje.del_id;


--
-- TOC entry 221 (class 1259 OID 6059221)
-- Name: detale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detale (
    id integer DEFAULT nextval(('"detale_id_seq"'::text)::regclass) NOT NULL,
    id_rysunki integer NOT NULL,
    numer integer NOT NULL,
    material character varying(20) NOT NULL,
    wsad character varying(25) NOT NULL,
    ilsztuk integer NOT NULL,
    wymiar_a double precision,
    wymiar_b double precision,
    wymiar_c double precision,
    ciez_jedn double precision,
    ciez_sztuki double precision,
    ciez_calkowity double precision,
    cena double precision,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    rozliczony boolean DEFAULT false,
    cena_rozl double precision DEFAULT 0,
    stan_materialu smallint DEFAULT 0,
    pociety smallint DEFAULT 0,
    cena_bufor double precision DEFAULT 0,
    rodz_kooperacji smallint DEFAULT 0,
    id_rw_detale bigint,
    data_ciecia date,
    kolejnosc_rw integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    rw_wb text,
    wb_ok integer DEFAULT 0,
    kieszen character varying(2),
    data_wpl date
);


ALTER TABLE public.detale OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 6059235)
-- Name: detale_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detale_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detale_del_id_seq OWNER TO postgres;

--
-- TOC entry 4047 (class 0 OID 0)
-- Dependencies: 222
-- Name: detale_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detale_del_id_seq OWNED BY public.detale.del_id;


--
-- TOC entry 223 (class 1259 OID 6059237)
-- Name: detale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.detale_id_seq OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 6059239)
-- Name: detale_kopia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detale_kopia (
    id integer DEFAULT nextval(('"detalekopia_id_seq"'::text)::regclass) NOT NULL,
    id_rysunki integer NOT NULL,
    numer integer NOT NULL,
    material character varying(20) NOT NULL,
    wsad character varying(25) NOT NULL,
    ilsztuk integer NOT NULL,
    wymiar_a double precision,
    wymiar_b double precision,
    wymiar_c double precision,
    ciez_jedn double precision,
    ciez_sztuki double precision,
    ciez_calkowity double precision,
    cena double precision,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    rozliczony boolean DEFAULT false,
    cena_rozl double precision DEFAULT 0,
    stan_materialu smallint DEFAULT 0,
    pociety smallint DEFAULT 0,
    cena_bufor double precision DEFAULT 0,
    rodz_kooperacji smallint DEFAULT 0,
    id_rw_detale bigint,
    data_ciecia date,
    kolejnosc_rw integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.detale_kopia OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 6059249)
-- Name: detale_kopia_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detale_kopia_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detale_kopia_del_id_seq OWNER TO postgres;

--
-- TOC entry 4050 (class 0 OID 0)
-- Dependencies: 225
-- Name: detale_kopia_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detale_kopia_del_id_seq OWNED BY public.detale_kopia.del_id;


--
-- TOC entry 226 (class 1259 OID 6059251)
-- Name: rysunki2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rysunki2 (
    id integer DEFAULT nextval(('"rysunki2_id_seq"'::text)::regclass) NOT NULL,
    id_zespol integer NOT NULL,
    rys_label character varying(19) NOT NULL,
    nazwa_rysunku text NOT NULL,
    numer_rys integer,
    rodzaj_rys character varying(19) NOT NULL,
    il_sztuk integer DEFAULT 1 NOT NULL,
    czas_projektowania real,
    data date DEFAULT ('now'::text)::date,
    komentarz text,
    ilosc_a1 real DEFAULT 1 NOT NULL,
    nr_edycji integer DEFAULT 1 NOT NULL,
    min_maks_nr text,
    osobaodp text,
    data_wpl date,
    id_kontrakt integer,
    wielokrotny integer DEFAULT '-1'::integer,
    wieloczesc integer DEFAULT 0,
    kolejny_rys integer DEFAULT 0,
    wsp_korekcji double precision DEFAULT 1,
    wykonczenie character varying(30),
    podzespol smallint DEFAULT 0,
    rodz_kooperacji smallint DEFAULT 0,
    gotowe boolean DEFAULT false,
    zrobione integer DEFAULT 0,
    rozliczone integer DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    arkusz integer DEFAULT 1 NOT NULL,
    p1 character varying(40),
    p2 character varying(40),
    plik character varying(500)
);


ALTER TABLE public.rysunki2 OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 6059272)
-- Name: detale_raport; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.detale_raport AS
 SELECT zespoly.id_kontrakt,
    zespoly.id,
    detale.id_rysunki,
    detale.numer,
    (public.iff((substr((rysunki2.rys_label)::text, 12, 1) = '-'::text), substr((rysunki2.rys_label)::text, 10, 3), substr((rysunki2.rys_label)::text, 11, 3)) || (detale.numer)::text) AS numer2,
    detale.material,
    detale.wsad,
    detale.ilsztuk,
    detale.wymiar_a,
    detale.wymiar_b,
    detale.wymiar_c,
    detale.ciez_jedn,
    detale.ciez_sztuki,
    detale.ciez_calkowity,
    detale.rozliczony,
    detale.cena_rozl,
    detale.stan_materialu,
    detale.pociety,
    kontrakt2.temat,
    zespoly.numer AS num_zesp,
    kontrakt2.nrlabel,
    rysunki2.osobaodp,
    rysunki2.rys_label,
    zespoly.nazwa_zespolu,
    detale.id_zespol
   FROM public.zespoly,
    public.kontrakt2,
    public.rysunki2,
    public.detale
  WHERE ((zespoly.id_kontrakt = kontrakt2.id) AND (zespoly.id = rysunki2.id_zespol) AND (rysunki2.id = detale.id_rysunki))
  ORDER BY detale.numer;


ALTER TABLE public.detale_raport OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 6059277)
-- Name: detale_raport_szef; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.detale_raport_szef AS
 SELECT d.id,
    d.id_rysunki,
    d.numer,
    d.material,
    d.wsad,
    d.ilsztuk,
    d.cena,
    (d.cena * d.ciez_calkowity) AS cenatotal,
    d.id_kontrakt,
    d.id_zespol,
    public.iff((d.rozliczony = true), 'X'::text, '-'::text) AS rozliczony,
    d.cena_rozl,
    public.iff((d.stan_materialu = '-1'::integer), 'X'::text, '-'::text) AS stan_materialu,
    public.iff((d.pociety = '-1'::integer), 'X'::text, '-'::text) AS pociety,
    z.zesp_label,
    (public.podzespol_text((d.id_rysunki)::bigint, (d.numer)::bigint, d.kieszen))::text AS numer2,
    d.rodz_kooperacji,
    d.rw_wb,
    d.wb_ok,
    d.ciez_calkowity,
    d.data_ciecia
   FROM public.detale d,
    public.zespoly z,
    public.rysunki2 r
  WHERE ((d.id_zespol = z.id) AND (d.id_rysunki = r.id))
  ORDER BY d.numer;


ALTER TABLE public.detale_raport_szef OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 6059282)
-- Name: detaleceny_raport_szef; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.detaleceny_raport_szef AS
 SELECT d.id,
    d.id_rysunki,
    d.numer,
    d.material,
    d.wsad,
    d.wymiar_a,
    d.wymiar_b,
    d.wymiar_c,
    d.ciez_sztuki,
    d.ciez_calkowity,
    d.ilsztuk,
    d.cena,
    d.id_kontrakt,
    d.id_zespol,
    d.cena_rozl,
    z.zesp_label,
    (d.numer)::text AS numer2
   FROM public.detale d,
    public.zespoly z,
    public.rysunki2 r
  WHERE ((d.id_zespol = z.id) AND (d.id_rysunki = r.id))
  ORDER BY d.numer;


ALTER TABLE public.detaleceny_raport_szef OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 6059287)
-- Name: do_us; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.do_us (
    id integer NOT NULL,
    el_kalkulacji text,
    id_kontrakt integer,
    flaga integer
);


ALTER TABLE public.do_us OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 6059293)
-- Name: do_us_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.do_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.do_us_id_seq OWNER TO postgres;

--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 231
-- Name: do_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.do_us_id_seq OWNED BY public.do_us.id;


--
-- TOC entry 232 (class 1259 OID 6059295)
-- Name: doradztwo_nowy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doradztwo_nowy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doradztwo_nowy_id_seq OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 6059297)
-- Name: doradztwo_nowy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doradztwo_nowy (
    id integer DEFAULT nextval('public.doradztwo_nowy_id_seq'::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    nr_raty character varying(120),
    opis text,
    rozliczane numeric(10,2),
    wykonane numeric(10,2),
    kiedy date DEFAULT ('now'::text)::date,
    kto character varying(20) DEFAULT "current_user"(),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    data1raty date,
    rata1 numeric(10,2),
    data2raty date,
    rata2 numeric(10,2),
    data3raty date,
    rata3 numeric(10,3)
);


ALTER TABLE public.doradztwo_nowy OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 6059306)
-- Name: doradztwo_nowy_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doradztwo_nowy_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doradztwo_nowy_del_id_seq OWNER TO postgres;

--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 234
-- Name: doradztwo_nowy_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doradztwo_nowy_del_id_seq OWNED BY public.doradztwo_nowy.del_id;


--
-- TOC entry 235 (class 1259 OID 6059308)
-- Name: dostawcy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dostawcy (
    ds_id bigint NOT NULL,
    ds_kod character varying(10),
    ds_nazwa character varying(200),
    ds_przedstawiciel character varying(100),
    ds_stanowisko character varying(100),
    ds_ulica character varying(200),
    ds_nrdomu character varying(15),
    ds_nrlokalu character varying(15),
    ds_kodpocztowy character varying(15),
    ds_miasto character varying(100),
    ds_tel character varying(50),
    ds_telkom character varying(50),
    ds_fax character varying(50),
    ds_email character varying(100),
    ds_www character varying(100),
    ds_nip character varying(100),
    ds_kraj character varying(100),
    ds_dostawca boolean,
    ds_kooperant boolean,
    ds_projektant boolean,
    ds_info text
);


ALTER TABLE public.dostawcy OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 6059314)
-- Name: dostawcy_ds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dostawcy_ds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dostawcy_ds_id_seq OWNER TO postgres;

--
-- TOC entry 4060 (class 0 OID 0)
-- Dependencies: 236
-- Name: dostawcy_ds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dostawcy_ds_id_seq OWNED BY public.dostawcy.ds_id;


SET default_with_oids = false;

--
-- TOC entry 237 (class 1259 OID 6059316)
-- Name: dousuniecia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dousuniecia (
    id bigint NOT NULL,
    rys_label character varying(17),
    zmiana integer DEFAULT 0,
    id_zespol integer DEFAULT 1136,
    id_rysunki bigint
);


ALTER TABLE public.dousuniecia OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 6059321)
-- Name: drzewo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drzewo (
    dr_id bigint NOT NULL,
    dr_did bigint,
    dr_parent_id bigint,
    dr_lbl_element character varying(20),
    dr_nazwa character varying(100),
    id_kontrakt bigint,
    id_zespol bigint,
    id_rysunki bigint,
    id_detale bigint,
    dr_tag character varying(100),
    dr_ikona integer,
    dr_ilszt integer
);


ALTER TABLE public.drzewo OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 6059324)
-- Name: drzewo_dr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drzewo_dr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drzewo_dr_id_seq OWNER TO postgres;

--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 239
-- Name: drzewo_dr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drzewo_dr_id_seq OWNED BY public.drzewo.dr_id;


--
-- TOC entry 240 (class 1259 OID 6059326)
-- Name: drzewo_rysunki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drzewo_rysunki (
    dr_id bigint NOT NULL,
    dr_did bigint,
    dr_parent_id bigint,
    dr_lbl_element character varying(20),
    dr_nazwa character varying(100),
    id_kontrakt bigint,
    id_zespol bigint,
    id_rysunki bigint,
    id_detale bigint,
    dr_tag character varying(100),
    dr_ikona integer,
    dr_ilszt integer
);


ALTER TABLE public.drzewo_rysunki OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 6059329)
-- Name: drzewo_rysunki_dr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drzewo_rysunki_dr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drzewo_rysunki_dr_id_seq OWNER TO postgres;

--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 241
-- Name: drzewo_rysunki_dr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drzewo_rysunki_dr_id_seq OWNED BY public.drzewo_rysunki.dr_id;


SET default_with_oids = true;

--
-- TOC entry 242 (class 1259 OID 6059331)
-- Name: efekty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.efekty (
    id bigint DEFAULT nextval(('"efekty_id_seq"'::text)::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    id_zespol integer,
    el_kalkulacji text,
    wykonawca text DEFAULT 'INMET'::text,
    of_ciez text,
    of_wartosc numeric(10,2),
    przew_ciez numeric(8,2),
    przew_wartosc numeric(10,2),
    rozl_ciez numeric(8,2),
    rozl_wartosc numeric(10,2),
    flaga1 integer,
    flaga2 integer,
    flaga3 text,
    flagatyp integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    obiekt text
);


ALTER TABLE public.efekty OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 6059339)
-- Name: efekty_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.efekty_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.efekty_del_id_seq OWNER TO postgres;

--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 243
-- Name: efekty_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.efekty_del_id_seq OWNED BY public.efekty.del_id;


--
-- TOC entry 244 (class 1259 OID 6059341)
-- Name: efekty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.efekty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.efekty_id_seq OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 6059343)
-- Name: elementy_id_elementy_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.elementy_id_elementy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elementy_id_elementy_seq OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 6059345)
-- Name: firma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.firma (
    firma_id character varying(2) NOT NULL,
    nazwa text NOT NULL,
    przedstawiciel text,
    stanowisko text,
    ulica text NOT NULL,
    nrdomu text,
    nrlokalu text,
    kodpoczt text,
    miasto text NOT NULL,
    tel text,
    telkom text,
    fax text,
    email text,
    www text,
    nip text,
    info text,
    kraj text DEFAULT 'Polska'::text NOT NULL,
    dostawca boolean,
    kooperant boolean,
    odbiorca boolean,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    katalog character varying(100),
    koopdoc boolean DEFAULT false
);


ALTER TABLE public.firma OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 6059353)
-- Name: firma_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.firma_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.firma_del_id_seq OWNER TO postgres;

--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 247
-- Name: firma_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.firma_del_id_seq OWNED BY public.firma.del_id;


--
-- TOC entry 248 (class 1259 OID 6059355)
-- Name: formaty_id_formaty_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formaty_id_formaty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formaty_id_formaty_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 249 (class 1259 OID 6059357)
-- Name: formaty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formaty (
    id_formaty bigint DEFAULT nextval('public.formaty_id_formaty_seq'::regclass) NOT NULL,
    format numeric(6,3),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.formaty OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 6059361)
-- Name: formaty_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formaty_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formaty_del_id_seq OWNER TO postgres;

--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 250
-- Name: formaty_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.formaty_del_id_seq OWNED BY public.formaty.del_id;


SET default_with_oids = true;

--
-- TOC entry 251 (class 1259 OID 6059363)
-- Name: grupa_operacji; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupa_operacji (
    znak character varying(2) NOT NULL,
    gr_nazwa text NOT NULL,
    kolejnosc integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.grupa_operacji OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 6059369)
-- Name: grupa_operacji_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupa_operacji_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupa_operacji_del_id_seq OWNER TO postgres;

--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 252
-- Name: grupa_operacji_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupa_operacji_del_id_seq OWNED BY public.grupa_operacji.del_id;


--
-- TOC entry 253 (class 1259 OID 6059371)
-- Name: jednostki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jednostki (
    id integer DEFAULT nextval(('"jednostki_id_seq"'::text)::regclass) NOT NULL,
    opis character varying(20),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.jednostki OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 6059375)
-- Name: jednostki_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jednostki_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jednostki_del_id_seq OWNER TO postgres;

--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 254
-- Name: jednostki_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jednostki_del_id_seq OWNED BY public.jednostki.del_id;


--
-- TOC entry 255 (class 1259 OID 6059377)
-- Name: jednostki_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jednostki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.jednostki_id_seq OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 6059379)
-- Name: kontr_opis_id_kontr_opis_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontr_opis_id_kontr_opis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kontr_opis_id_kontr_opis_seq OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 6059381)
-- Name: kontrahent2_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrahent2_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kontrahent2_del_id_seq OWNER TO postgres;

--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 257
-- Name: kontrahent2_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kontrahent2_del_id_seq OWNED BY public.kontrahent2.del_id;


--
-- TOC entry 258 (class 1259 OID 6059383)
-- Name: kontrahent_id_kontrah_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrahent_id_kontrah_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.kontrahent_id_kontrah_seq OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 6059385)
-- Name: kontrakt2_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrakt2_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kontrakt2_del_id_seq OWNER TO postgres;

--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 259
-- Name: kontrakt2_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kontrakt2_del_id_seq OWNED BY public.kontrakt2.del_id;


--
-- TOC entry 260 (class 1259 OID 6059387)
-- Name: kontrakt2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrakt2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.kontrakt2_id_seq OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 6059389)
-- Name: kontrakt_finanse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kontrakt_finanse (
    id_kontrakt_finanse bigint NOT NULL,
    id_kontrakt integer,
    nr_faktury character varying(100),
    data_wystawienia date,
    kwota_netto numeric(10,2),
    opis text,
    kwotaeuro numeric(10,2),
    kurs numeric(10,2)
);


ALTER TABLE public.kontrakt_finanse OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 6059395)
-- Name: kontrakt_finanse_id_kontrakt_finanse_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrakt_finanse_id_kontrakt_finanse_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kontrakt_finanse_id_kontrakt_finanse_seq OWNER TO postgres;

--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 262
-- Name: kontrakt_finanse_id_kontrakt_finanse_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kontrakt_finanse_id_kontrakt_finanse_seq OWNED BY public.kontrakt_finanse.id_kontrakt_finanse;


--
-- TOC entry 263 (class 1259 OID 6059397)
-- Name: kontrakt_id_kontrakt_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kontrakt_id_kontrakt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.kontrakt_id_kontrakt_seq OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 6059399)
-- Name: kooperacja2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacja2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacja2_id_seq OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 6059401)
-- Name: kooperacja2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kooperacja2 (
    id integer DEFAULT nextval('public.kooperacja2_id_seq'::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    rys_label character varying(19),
    opis text,
    wykonawca text,
    faktura character varying(50),
    cena_zakladana numeric(15,2) DEFAULT 0,
    cena_ofertowa numeric(15,2) DEFAULT 0,
    cena_rozliczeniowa numeric(15,2) DEFAULT 0,
    rozliczona boolean DEFAULT false,
    komentarz text,
    sztuki numeric(15,2) DEFAULT 1,
    oferta date,
    zamowienie date,
    termin_wykonania date,
    ilroboczogodz numeric(15,2) DEFAULT 0,
    cena_za_szt numeric(15,2) DEFAULT 0,
    koszt_uslugi_of numeric(15,2),
    ocena_jakosci character varying(50),
    reklamacja character varying(50),
    uwagi text,
    wyslano boolean DEFAULT false,
    wykonano boolean DEFAULT false,
    zapytanie_data date,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.kooperacja2 OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 6059417)
-- Name: kooperacja2_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacja2_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacja2_del_id_seq OWNER TO postgres;

--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 266
-- Name: kooperacja2_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kooperacja2_del_id_seq OWNED BY public.kooperacja2.del_id;


--
-- TOC entry 267 (class 1259 OID 6059419)
-- Name: kooperacja_bckp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacja_bckp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacja_bckp_id_seq OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 6059421)
-- Name: kooperacja_bckp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kooperacja_bckp (
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    numer character varying(100),
    tresc character varying(100),
    firma character varying(50),
    kwota numeric(10,2),
    id integer DEFAULT nextval('public.kooperacja_bckp_id_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.kooperacja_bckp OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 6059425)
-- Name: kooperacja_bckp_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacja_bckp_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacja_bckp_del_id_seq OWNER TO postgres;

--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 269
-- Name: kooperacja_bckp_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kooperacja_bckp_del_id_seq OWNED BY public.kooperacja_bckp.del_id;


--
-- TOC entry 270 (class 1259 OID 6059427)
-- Name: kooperacja_raport_szef; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.kooperacja_raport_szef AS
 SELECT k.id,
    k.id_kontrakt,
    k.id_zespol,
    k.rys_label,
    k.opis,
    k.wykonawca,
    k.faktura,
    k.cena_zakladana,
    k.cena_ofertowa,
    k.cena_rozliczeniowa,
    public.iff((k.rozliczona = true), 'X'::text, '-'::text) AS rozliczony,
    k.komentarz,
    k.sztuki,
    k.oferta,
    k.zamowienie,
    k.termin_wykonania,
    k.ilroboczogodz,
    k.cena_za_szt,
    k.koszt_uslugi_of,
    k.ocena_jakosci,
    k.reklamacja,
    k.uwagi,
    k.wyslano,
    k.wykonano,
    k.zapytanie_data,
    z.zesp_label
   FROM public.kooperacja2 k,
    public.zespoly z
  WHERE (k.id_zespol = z.id);


ALTER TABLE public.kooperacja_raport_szef OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 6059432)
-- Name: kooperacjadok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kooperacjadok (
    id_kooperacjadok bigint NOT NULL,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    wykonawca text,
    opis text,
    faktura character varying(50),
    cena_zakladana numeric(15,2) DEFAULT 0,
    cena_ofertowa numeric(15,2) DEFAULT 0,
    cena_rozliczeniowa numeric(15,2) DEFAULT 0,
    rozliczona boolean DEFAULT false,
    komentarz text,
    termin_wykonania date,
    uwagi text,
    data1raty date,
    rata1 numeric(10,2) DEFAULT 0,
    data2raty date,
    rata2 numeric(10,2) DEFAULT 0,
    data3raty date,
    rata3 numeric(10,3) DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.kooperacjadok OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 6059445)
-- Name: kooperacjadok_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacjadok_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacjadok_del_id_seq OWNER TO postgres;

--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 272
-- Name: kooperacjadok_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kooperacjadok_del_id_seq OWNED BY public.kooperacjadok.del_id;


--
-- TOC entry 273 (class 1259 OID 6059447)
-- Name: kooperacjadok_id_kooperacjadok_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacjadok_id_kooperacjadok_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacjadok_id_kooperacjadok_seq OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 6059449)
-- Name: kooperacjadok_id_kooperacjadok_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kooperacjadok_id_kooperacjadok_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kooperacjadok_id_kooperacjadok_seq1 OWNER TO postgres;

--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 274
-- Name: kooperacjadok_id_kooperacjadok_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kooperacjadok_id_kooperacjadok_seq1 OWNED BY public.kooperacjadok.id_kooperacjadok;


--
-- TOC entry 275 (class 1259 OID 6059451)
-- Name: koszty_ogolne_id_koszty_ogolne_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.koszty_ogolne_id_koszty_ogolne_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.koszty_ogolne_id_koszty_ogolne_seq OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 6059453)
-- Name: koszty_ogolne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.koszty_ogolne (
    nazwa character varying(40) NOT NULL,
    zaplanowane numeric(10,2),
    wykonane numeric(10,2),
    id_kontrakt smallint NOT NULL,
    kolejnosc smallint,
    id_koszty_ogolne bigint DEFAULT nextval('public.koszty_ogolne_id_koszty_ogolne_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    grupa smallint
);


ALTER TABLE public.koszty_ogolne OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 6059457)
-- Name: koszty_ogolne_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.koszty_ogolne_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.koszty_ogolne_del_id_seq OWNER TO postgres;

--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 277
-- Name: koszty_ogolne_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.koszty_ogolne_del_id_seq OWNED BY public.koszty_ogolne.del_id;


--
-- TOC entry 278 (class 1259 OID 6059459)
-- Name: log_rysunki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_rysunki (
    id integer DEFAULT nextval(('"log_rysunki_id_seq"'::text)::regclass) NOT NULL,
    id_zespol integer NOT NULL,
    rys_label character varying(19) NOT NULL,
    nazwa_rysunku text NOT NULL,
    numer_rys integer,
    rodzaj_rys character varying(19) NOT NULL,
    il_sztuk integer DEFAULT 1 NOT NULL,
    czas_projektowania real,
    data date DEFAULT ('now'::text)::date,
    komentarz text,
    ilosc_a1 real DEFAULT 1 NOT NULL,
    nr_edycji integer DEFAULT 1 NOT NULL,
    min_maks_nr text,
    osobaodp text NOT NULL,
    data_wpl date,
    id_kontrakt integer,
    wielokrotny integer DEFAULT '-1'::integer,
    wieloczesc integer DEFAULT 0,
    kolejny_rys integer DEFAULT 0,
    wsp_korekcji double precision DEFAULT 1,
    wykonczenie character varying(30),
    podzespol smallint DEFAULT 0,
    rodz_kooperacji smallint DEFAULT 0,
    gotowe boolean DEFAULT false,
    zrobione integer DEFAULT 0,
    rozliczone integer DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data timestamp without time zone,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    arkusz integer DEFAULT 1 NOT NULL,
    rys_id bigint
);


ALTER TABLE public.log_rysunki OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 6059480)
-- Name: log_rysunki_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_rysunki_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.log_rysunki_del_id_seq OWNER TO postgres;

--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 279
-- Name: log_rysunki_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_rysunki_del_id_seq OWNED BY public.log_rysunki.del_id;


--
-- TOC entry 280 (class 1259 OID 6059482)
-- Name: log_rysunki_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_rysunki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.log_rysunki_id_seq OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 6059484)
-- Name: logi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logi (
    uzytkownik character varying(20),
    login_time text,
    log_out_time text,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.logi OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 6059490)
-- Name: logi_danych; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logi_danych (
    ld_id bigint NOT NULL,
    ld_czas timestamp without time zone DEFAULT now(),
    ld_user character varying(100) NOT NULL,
    ld_zdarzenie text,
    id_zespol bigint,
    numer character varying(100),
    ld_element character varying(100)
);


ALTER TABLE public.logi_danych OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 6059497)
-- Name: logi_danych_ld_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logi_danych_ld_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logi_danych_ld_id_seq OWNER TO postgres;

--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 283
-- Name: logi_danych_ld_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logi_danych_ld_id_seq OWNED BY public.logi_danych.ld_id;


--
-- TOC entry 284 (class 1259 OID 6059499)
-- Name: logi_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logi_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logi_del_id_seq OWNER TO postgres;

--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 284
-- Name: logi_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logi_del_id_seq OWNED BY public.logi.del_id;


--
-- TOC entry 285 (class 1259 OID 6059501)
-- Name: magazyn_normalia_id_magazyn_normalia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.magazyn_normalia_id_magazyn_normalia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.magazyn_normalia_id_magazyn_normalia_seq OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 6059503)
-- Name: magazyn_normalia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.magazyn_normalia (
    id_magazyn_normalia bigint DEFAULT nextval('public.magazyn_normalia_id_magazyn_normalia_seq'::regclass) NOT NULL,
    nazwa character varying(100) NOT NULL,
    dostawca character varying(100),
    symbol character varying(100),
    koszt_jednostkowy double precision,
    ilosc_sztuk smallint DEFAULT 1 NOT NULL,
    koszt_calkowity double precision,
    opis text,
    uzytkownik_zmieniajacy character varying(50),
    zesp_label character varying(10),
    numer integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    id_branza bigint,
    id_subbranza bigint
);


ALTER TABLE public.magazyn_normalia OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 6059511)
-- Name: magazyn_normalia_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.magazyn_normalia_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.magazyn_normalia_del_id_seq OWNER TO postgres;

--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 287
-- Name: magazyn_normalia_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.magazyn_normalia_del_id_seq OWNED BY public.magazyn_normalia.del_id;


--
-- TOC entry 288 (class 1259 OID 6059513)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    nazwa character varying(20) NOT NULL,
    masa double precision NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 6059516)
-- Name: material_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.material_del_id_seq OWNER TO postgres;

--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 289
-- Name: material_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_del_id_seq OWNED BY public.material.del_id;


--
-- TOC entry 290 (class 1259 OID 6059518)
-- Name: material_id_material_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_id_material_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.material_id_material_seq OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 6059520)
-- Name: miesiace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.miesiace (
    numer integer NOT NULL,
    nazwa character varying(20) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.miesiace OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 6059523)
-- Name: miesiace_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.miesiace_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.miesiace_del_id_seq OWNER TO postgres;

--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 292
-- Name: miesiace_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.miesiace_del_id_seq OWNED BY public.miesiace.del_id;


--
-- TOC entry 293 (class 1259 OID 6059525)
-- Name: normalia2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.normalia2 (
    id integer NOT NULL,
    id_rysunki integer,
    numer integer NOT NULL,
    nazwa text NOT NULL,
    ilosc_sztuk integer NOT NULL,
    opis text,
    edycja text,
    cena double precision,
    kosztcalkowity double precision,
    dostawca text,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    cena_rozl double precision DEFAULT 0,
    rozliczony boolean DEFAULT false,
    stan_czesci integer DEFAULT 0,
    symbol character varying(200),
    data_dostawy date,
    status integer DEFAULT 0,
    data_zaplaty date,
    uzytkownik_zmieniajacy character varying(50),
    forma_zaplaty integer,
    termin_platnosci integer,
    przelew double precision,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    branza character varying(30),
    subbranza character varying(30),
    il_z_magazynu integer DEFAULT 0,
    tymczasowa boolean,
    data_wpl date
);


ALTER TABLE public.normalia2 OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 6059536)
-- Name: normalia_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.normalia_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.normalia_del_id_seq OWNER TO postgres;

--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 294
-- Name: normalia_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.normalia_del_id_seq OWNED BY public.normalia.del_id;


--
-- TOC entry 295 (class 1259 OID 6059538)
-- Name: normalia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.normalia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.normalia_id_seq OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 6059540)
-- Name: normalia_raport_szef; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.normalia_raport_szef AS
 SELECT n.id,
    n.id_rysunki,
    n.numer,
    n.nazwa,
    n.symbol,
    n.ilosc_sztuk,
    n.opis,
    n.cena,
    ((n.ilosc_sztuk)::double precision * n.cena) AS kosztcalkowity,
    n.id_kontrakt,
    n.id_zespol,
    public.iff((n.rozliczony = true), 'X'::text, '-'::text) AS rozliczony,
    n.cena_rozl,
    n.stan_czesci,
    z.zesp_label,
    n.data_dostawy,
    n.dostawca,
    n.il_z_magazynu,
    n.tymczasowa,
    n.data_wpl
   FROM (public.normalia n
     JOIN public.zespoly z ON ((n.id_zespol = z.id)))
  ORDER BY n.numer;


ALTER TABLE public.normalia_raport_szef OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 6059545)
-- Name: operacje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operacje (
    znak character varying(2) NOT NULL,
    op_nazwa text NOT NULL,
    grupa character varying(2) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.operacje OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 6059551)
-- Name: r_plan_temp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.r_plan_temp (
    id bigint DEFAULT nextval(('"r_plan_temp_id_seq"'::text)::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    id_rysunek integer,
    id_detal integer,
    data_wydania date DEFAULT ('now'::text)::date,
    wykonanie boolean DEFAULT true,
    kooperant text DEFAULT ' '::text,
    znak_grupy character varying(10) NOT NULL,
    znak_operacji character varying(10) NOT NULL,
    planowana double precision DEFAULT (0)::double precision,
    uwagi text,
    kolejnosc_nstd integer,
    wykonczenie text,
    cena_kooperacji numeric(10,2),
    il_sztuk smallint,
    opis_operacji character varying(80),
    klucz_obj character varying(10),
    zrobione smallint DEFAULT 0,
    data_wydruku date,
    bufor_plan double precision DEFAULT 0,
    przewodnik bigint,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    filtr boolean
);


ALTER TABLE public.r_plan_temp OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 6059564)
-- Name: obciazenie_maszyn; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.obciazenie_maszyn AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    grupa_operacji.znak AS znak_gr,
    operacje.znak,
    zespoly.zesp_label,
    grupa_operacji.gr_nazwa,
    operacje.op_nazwa,
    sum(r_plan_temp.planowana) AS suma_plan,
    zespoly.nazwa_zespolu
   FROM public.operacje,
    public.r_plan_temp,
    public.grupa_operacji,
    public.zespoly
  WHERE (((operacje.znak)::text = (r_plan_temp.znak_operacji)::text) AND ((r_plan_temp.znak_grupy)::text = (grupa_operacji.znak)::text) AND (r_plan_temp.id_zespol = zespoly.id))
  GROUP BY zespoly.zesp_label, grupa_operacji.kolejnosc, operacje.op_nazwa, r_plan_temp.id_kontrakt, grupa_operacji.gr_nazwa, r_plan_temp.zrobione, zespoly.nazwa_zespolu, operacje.znak, r_plan_temp.id_zespol, grupa_operacji.znak
 HAVING (r_plan_temp.zrobione = 0)
  ORDER BY zespoly.zesp_label, grupa_operacji.kolejnosc, operacje.op_nazwa;


ALTER TABLE public.obciazenie_maszyn OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 300 (class 1259 OID 6059569)
-- Name: of_efekt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.of_efekt (
    id_of_efekt bigint DEFAULT nextval(('"of_efekt_id_seq"'::text)::regclass) NOT NULL,
    id_oferta integer NOT NULL,
    id_zespol integer,
    el_kalkulacji text,
    wykonawca text DEFAULT 'INMET'::text,
    of_ciez numeric(10,2),
    of_wartosc numeric(10,2),
    flaga1 integer,
    flaga2 integer,
    flaga3 text,
    flagatyp integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    obiekt text,
    of_wsp_ryzyka numeric(10,2)
);


ALTER TABLE public.of_efekt OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 6059577)
-- Name: of_efekt_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.of_efekt_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.of_efekt_del_id_seq OWNER TO postgres;

--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 301
-- Name: of_efekt_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.of_efekt_del_id_seq OWNED BY public.of_efekt.del_id;


--
-- TOC entry 302 (class 1259 OID 6059579)
-- Name: of_efekt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.of_efekt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.of_efekt_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 303 (class 1259 OID 6059581)
-- Name: of_zespoly; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.of_zespoly (
    of_zesp_id integer DEFAULT nextval(('"of_zespoly_id_seq"'::text)::regclass) NOT NULL,
    id_oferta integer NOT NULL,
    numer integer NOT NULL,
    of_zesp_label character varying(9) NOT NULL,
    of_nazwa_zespolu text NOT NULL,
    opis1 text,
    opis2 text,
    opis3 text,
    opis4 text,
    opis5 text,
    kategoria text,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.of_zespoly OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 6059588)
-- Name: of_zespoly_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.of_zespoly_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.of_zespoly_del_id_seq OWNER TO postgres;

--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 304
-- Name: of_zespoly_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.of_zespoly_del_id_seq OWNED BY public.of_zespoly.del_id;


--
-- TOC entry 305 (class 1259 OID 6059590)
-- Name: oferta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oferta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oferta_id_seq OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 6059592)
-- Name: oferta_zespoly; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oferta_zespoly (
    ofz_id integer DEFAULT nextval(('"oferta_zespoly_id_seq"'::text)::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    numer integer NOT NULL,
    zesp_label character varying(9) NOT NULL,
    nazwa_zespolu text NOT NULL,
    opis1 text,
    opis2 text,
    opis3 text,
    opis4 text,
    opis5 text,
    kategoria text,
    procent_wyplaty numeric(4,1) DEFAULT 0,
    zatwierdzony boolean DEFAULT false,
    data1raty date,
    rata1 numeric(10,2) DEFAULT 0,
    data2raty date,
    rata2 numeric(10,2) DEFAULT 0,
    databledu date,
    bledy numeric(10,2) DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    proj_wiodacy character varying(50),
    cena_stali numeric(5,2) DEFAULT 3.5,
    termin_wykonania date
);


ALTER TABLE public.oferta_zespoly OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 6059605)
-- Name: oferta_zespoly_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.oferta_zespoly_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oferta_zespoly_del_id_seq OWNER TO postgres;

--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 307
-- Name: oferta_zespoly_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.oferta_zespoly_del_id_seq OWNED BY public.oferta_zespoly.del_id;


--
-- TOC entry 308 (class 1259 OID 6059607)
-- Name: ofertowanie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ofertowanie (
    id_oferta bigint DEFAULT nextval(('"oferta_id_seq"'::text)::regclass) NOT NULL,
    of_znak character varying(5) NOT NULL,
    of_numer integer NOT NULL,
    of_nrlabel character varying(12),
    of_temat text,
    of_data date,
    of_datastop date,
    of_osobaodp text,
    of_info text,
    of_wartosc numeric(10,2),
    of_nrfaktury text,
    of_konieckontr integer DEFAULT 0 NOT NULL,
    of_kosztrbg numeric(8,2),
    of_kosztproj numeric(8,2),
    of_zleu numeric(4,2),
    of_procent_wyplaty bigint DEFAULT 50,
    of_data_przeliczenia date,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    of_katalog character varying(100),
    of_wartosc_euro numeric(10,2) DEFAULT 0,
    of_cena_stali numeric(5,2),
    of_koszt_bledu numeric(5,2) DEFAULT 42
);


ALTER TABLE public.ofertowanie OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 6059618)
-- Name: ofertowanie_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ofertowanie_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ofertowanie_del_id_seq OWNER TO postgres;

--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 309
-- Name: ofertowanie_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ofertowanie_del_id_seq OWNED BY public.ofertowanie.del_id;


--
-- TOC entry 310 (class 1259 OID 6059620)
-- Name: operacje_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operacje_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operacje_del_id_seq OWNER TO postgres;

--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 310
-- Name: operacje_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operacje_del_id_seq OWNED BY public.operacje.del_id;


--
-- TOC entry 311 (class 1259 OID 6059622)
-- Name: operacje_id-operacje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."operacje_id-operacje_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public."operacje_id-operacje_seq" OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 6059624)
-- Name: operacje_id_operacje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operacje_id_operacje_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.operacje_id_operacje_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 313 (class 1259 OID 6059626)
-- Name: opisy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opisy (
    id_opisy bigint NOT NULL,
    nazwa character varying(30),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.opisy OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 6059629)
-- Name: opisy_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opisy_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opisy_del_id_seq OWNER TO postgres;

--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 314
-- Name: opisy_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opisy_del_id_seq OWNED BY public.opisy.del_id;


--
-- TOC entry 315 (class 1259 OID 6059631)
-- Name: opisy_id_opisy_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opisy_id_opisy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opisy_id_opisy_seq OWNER TO postgres;

--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 315
-- Name: opisy_id_opisy_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opisy_id_opisy_seq OWNED BY public.opisy.id_opisy;


--
-- TOC entry 316 (class 1259 OID 6059633)
-- Name: opisy_koop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opisy_koop (
    id_opisy_koop bigint NOT NULL,
    nazwa character varying(300),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.opisy_koop OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 6059639)
-- Name: opisy_koop_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opisy_koop_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opisy_koop_del_id_seq OWNER TO postgres;

--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 317
-- Name: opisy_koop_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opisy_koop_del_id_seq OWNED BY public.opisy_koop.del_id;


--
-- TOC entry 318 (class 1259 OID 6059641)
-- Name: opisy_koop_id_opisy_koop_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opisy_koop_id_opisy_koop_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opisy_koop_id_opisy_koop_seq OWNER TO postgres;

--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 318
-- Name: opisy_koop_id_opisy_koop_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opisy_koop_id_opisy_koop_seq OWNED BY public.opisy_koop.id_opisy_koop;


--
-- TOC entry 319 (class 1259 OID 6059643)
-- Name: piaskowanie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.piaskowanie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.piaskowanie_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 320 (class 1259 OID 6059645)
-- Name: piaskowanie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.piaskowanie (
    id_kontrakt integer NOT NULL,
    numer character varying(100),
    firma character varying(50),
    kwota numeric(10,2),
    id bigint DEFAULT nextval('public.piaskowanie_id_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.piaskowanie OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 6059649)
-- Name: piaskowanie_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.piaskowanie_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.piaskowanie_del_id_seq OWNER TO postgres;

--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 321
-- Name: piaskowanie_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.piaskowanie_del_id_seq OWNED BY public.piaskowanie.del_id;


--
-- TOC entry 322 (class 1259 OID 6059651)
-- Name: plan_robota; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.plan_robota AS
 SELECT sum(r_plan_temp.planowana) AS sum,
    r_plan_temp.id_zespol,
    r_plan_temp.znak_grupy,
    r_plan_temp.opis_operacji
   FROM public.r_plan_temp
  GROUP BY r_plan_temp.id_zespol, r_plan_temp.znak_grupy, r_plan_temp.opis_operacji;


ALTER TABLE public.plan_robota OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 6059655)
-- Name: planowanie_robocizny; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.planowanie_robocizny AS
 SELECT r_plan_temp.id,
    r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    r_plan_temp.id_rysunek,
    r_plan_temp.id_detal,
    r_plan_temp.data_wydania,
    r_plan_temp.wykonanie,
    r_plan_temp.kooperant,
    r_plan_temp.znak_grupy,
    r_plan_temp.znak_operacji,
    r_plan_temp.planowana,
    r_plan_temp.uwagi,
    r_plan_temp.kolejnosc_nstd,
    r_plan_temp.wykonczenie,
    r_plan_temp.cena_kooperacji,
    r_plan_temp.il_sztuk,
    r_plan_temp.opis_operacji,
    r_plan_temp.klucz_obj,
    r_plan_temp.data_wydruku,
    rysunki2.nazwa_rysunku AS nazwa_rys,
    rysunki2.rys_label AS num_rys,
    kontrakt2.nrlabel AS num_kontr,
    detale.numer AS num_pozycji,
    grupa_operacji.kolejnosc AS kolejnosc_g,
    grupa_operacji.gr_nazwa AS nazwa_g
   FROM public.grupa_operacji,
    public.kontrakt2,
    public.rysunki2,
    (public.r_plan_temp
     LEFT JOIN public.detale ON ((r_plan_temp.id_detal = detale.id)))
  WHERE (((grupa_operacji.znak)::text = (r_plan_temp.znak_grupy)::text) AND (kontrakt2.id = r_plan_temp.id_kontrakt) AND (r_plan_temp.id_rysunek = rysunki2.id))
  ORDER BY grupa_operacji.kolejnosc, rysunki2.rys_label, r_plan_temp.kolejnosc_nstd;


ALTER TABLE public.planowanie_robocizny OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 6059660)
-- Name: podzespol_id_czesc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.podzespol_id_czesc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.podzespol_id_czesc_seq OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 6059662)
-- Name: postac_wsad_id_postac_wsad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postac_wsad_id_postac_wsad_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.postac_wsad_id_postac_wsad_seq OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 6059664)
-- Name: postac_wsadu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postac_wsadu (
    wsad character varying(50) NOT NULL,
    wzor character varying(40) NOT NULL,
    pole_a boolean,
    pole_b boolean,
    pole_c boolean,
    mj_pole_a boolean,
    cb_a character varying(20),
    cb_b character varying(20),
    cb_c character varying(20),
    mj_a boolean DEFAULT true,
    mj_b boolean DEFAULT true,
    mj_c boolean DEFAULT true,
    opis_a character varying(40),
    opis_b character varying(40),
    opis_c character varying(40),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.postac_wsadu OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 6059670)
-- Name: postac_wsadu_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postac_wsadu_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.postac_wsadu_del_id_seq OWNER TO postgres;

--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 327
-- Name: postac_wsadu_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.postac_wsadu_del_id_seq OWNED BY public.postac_wsadu.del_id;


--
-- TOC entry 328 (class 1259 OID 6059672)
-- Name: pracownicy_id_pracownik_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownicy_id_pracownik_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pracownicy_id_pracownik_seq OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 6059674)
-- Name: pracownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pracownicy (
    nazwisko character varying NOT NULL,
    grupa_zaw character varying(2) NOT NULL,
    stawka double precision,
    info text,
    miejsce_p integer,
    status smallint DEFAULT 1,
    id_pracownik bigint DEFAULT nextval('public.pracownicy_id_pracownik_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    user_name character varying(50)
);


ALTER TABLE public.pracownicy OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 6059682)
-- Name: pracownicy_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pracownicy_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pracownicy_del_id_seq OWNER TO postgres;

--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 330
-- Name: pracownicy_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pracownicy_del_id_seq OWNED BY public.pracownicy.del_id;


--
-- TOC entry 331 (class 1259 OID 6059684)
-- Name: prawa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prawa (
    id integer DEFAULT nextval(('"prawa_id_seq"'::text)::regclass) NOT NULL,
    uzytkownik character varying(50) NOT NULL,
    caption character varying(50),
    val1 smallint,
    val2 character varying(100),
    val3 character varying(100),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.prawa OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 6059691)
-- Name: prawa_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prawa_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prawa_del_id_seq OWNER TO postgres;

--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 332
-- Name: prawa_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prawa_del_id_seq OWNED BY public.prawa.del_id;


--
-- TOC entry 333 (class 1259 OID 6059693)
-- Name: prawa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prawa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.prawa_id_seq OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 6059695)
-- Name: procedurySQL_idprocedurySql_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."procedurySQL_idprocedurySql_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."procedurySQL_idprocedurySql_seq" OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 6059697)
-- Name: procedurySQL; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."procedurySQL" (
    "idprocedurySql" bigint DEFAULT nextval('public."procedurySQL_idprocedurySql_seq"'::regclass) NOT NULL,
    nazwa_grupy character varying(40),
    nazwa_obiektu character varying(30),
    nazwa_elementu character varying(30),
    cialo text,
    modul character varying(30),
    parametr character varying(30),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public."procedurySQL" OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 6059704)
-- Name: procedurySQL_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."procedurySQL_del_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."procedurySQL_del_id_seq" OWNER TO postgres;

--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 336
-- Name: procedurySQL_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."procedurySQL_del_id_seq" OWNED BY public."procedurySQL".del_id;


--
-- TOC entry 337 (class 1259 OID 6059706)
-- Name: projektanci_raport_szef; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.projektanci_raport_szef AS
 SELECT rysunki2.osobaodp,
    rysunki2.rys_label,
    rysunki2.nazwa_rysunku,
    rysunki2.czas_projektowania,
    rysunki2.data_wpl,
    rysunki2.ilosc_a1,
    rysunki2.wsp_korekcji,
    (((public.cenarysunku(rysunki2.rodzaj_rys))::double precision * rysunki2.wsp_korekcji) * rysunki2.ilosc_a1) AS ce_rys,
    rysunki2.id_kontrakt,
    rysunki2.id_zespol,
    rysunki2.id,
    "substring"((rysunki2.rys_label)::text, 1, 8) AS zesp_label,
    rysunki2.rodzaj_rys,
    rysunki2.arkusz,
    rysunki2.wieloczesc
   FROM public.rysunki2
  ORDER BY rysunki2.rys_label;


ALTER TABLE public.projektanci_raport_szef OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 6059711)
-- Name: projektanci_sumy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projektanci_sumy (
    idprojektancisumy bigint DEFAULT nextval(('"projektanci_sumy_idProjektanciSumy_seq"'::text)::regclass) NOT NULL,
    id_kontrakt bigint,
    id_zespol bigint,
    zesp_label character varying(8),
    projektant character varying(50),
    naleznosci numeric(10,2),
    data1raty date,
    rata1 numeric(10,2),
    data2raty date,
    rata2 numeric(10,2),
    databledu date,
    bledy numeric(10,2),
    kontr_label character varying(150),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.projektanci_sumy OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 6059715)
-- Name: projektanci_sumy_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projektanci_sumy_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projektanci_sumy_del_id_seq OWNER TO postgres;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 339
-- Name: projektanci_sumy_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projektanci_sumy_del_id_seq OWNED BY public.projektanci_sumy.del_id;


--
-- TOC entry 340 (class 1259 OID 6059717)
-- Name: projektanci_sumy_idProjektanciSumy_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."projektanci_sumy_idProjektanciSumy_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."projektanci_sumy_idProjektanciSumy_seq" OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 6059719)
-- Name: przyczyna; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.przyczyna (
    znak character varying(2) NOT NULL,
    pr_nazwa text NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.przyczyna OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 6059725)
-- Name: przyczyna_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.przyczyna_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.przyczyna_del_id_seq OWNER TO postgres;

--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 342
-- Name: przyczyna_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.przyczyna_del_id_seq OWNED BY public.przyczyna.del_id;


--
-- TOC entry 343 (class 1259 OID 6059727)
-- Name: r_plan_temp_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.r_plan_temp_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.r_plan_temp_del_id_seq OWNER TO postgres;

--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 343
-- Name: r_plan_temp_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.r_plan_temp_del_id_seq OWNED BY public.r_plan_temp.del_id;


--
-- TOC entry 344 (class 1259 OID 6059729)
-- Name: r_plan_temp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.r_plan_temp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.r_plan_temp_id_seq OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 6059731)
-- Name: raport_maszyny; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.raport_maszyny AS
 SELECT obciazenie_maszyn.id_kontrakt,
    obciazenie_maszyn.id_zespol,
    obciazenie_maszyn.nazwa_zespolu,
    obciazenie_maszyn.zesp_label,
    obciazenie_maszyn.znak_gr,
    obciazenie_maszyn.znak,
    obciazenie_maszyn.gr_nazwa,
    obciazenie_maszyn.op_nazwa,
    obciazenie_maszyn.suma_plan,
    r_plan_temp.planowana,
    rysunki2.rys_label
   FROM ((public.obciazenie_maszyn obciazenie_maszyn
     JOIN public.r_plan_temp r_plan_temp ON (((obciazenie_maszyn.id_kontrakt = r_plan_temp.id_kontrakt) AND (obciazenie_maszyn.id_zespol = r_plan_temp.id_zespol) AND ((obciazenie_maszyn.znak_gr)::text = (r_plan_temp.znak_grupy)::text) AND ((obciazenie_maszyn.znak)::text = (r_plan_temp.znak_operacji)::text))))
     JOIN public.rysunki2 rysunki2 ON ((r_plan_temp.id_rysunek = rysunki2.id)))
  WHERE (r_plan_temp.zrobione = 0);


ALTER TABLE public.raport_maszyny OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 6059736)
-- Name: raport_milka_lm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raport_milka_lm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.raport_milka_lm_id_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 347 (class 1259 OID 6059738)
-- Name: raport_milka; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raport_milka (
    lm_id bigint DEFAULT nextval('public.raport_milka_lm_id_seq'::regclass) NOT NULL,
    blat integer,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    id_rysunki integer NOT NULL,
    projektant character varying(50),
    wydany date,
    rys_label character varying(50),
    nr_rysunku character varying(50),
    nazwa_elementu character varying(100),
    od_do character varying(20),
    rodzaj_rys character varying(30),
    il_sztuk integer,
    planowana_data date,
    pociety integer,
    data_pociecia date,
    kooperacja_zamowienie numeric(15,2),
    kooperacja_dostawa numeric(15,2),
    gotowe integer,
    termin_wykonania date,
    koszt_jednostkowy numeric(10,2),
    koszt_calkowity numeric(10,2),
    robocizna numeric(15,2)
)
WITH (autovacuum_enabled='true');


ALTER TABLE public.raport_milka OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 6059742)
-- Name: rbac_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_role (
    rl_pk bigint NOT NULL,
    rl_rola character varying(1000),
    rl_przeznaczenie character varying(1000),
    rl_version numeric(1000,0),
    rl_audit_aplikacji character(1),
    rl_audit_danych character(1),
    ur_utworzony_przez numeric(1000,0),
    ur_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_role OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 6059749)
-- Name: rbac_role_rl_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_role_rl_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_role_rl_pk_seq OWNER TO postgres;

--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 349
-- Name: rbac_role_rl_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_role_rl_pk_seq OWNED BY public.rbac_role.rl_pk;


--
-- TOC entry 350 (class 1259 OID 6059751)
-- Name: rbac_role_uprawnienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_role_uprawnienia (
    rp_pk bigint NOT NULL,
    ua_pk bigint NOT NULL,
    rl_pk bigint NOT NULL,
    rp_akcja numeric(1000,0),
    rp_ograniczenia numeric(1000,0),
    rp_dane_dodatkowe character varying(254),
    rp_audit_aplikacji character(1),
    rp_audit_danych character(1),
    rp_data_od timestamp without time zone,
    rp_data_do timestamp without time zone,
    rp_data_akt timestamp without time zone,
    rp_utworzony_przez numeric(1000,0),
    rp_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_role_uprawnienia OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 6059758)
-- Name: rbac_role_uprawnienia_rp_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_role_uprawnienia_rp_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_role_uprawnienia_rp_pk_seq OWNER TO postgres;

--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 351
-- Name: rbac_role_uprawnienia_rp_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_role_uprawnienia_rp_pk_seq OWNED BY public.rbac_role_uprawnienia.rp_pk;


--
-- TOC entry 352 (class 1259 OID 6059760)
-- Name: rbac_uprawnienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_uprawnienia (
    ua_pk bigint NOT NULL,
    ua_klucz character varying(5760),
    ua_przeznaczenie character varying(1000),
    ua_kategoria character varying(10485760),
    ua_nie_do_odczytu character(1),
    ua_blokowana_akcja numeric(1000,0),
    ua_blokowany_komunikat character varying(1000),
    ua_audit_danych character(1),
    ua_audit_aplikacji character(1),
    ua_version numeric(1000,0),
    ua_utworzony_przez numeric(1000,0),
    ua_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_uprawnienia OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 6059767)
-- Name: rbac_uprawnienia_ua_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_uprawnienia_ua_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_uprawnienia_ua_pk_seq OWNER TO postgres;

--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 353
-- Name: rbac_uprawnienia_ua_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_uprawnienia_ua_pk_seq OWNED BY public.rbac_uprawnienia.ua_pk;


--
-- TOC entry 354 (class 1259 OID 6059769)
-- Name: rbac_uzytkownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_uzytkownicy (
    uz_pk bigint NOT NULL,
    uz_nazwa character varying(20) NOT NULL,
    uz_status character(1) DEFAULT 't'::bpchar NOT NULL,
    uz_nazwisko character varying(32) NOT NULL,
    uz_imiona character varying(32) NOT NULL,
    us_system_user character(1) NOT NULL,
    uz_profil character varying(32),
    uz_isadmin character(1) NOT NULL,
    uz_last_login timestamp without time zone NOT NULL,
    uz_last_logout timestamp without time zone,
    uz_telefon character varying(64),
    uz_dzial character varying(32),
    uz_email character varying(128),
    uz_version numeric(1000,0),
    uz_utworzony_przez numeric(1000,0),
    uz_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_uzytkownicy OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 6059777)
-- Name: rbac_uzytkownicy_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_uzytkownicy_role (
    ur_pk bigint NOT NULL,
    ur_uz_pk bigint NOT NULL,
    ur_rl_pk bigint NOT NULL,
    ur_data_od timestamp without time zone,
    ur_data_do timestamp without time zone,
    ur_data_akt timestamp without time zone,
    ur_utworzony_przez numeric(1000,0),
    ur_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_uzytkownicy_role OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 6059781)
-- Name: rbac_uzytkownicy_role_ur_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_uzytkownicy_role_ur_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_uzytkownicy_role_ur_pk_seq OWNER TO postgres;

--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 356
-- Name: rbac_uzytkownicy_role_ur_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_uzytkownicy_role_ur_pk_seq OWNED BY public.rbac_uzytkownicy_role.ur_pk;


--
-- TOC entry 357 (class 1259 OID 6059783)
-- Name: rbac_uzytkownicy_uprawnienia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rbac_uzytkownicy_uprawnienia (
    up_pk bigint NOT NULL,
    uz_pk bigint NOT NULL,
    up_ua_pk bigint NOT NULL,
    up_akcja numeric(1000,0),
    up_ograniczenia numeric(1000,0),
    up_dane_dodatkowe character varying(254),
    up_audit_aplikacji character(1),
    up_audit_danych character(1),
    up_data_od timestamp without time zone,
    up_data_do timestamp without time zone,
    up_data_akt timestamp without time zone,
    up_utworzony_przez numeric(1000,0),
    up_data_utworzenia timestamp without time zone DEFAULT now()
);


ALTER TABLE public.rbac_uzytkownicy_uprawnienia OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 6059790)
-- Name: rbac_uzytkownicy_uprawnienia_up_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_uzytkownicy_uprawnienia_up_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_uzytkownicy_uprawnienia_up_pk_seq OWNER TO postgres;

--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 358
-- Name: rbac_uzytkownicy_uprawnienia_up_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_uzytkownicy_uprawnienia_up_pk_seq OWNED BY public.rbac_uzytkownicy_uprawnienia.up_pk;


--
-- TOC entry 359 (class 1259 OID 6059792)
-- Name: rbac_uzytkownicy_uz_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rbac_uzytkownicy_uz_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rbac_uzytkownicy_uz_pk_seq OWNER TO postgres;

--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 359
-- Name: rbac_uzytkownicy_uz_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rbac_uzytkownicy_uz_pk_seq OWNED BY public.rbac_uzytkownicy.uz_pk;


--
-- TOC entry 360 (class 1259 OID 6059794)
-- Name: robocizna_id_robocizna_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_id_robocizna_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robocizna_id_robocizna_seq OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 6059796)
-- Name: robocizna_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.robocizna_plan_id_seq OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 6059798)
-- Name: robocizna_wyk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_wyk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.robocizna_wyk_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 363 (class 1259 OID 6059800)
-- Name: robocizna_wykonana; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.robocizna_wykonana (
    id bigint NOT NULL,
    id_kontrakt integer,
    id_zespol integer,
    id_rysunek integer,
    id_detal integer,
    id_robplan bigint,
    pracownik character varying(40) NOT NULL,
    wykonana double precision NOT NULL,
    data_wpl date DEFAULT ('now'::text)::date,
    uwagi text,
    zatwierdzil text NOT NULL,
    znak_operacji character varying(2) DEFAULT 'BR'::character varying,
    przyczyna character varying(100) DEFAULT 'BR'::character varying,
    status character varying(3),
    klucz_obj character varying(10),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.robocizna_wykonana OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 6059809)
-- Name: robocizna_wykonana_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_wykonana_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robocizna_wykonana_del_id_seq OWNER TO postgres;

--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 364
-- Name: robocizna_wykonana_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.robocizna_wykonana_del_id_seq OWNED BY public.robocizna_wykonana.del_id;


--
-- TOC entry 365 (class 1259 OID 6059811)
-- Name: robocizna_wykonana_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_wykonana_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robocizna_wykonana_id_seq OWNER TO postgres;

--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 365
-- Name: robocizna_wykonana_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.robocizna_wykonana_id_seq OWNED BY public.robocizna_wykonana.id;


SET default_with_oids = false;

--
-- TOC entry 366 (class 1259 OID 6059813)
-- Name: robocizna_wykonana_temp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.robocizna_wykonana_temp (
    id bigint,
    id_kontrakt integer,
    id_zespol integer,
    id_rysunek integer,
    id_detal integer,
    id_robplan integer,
    pracownik character varying(40) NOT NULL,
    wykonana double precision NOT NULL,
    data_wpl date DEFAULT ('now'::text)::date,
    uwagi text,
    zatwierdzil text NOT NULL,
    znak_operacji character varying(2) DEFAULT 'BR'::character varying,
    przyczyna character varying(100) DEFAULT 'BR'::character varying,
    status character varying(3),
    klucz_obj character varying(10),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.robocizna_wykonana_temp OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 6059822)
-- Name: robocizna_wykonana_temp_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.robocizna_wykonana_temp_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robocizna_wykonana_temp_del_id_seq OWNER TO postgres;

--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 367
-- Name: robocizna_wykonana_temp_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.robocizna_wykonana_temp_del_id_seq OWNED BY public.robocizna_wykonana_temp.del_id;


SET default_with_oids = true;

--
-- TOC entry 368 (class 1259 OID 6059824)
-- Name: rodz_prac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rodz_prac (
    id_rodz bigint DEFAULT nextval(('"rodz_prac_id_rodz_seq"'::text)::regclass) NOT NULL,
    rodzaj character varying(45),
    litera character varying(1),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.rodz_prac OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 6059828)
-- Name: rodz_prac_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rodz_prac_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rodz_prac_del_id_seq OWNER TO postgres;

--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 369
-- Name: rodz_prac_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rodz_prac_del_id_seq OWNED BY public.rodz_prac.del_id;


--
-- TOC entry 370 (class 1259 OID 6059830)
-- Name: rodz_prac_id_rodz_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rodz_prac_id_rodz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.rodz_prac_id_rodz_seq OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 6059832)
-- Name: rodzaj_rys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rodzaj_rys (
    nazwa text NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.rodzaj_rys OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 6059838)
-- Name: rodzaj_rys_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rodzaj_rys_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rodzaj_rys_del_id_seq OWNER TO postgres;

--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 372
-- Name: rodzaj_rys_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rodzaj_rys_del_id_seq OWNED BY public.rodzaj_rys.del_id;


--
-- TOC entry 373 (class 1259 OID 6059840)
-- Name: rozliczenie_kooperacji; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_kooperacji AS
 SELECT kooperacja2.id,
    kooperacja2.id_kontrakt,
    kooperacja2.id_zespol,
    kooperacja2.rys_label,
    kooperacja2.opis,
    kooperacja2.wykonawca,
    kooperacja2.faktura,
    kooperacja2.cena_zakladana,
    kooperacja2.cena_ofertowa,
    kooperacja2.cena_rozliczeniowa,
    public.iff((kooperacja2.rozliczona = true), 'TAK'::text, 'NIE'::text) AS rozliczona,
    kooperacja2.komentarz
   FROM public.kooperacja2
  ORDER BY kooperacja2.rys_label;


ALTER TABLE public.rozliczenie_kooperacji OWNER TO postgres;

--
-- TOC entry 374 (class 1259 OID 6059845)
-- Name: rozliczenie_maszyn; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_maszyn AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    r_plan_temp.znak_grupy,
    r_plan_temp.znak_operacji,
    zespoly.zesp_label,
    rysunki2.rys_label,
    rysunki2.nazwa_rysunku,
    r_plan_temp.planowana,
    r_plan_temp.zrobione
   FROM public.zespoly,
    (public.rysunki2
     RIGHT JOIN public.r_plan_temp ON ((rysunki2.id = r_plan_temp.id_rysunek)))
  WHERE ((zespoly.id = r_plan_temp.id_zespol) AND (r_plan_temp.zrobione = 0))
  ORDER BY zespoly.zesp_label, rysunki2.rys_label;


ALTER TABLE public.rozliczenie_maszyn OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 6059850)
-- Name: rozliczenie_proj_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rozliczenie_proj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rozliczenie_proj_id_seq OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 6059852)
-- Name: rozliczenie_proj; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rozliczenie_proj (
    id integer DEFAULT nextval('public.rozliczenie_proj_id_seq'::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    id_zespol integer NOT NULL,
    rys_label character varying(19),
    opis text,
    projektant character varying(150),
    wykonawca character varying(120),
    data_wykonania date,
    rob_wyk double precision DEFAULT 0,
    koszt_mat numeric(15,2) DEFAULT 0,
    rozliczona boolean DEFAULT false,
    komentarz text,
    faktura character varying(100),
    kooperacja numeric(15,2) DEFAULT 0,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    montaz numeric(10,2) DEFAULT 0,
    arkusz integer
);


ALTER TABLE public.rozliczenie_proj OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 6059864)
-- Name: rozliczenie_proj_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rozliczenie_proj_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rozliczenie_proj_del_id_seq OWNER TO postgres;

--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 377
-- Name: rozliczenie_proj_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rozliczenie_proj_del_id_seq OWNED BY public.rozliczenie_proj.del_id;


--
-- TOC entry 378 (class 1259 OID 6059866)
-- Name: rozliczenie_projektantow; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_projektantow AS
 SELECT rysunki2.id_kontrakt,
    rysunki2.osobaodp,
    sum(rysunki2.ilosc_a1) AS suma_a1,
    public.iff((pracownicy.info = 'Wirtualny'::text), '-'::text, (sum(rysunki2.czas_projektowania))::text) AS czas_proj,
    (sum(rysunki2.czas_projektowania) / sum(rysunki2.ilosc_a1)) AS srednio_a1,
    public.iff((pracownicy.info = 'Wirtualny'::text), (sum(((rysunki2.ilosc_a1 * (public.cenarysunku(rysunki2.rodzaj_rys))::double precision) * rysunki2.wsp_korekcji)))::text, (round((sum((rysunki2.czas_projektowania * (kontrakt2.kosztproj)::double precision)))::numeric, 3))::text) AS koszt_real,
    ((public.iff((pracownicy.info = 'Wirtualny'::text), (sum(((rysunki2.ilosc_a1 * rysunki2.wsp_korekcji) * (public.cenarysunku(rysunki2.rodzaj_rys))::double precision)))::text, (sum((rysunki2.czas_projektowania * (kontrakt2.kosztproj)::double precision)))::text))::real / sum(rysunki2.ilosc_a1)) AS srea1
   FROM public.kontrakt2,
    public.rysunki2,
    public.pracownicy
  WHERE ((kontrakt2.id = rysunki2.id_kontrakt) AND (rysunki2.osobaodp = (pracownicy.nazwisko)::text))
  GROUP BY rysunki2.id_kontrakt, rysunki2.osobaodp, pracownicy.info, pracownicy.stawka;


ALTER TABLE public.rozliczenie_projektantow OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 6059871)
-- Name: rozliczenie_projektantow3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_projektantow3 AS
 SELECT rysunki2.id_kontrakt,
    rysunki2.osobaodp,
    sum(rysunki2.ilosc_a1) AS suma_a1,
    sum(rysunki2.czas_projektowania) AS czas_proj,
    (sum(rysunki2.czas_projektowania) / (sum(rysunki2.ilosc_a1))::double precision) AS srednio_a1,
    sum((rysunki2.czas_projektowania * (kontrakt2.kosztrbg)::double precision)) AS koszt_real,
    (sum((rysunki2.czas_projektowania * (kontrakt2.kosztrbg)::double precision)) / (sum(rysunki2.ilosc_a1))::double precision) AS srea1
   FROM public.kontrakt2,
    public.rysunki2
  WHERE (kontrakt2.id = rysunki2.id_kontrakt)
  GROUP BY rysunki2.id_kontrakt, rysunki2.osobaodp;


ALTER TABLE public.rozliczenie_projektantow3 OWNER TO postgres;

--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 379
-- Name: VIEW rozliczenie_projektantow3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.rozliczenie_projektantow3 IS 'Wersja 1.00 Beta
data utworzenia:  6.07.2004
Autor: Mario';


--
-- TOC entry 380 (class 1259 OID 6059876)
-- Name: rozliczenie_projektantow_total; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_projektantow_total AS
 SELECT rozliczenie_projektantow.id_kontrakt,
    rozliczenie_projektantow.osobaodp,
    rozliczenie_projektantow.suma_a1,
    rozliczenie_projektantow.czas_proj,
    rozliczenie_projektantow.srednio_a1,
    rozliczenie_projektantow.koszt_real,
    rozliczenie_projektantow.srea1,
    sum(rozliczenie_proj.rob_wyk) AS sumrob_wyk,
    sum(rozliczenie_proj.koszt_mat) AS sumkoszt_mat
   FROM (public.rozliczenie_proj
     RIGHT JOIN public.rozliczenie_projektantow ON ((((rozliczenie_proj.projektant)::text = rozliczenie_projektantow.osobaodp) AND (rozliczenie_proj.id_kontrakt = rozliczenie_projektantow.id_kontrakt))))
  GROUP BY rozliczenie_projektantow.id_kontrakt, rozliczenie_projektantow.osobaodp, rozliczenie_projektantow.suma_a1, rozliczenie_projektantow.czas_proj, rozliczenie_projektantow.srednio_a1, rozliczenie_projektantow.koszt_real, rozliczenie_projektantow.srea1;


ALTER TABLE public.rozliczenie_projektantow_total OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 6059881)
-- Name: rozliczenie_robocizny; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_robocizny AS
 SELECT robocizna_wykonana.pracownik,
    date_part('year'::text, robocizna_wykonana.data_wpl) AS rok,
    date_part('month'::text, robocizna_wykonana.data_wpl) AS miesiac,
    date_part('week'::text, robocizna_wykonana.data_wpl) AS nrtyg,
    robocizna_wykonana.data_wpl,
    public.wyplaty_opis_pracy(robocizna_wykonana.id_kontrakt, robocizna_wykonana.id_zespol, robocizna_wykonana.id_rysunek, robocizna_wykonana.klucz_obj) AS rob_opis,
    kontrakt2.nrlabel,
    pracownicy.stawka,
    robocizna_wykonana.wykonana,
    pracownicy.grupa_zaw
   FROM public.robocizna_wykonana,
    public.kontrakt2,
    public.pracownicy
  WHERE ((robocizna_wykonana.id_kontrakt = kontrakt2.id) AND ((robocizna_wykonana.pracownik)::text = (pracownicy.nazwisko)::text))
  ORDER BY robocizna_wykonana.data_wpl;


ALTER TABLE public.rozliczenie_robocizny OWNER TO postgres;

--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 381
-- Name: VIEW rozliczenie_robocizny; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.rozliczenie_robocizny IS 'wersja mikołajkowa';


--
-- TOC entry 382 (class 1259 OID 6059886)
-- Name: rozliczenie_robocizny_bc3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.rozliczenie_robocizny_bc3 AS
 SELECT robocizna_wykonana.pracownik,
    date_part('year'::text, robocizna_wykonana.data_wpl) AS rok,
    date_part('month'::text, robocizna_wykonana.data_wpl) AS miesiac,
    date_part('week'::text, robocizna_wykonana.data_wpl) AS nrtyg,
    robocizna_wykonana.data_wpl,
    public.iff((rysunki2.rys_label IS NULL), (((zespoly.zesp_label)::text || '  '::text) || operacje.op_nazwa), (((rysunki2.rys_label)::text || '  '::text) || operacje.op_nazwa)) AS rob_opis,
    kontrakt2.nrlabel,
    pracownicy.stawka,
    robocizna_wykonana.wykonana,
    pracownicy.grupa_zaw
   FROM public.r_plan_temp,
    public.kontrakt2,
    public.pracownicy,
    public.operacje,
    ((public.robocizna_wykonana
     LEFT JOIN public.zespoly ON ((robocizna_wykonana.id_zespol = zespoly.id)))
     LEFT JOIN public.rysunki2 ON ((robocizna_wykonana.id_rysunek = rysunki2.id)))
  WHERE ((r_plan_temp.id = robocizna_wykonana.id_robplan) AND (kontrakt2.id = robocizna_wykonana.id_kontrakt) AND ((robocizna_wykonana.pracownik)::text = (pracownicy.nazwisko)::text) AND ((r_plan_temp.znak_operacji)::text = (operacje.znak)::text))
  ORDER BY robocizna_wykonana.data_wpl;


ALTER TABLE public.rozliczenie_robocizny_bc3 OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 6059891)
-- Name: rw_detale_id_rw_detale_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rw_detale_id_rw_detale_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rw_detale_id_rw_detale_seq OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 6059893)
-- Name: rw_detale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rw_detale (
    id_rw_detale bigint DEFAULT nextval('public.rw_detale_id_rw_detale_seq'::regclass) NOT NULL,
    rw_label character varying(15) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.rw_detale OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 6059897)
-- Name: rw_detale_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rw_detale_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rw_detale_del_id_seq OWNER TO postgres;

--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 385
-- Name: rw_detale_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rw_detale_del_id_seq OWNED BY public.rw_detale.del_id;


--
-- TOC entry 386 (class 1259 OID 6059899)
-- Name: rw_szczegoly_id_rw_szczegoly_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rw_szczegoly_id_rw_szczegoly_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rw_szczegoly_id_rw_szczegoly_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 387 (class 1259 OID 6059901)
-- Name: rw_szczegoly; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rw_szczegoly (
    id_rw_szczegoly bigint DEFAULT nextval('public.rw_szczegoly_id_rw_szczegoly_seq'::regclass) NOT NULL,
    id_rw_detale bigint NOT NULL,
    id_detale bigint NOT NULL,
    data_ciecia date,
    kolejnosc_rw smallint,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.rw_szczegoly OWNER TO postgres;

--
-- TOC entry 388 (class 1259 OID 6059905)
-- Name: rw_szczegoly_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rw_szczegoly_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rw_szczegoly_del_id_seq OWNER TO postgres;

--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 388
-- Name: rw_szczegoly_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rw_szczegoly_del_id_seq OWNED BY public.rw_szczegoly.del_id;


--
-- TOC entry 389 (class 1259 OID 6059907)
-- Name: rysunki2_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rysunki2_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rysunki2_del_id_seq OWNER TO postgres;

--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 389
-- Name: rysunki2_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rysunki2_del_id_seq OWNED BY public.rysunki2.del_id;


--
-- TOC entry 390 (class 1259 OID 6059909)
-- Name: rysunki2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rysunki2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.rysunki2_id_seq OWNER TO postgres;

--
-- TOC entry 391 (class 1259 OID 6059911)
-- Name: rysunki_id_rysunek_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rysunki_id_rysunek_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rysunki_id_rysunek_seq OWNER TO postgres;

--
-- TOC entry 392 (class 1259 OID 6059913)
-- Name: stan_materialu_id_stan_materialu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stan_materialu_id_stan_materialu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stan_materialu_id_stan_materialu_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 393 (class 1259 OID 6059915)
-- Name: stan_materialu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stan_materialu (
    stan_m character varying(40) DEFAULT ''::character varying NOT NULL,
    ikona character varying(100),
    "klucz_D_C" integer,
    id_stan_materialu bigint DEFAULT nextval('public.stan_materialu_id_stan_materialu_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.stan_materialu OWNER TO postgres;

--
-- TOC entry 394 (class 1259 OID 6059920)
-- Name: stan_materialu_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stan_materialu_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stan_materialu_del_id_seq OWNER TO postgres;

--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 394
-- Name: stan_materialu_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stan_materialu_del_id_seq OWNED BY public.stan_materialu.del_id;


--
-- TOC entry 395 (class 1259 OID 6059922)
-- Name: struktura_kontraktu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.struktura_kontraktu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.struktura_kontraktu_id_seq OWNER TO postgres;

--
-- TOC entry 396 (class 1259 OID 6059924)
-- Name: struktura_kontraktu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.struktura_kontraktu (
    id integer DEFAULT nextval('public.struktura_kontraktu_id_seq'::regclass) NOT NULL,
    nazwa character varying(100),
    rodzaj_objektu character varying(10),
    id_obiektu integer,
    zaleznosc_obiektu integer,
    id_kontrakt integer,
    kolejnosc integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.struktura_kontraktu OWNER TO postgres;

--
-- TOC entry 397 (class 1259 OID 6059928)
-- Name: struktura_kontraktu_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.struktura_kontraktu_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.struktura_kontraktu_del_id_seq OWNER TO postgres;

--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 397
-- Name: struktura_kontraktu_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.struktura_kontraktu_del_id_seq OWNED BY public.struktura_kontraktu.del_id;


--
-- TOC entry 398 (class 1259 OID 6059930)
-- Name: sub_branza_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sub_branza_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sub_branza_id_seq OWNER TO postgres;

--
-- TOC entry 399 (class 1259 OID 6059932)
-- Name: sub_branza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub_branza (
    id integer DEFAULT nextval('public.sub_branza_id_seq'::regclass) NOT NULL,
    nazwa character varying(100) NOT NULL,
    id_branza integer NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.sub_branza OWNER TO postgres;

--
-- TOC entry 400 (class 1259 OID 6059936)
-- Name: sub_branza_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sub_branza_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sub_branza_del_id_seq OWNER TO postgres;

--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 400
-- Name: sub_branza_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sub_branza_del_id_seq OWNED BY public.sub_branza.del_id;


--
-- TOC entry 401 (class 1259 OID 6059938)
-- Name: suma_delegacje; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_delegacje AS
 SELECT delegacje.id_kontrakt,
    sum(delegacje.kwota) AS wykonana_wart
   FROM public.delegacje
  GROUP BY delegacje.id_kontrakt;


ALTER TABLE public.suma_delegacje OWNER TO postgres;

--
-- TOC entry 402 (class 1259 OID 6059942)
-- Name: suma_doradztwo_nowy; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_doradztwo_nowy AS
 SELECT doradztwo_nowy.id_kontrakt,
    sum(doradztwo_nowy.rozliczane) AS rozliczane_wart,
    sum(doradztwo_nowy.wykonane) AS wykonane_wart
   FROM public.doradztwo_nowy
  GROUP BY doradztwo_nowy.id_kontrakt;


ALTER TABLE public.suma_doradztwo_nowy OWNER TO postgres;

--
-- TOC entry 403 (class 1259 OID 6059946)
-- Name: suma_dostawy_plan; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_dostawy_plan AS
 SELECT normalia.id_kontrakt,
    normalia.id_zespol,
    sum(normalia.kosztcalkowity) AS przew_ciez,
    sum(normalia.kosztcalkowity) AS przew_wart,
    sum(normalia.cena_rozl) AS rozl_wart
   FROM public.normalia
  GROUP BY normalia.id_kontrakt, normalia.id_zespol;


ALTER TABLE public.suma_dostawy_plan OWNER TO postgres;

--
-- TOC entry 404 (class 1259 OID 6059950)
-- Name: zakupy_farb_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zakupy_farb_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zakupy_farb_id_seq OWNER TO postgres;

--
-- TOC entry 405 (class 1259 OID 6059952)
-- Name: zakupy_farb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zakupy_farb (
    id_kontrakt integer NOT NULL,
    numer character varying(20),
    tresc character varying(100),
    firma character varying(50),
    ilosc double precision,
    kwota numeric(10,2),
    id integer DEFAULT nextval('public.zakupy_farb_id_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.zakupy_farb OWNER TO postgres;

--
-- TOC entry 406 (class 1259 OID 6059956)
-- Name: suma_farby_rozl; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_farby_rozl AS
 SELECT zakupy_farb.id_kontrakt,
    sum(zakupy_farb.ilosc) AS ilosc_kg,
    sum(zakupy_farb.kwota) AS rozl_wart
   FROM public.zakupy_farb
  GROUP BY zakupy_farb.id_kontrakt;


ALTER TABLE public.suma_farby_rozl OWNER TO postgres;

--
-- TOC entry 407 (class 1259 OID 6059960)
-- Name: suma_kooperacji_plan; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_kooperacji_plan AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    sum(r_plan_temp.planowana) AS przew_rob,
    sum(r_plan_temp.cena_kooperacji) AS przew_wart
   FROM public.r_plan_temp
  WHERE ((r_plan_temp.wykonanie = false) AND ((r_plan_temp.znak_operacji)::text <> 'MN'::text))
  GROUP BY r_plan_temp.id_kontrakt, r_plan_temp.id_zespol;


ALTER TABLE public.suma_kooperacji_plan OWNER TO postgres;

--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 407
-- Name: VIEW suma_kooperacji_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.suma_kooperacji_plan IS 'Wersja 1.00 Beta
data utworzenia:  9.08.2004
Autor: Mario';


--
-- TOC entry 408 (class 1259 OID 6059964)
-- Name: suma_kooperacji_plan1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_kooperacji_plan1 AS
 SELECT kooperacja2.id_kontrakt,
    kooperacja2.id_zespol,
    sum(kooperacja2.cena_ofertowa) AS planowana_koop
   FROM public.kooperacja2
  GROUP BY kooperacja2.id_kontrakt, kooperacja2.id_zespol;


ALTER TABLE public.suma_kooperacji_plan1 OWNER TO postgres;

--
-- TOC entry 409 (class 1259 OID 6059968)
-- Name: suma_kooperacji_wyk1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_kooperacji_wyk1 AS
 SELECT kooperacja2.id_kontrakt,
    kooperacja2.id_zespol,
    sum(kooperacja2.cena_rozliczeniowa) AS koop_wyk
   FROM public.kooperacja2
  WHERE (kooperacja2.rozliczona = true)
  GROUP BY kooperacja2.id_kontrakt, kooperacja2.id_zespol
  ORDER BY kooperacja2.id_kontrakt;


ALTER TABLE public.suma_kooperacji_wyk1 OWNER TO postgres;

--
-- TOC entry 410 (class 1259 OID 6059972)
-- Name: suma_malowanie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_malowanie AS
 SELECT robocizna_wykonana.id_kontrakt,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum(((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana)) AS wykonana_wart
   FROM public.robocizna_wykonana,
    public.kontrakt2
  WHERE (robocizna_wykonana.id_kontrakt = kontrakt2.id)
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.klucz_obj
 HAVING ((robocizna_wykonana.klucz_obj)::text = 'KKO5'::text);


ALTER TABLE public.suma_malowanie OWNER TO postgres;

--
-- TOC entry 411 (class 1259 OID 6059977)
-- Name: suma_montaz_plan; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_montaz_plan AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    sum(r_plan_temp.planowana) AS przew_rob,
    sum((r_plan_temp.planowana * (kontrakt2.kosztrbg)::double precision)) AS przew_wart
   FROM public.kontrakt2,
    public.r_plan_temp
  WHERE ((kontrakt2.id = r_plan_temp.id_kontrakt) AND ((r_plan_temp.znak_operacji)::text = 'MN'::text))
  GROUP BY r_plan_temp.id_kontrakt, r_plan_temp.id_zespol;


ALTER TABLE public.suma_montaz_plan OWNER TO postgres;

--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 411
-- Name: VIEW suma_montaz_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.suma_montaz_plan IS 'Wersja 1.00 Beta
data utworzenia:  6.07.2004
Autor: Mario';


--
-- TOC entry 412 (class 1259 OID 6059982)
-- Name: suma_montaz_wyk; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_montaz_wyk AS
 SELECT robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_zespol,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum(((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana)) AS wykonana_wart
   FROM public.robocizna_wykonana,
    public.r_plan_temp,
    public.kontrakt2
  WHERE ((robocizna_wykonana.id_robplan = r_plan_temp.id) AND (robocizna_wykonana.id_kontrakt = kontrakt2.id))
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.id_zespol, r_plan_temp.znak_operacji
 HAVING ((r_plan_temp.znak_operacji)::text = 'MN'::text);


ALTER TABLE public.suma_montaz_wyk OWNER TO postgres;

--
-- TOC entry 413 (class 1259 OID 6059987)
-- Name: suma_montaz_wyk_bckp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_montaz_wyk_bckp AS
 SELECT robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_zespol,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    ((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana) AS wykonana_wart
   FROM public.robocizna_wykonana,
    public.r_plan_temp,
    public.kontrakt2
  WHERE ((robocizna_wykonana.id_robplan = r_plan_temp.id) AND (robocizna_wykonana.id_kontrakt = kontrakt2.id))
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.id_zespol, r_plan_temp.znak_operacji, ((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana)
 HAVING ((r_plan_temp.znak_operacji)::text = 'MN'::text);


ALTER TABLE public.suma_montaz_wyk_bckp OWNER TO postgres;

--
-- TOC entry 414 (class 1259 OID 6059992)
-- Name: suma_piaskowanie_wyk; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_piaskowanie_wyk AS
 SELECT piaskowanie.id_kontrakt,
    sum(piaskowanie.kwota) AS wykonana_wart
   FROM public.piaskowanie
  GROUP BY piaskowanie.id_kontrakt;


ALTER TABLE public.suma_piaskowanie_wyk OWNER TO postgres;

--
-- TOC entry 415 (class 1259 OID 6059996)
-- Name: suma_pomocnicze; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_pomocnicze AS
 SELECT robocizna_wykonana.id_kontrakt,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum(((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana)) AS wykonana_wart
   FROM public.robocizna_wykonana,
    public.kontrakt2
  WHERE (robocizna_wykonana.id_kontrakt = kontrakt2.id)
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.klucz_obj
 HAVING ((robocizna_wykonana.klucz_obj)::text = 'KKO2'::text);


ALTER TABLE public.suma_pomocnicze OWNER TO postgres;

--
-- TOC entry 416 (class 1259 OID 6060001)
-- Name: suma_projektant_wyk; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_projektant_wyk AS
 SELECT rozliczenie_projektantow.id_kontrakt,
    sum((rozliczenie_projektantow.koszt_real)::real) AS wykonana_wart
   FROM public.rozliczenie_projektantow
  GROUP BY rozliczenie_projektantow.id_kontrakt;


ALTER TABLE public.suma_projektant_wyk OWNER TO postgres;

--
-- TOC entry 417 (class 1259 OID 6060005)
-- Name: suma_przew_material; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_przew_material AS
 SELECT detale.id_kontrakt,
    detale.id_zespol,
    sum(detale.ciez_calkowity) AS przew_ciez,
    sum((((detale.ilsztuk)::double precision * detale.ciez_sztuki) * detale.cena)) AS przew_wart,
    sum(detale.cena_rozl) AS cena_rozl
   FROM public.detale
  GROUP BY detale.id_kontrakt, detale.id_zespol;


ALTER TABLE public.suma_przew_material OWNER TO postgres;

--
-- TOC entry 418 (class 1259 OID 6060009)
-- Name: suma_przyg_mat; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_przyg_mat AS
 SELECT robocizna_wykonana.id_kontrakt,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum(((kontrakt2.kosztrbg)::double precision * robocizna_wykonana.wykonana)) AS wykonana_wart
   FROM public.robocizna_wykonana,
    public.kontrakt2
  WHERE (robocizna_wykonana.id_kontrakt = kontrakt2.id)
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.klucz_obj
 HAVING ((robocizna_wykonana.klucz_obj)::text = 'KKO1'::text);


ALTER TABLE public.suma_przyg_mat OWNER TO postgres;

--
-- TOC entry 419 (class 1259 OID 6060014)
-- Name: suma_robocizny_plan; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_robocizny_plan AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    sum(r_plan_temp.planowana) AS przew_rob,
    sum((r_plan_temp.planowana * (kontrakt2.kosztrbg)::double precision)) AS przew_wart
   FROM public.kontrakt2,
    public.r_plan_temp
  WHERE ((kontrakt2.id = r_plan_temp.id_kontrakt) AND (r_plan_temp.wykonanie = true) AND ((r_plan_temp.znak_operacji)::text <> 'MN'::text))
  GROUP BY r_plan_temp.id_kontrakt, r_plan_temp.id_zespol;


ALTER TABLE public.suma_robocizny_plan OWNER TO postgres;

--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 419
-- Name: VIEW suma_robocizny_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.suma_robocizny_plan IS 'Wersja 1.01 Beta
data utworzenia:  10.09.2004
Autor: Mario';


--
-- TOC entry 420 (class 1259 OID 6060019)
-- Name: suma_robocizny_wyk; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_robocizny_wyk AS
 SELECT robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_zespol,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum((robocizna_wykonana.wykonana * (kontrakt2.kosztrbg)::double precision)) AS wykonana_wart
   FROM public.kontrakt2,
    public.robocizna_wykonana,
    public.r_plan_temp
  WHERE ((kontrakt2.id = robocizna_wykonana.id_kontrakt) AND (r_plan_temp.id = robocizna_wykonana.id_robplan) AND ((r_plan_temp.znak_operacji)::text <> 'MN'::text))
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.id_zespol;


ALTER TABLE public.suma_robocizny_wyk OWNER TO postgres;

--
-- TOC entry 421 (class 1259 OID 6060024)
-- Name: suma_robocizny_wyk_bckp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_robocizny_wyk_bckp AS
 SELECT robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_zespol,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum((robocizna_wykonana.wykonana * (kontrakt2.kosztrbg)::double precision)) AS wykonana_wart
   FROM public.kontrakt2,
    public.robocizna_wykonana
  WHERE (kontrakt2.id = robocizna_wykonana.id_kontrakt)
  GROUP BY robocizna_wykonana.id_kontrakt, robocizna_wykonana.id_zespol;


ALTER TABLE public.suma_robocizny_wyk_bckp OWNER TO postgres;

--
-- TOC entry 422 (class 1259 OID 6060028)
-- Name: suma_rozliczenie_proj; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_rozliczenie_proj AS
 SELECT rozliczenie_proj.id_kontrakt,
    sum(rozliczenie_proj.rob_wyk) AS suma_robocizny,
    sum(rozliczenie_proj.koszt_mat) AS suma_koszt_mat
   FROM public.rozliczenie_proj
  GROUP BY rozliczenie_proj.id_kontrakt;


ALTER TABLE public.suma_rozliczenie_proj OWNER TO postgres;

--
-- TOC entry 423 (class 1259 OID 6060032)
-- Name: transport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transport_id_seq OWNER TO postgres;

--
-- TOC entry 424 (class 1259 OID 6060034)
-- Name: transport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transport (
    id_kontrakt integer NOT NULL,
    numer character varying(100),
    firma character varying(50),
    kwota numeric(10,2),
    id integer DEFAULT nextval('public.transport_id_seq'::regclass) NOT NULL,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    opis text
);


ALTER TABLE public.transport OWNER TO postgres;

--
-- TOC entry 425 (class 1259 OID 6060041)
-- Name: suma_transport; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_transport AS
 SELECT transport.id_kontrakt,
    sum(transport.kwota) AS wykonana_wart
   FROM public.transport
  GROUP BY transport.id_kontrakt;


ALTER TABLE public.suma_transport OWNER TO postgres;

--
-- TOC entry 426 (class 1259 OID 6060045)
-- Name: suma_uruchomlinii; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.suma_uruchomlinii AS
 SELECT robocizna_wykonana.id_kontrakt,
    sum(0.0) AS rozliczane_wart,
    sum(robocizna_wykonana.wykonana) AS wykonana_rob,
    sum(robocizna_wykonana.wykonana) AS wykonane_wart
   FROM public.robocizna_wykonana
  WHERE ((robocizna_wykonana.klucz_obj)::text = 'KKO10'::text)
  GROUP BY robocizna_wykonana.id_kontrakt;


ALTER TABLE public.suma_uruchomlinii OWNER TO postgres;

--
-- TOC entry 427 (class 1259 OID 6060049)
-- Name: sumy_proj_temp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sumy_proj_temp AS
 SELECT rysunki2.osobaodp,
    sum((((public.cenarysunku(rysunki2.rodzaj_rys))::double precision * rysunki2.wsp_korekcji) * rysunki2.ilosc_a1)) AS ce_rys,
    rysunki2.id_kontrakt,
    rysunki2.id_zespol,
    public.zespol_lbl(rysunki2.id_zespol) AS zesp_label,
    public.kontrakt_temat(rysunki2.id_kontrakt) AS kontrakt_label
   FROM public.rysunki2
  GROUP BY (public.zespol_lbl(rysunki2.id_zespol)), rysunki2.osobaodp, rysunki2.id_kontrakt, rysunki2.id_zespol, (public.kontrakt_temat(rysunki2.id_kontrakt))
  ORDER BY (public.zespol_lbl(rysunki2.id_zespol)), rysunki2.osobaodp;


ALTER TABLE public.sumy_proj_temp OWNER TO postgres;

--
-- TOC entry 428 (class 1259 OID 6060054)
-- Name: szef_generator3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.szef_generator3 AS
 SELECT r_plan_temp.id_kontrakt,
    r_plan_temp.id_zespol,
    r_plan_temp.id_rysunek,
    sum(r_plan_temp.planowana) AS sumaofplanowana1,
    sum((r_plan_temp.planowana - (r_plan_temp.planowana * (r_plan_temp.zrobione)::double precision))) AS do_zrobienia,
    public.iff(((count(r_plan_temp.zrobione) - sum(r_plan_temp.zrobione)) = 0), 'ROZLICZONY'::text, 'BRAK'::text) AS zliczony2
   FROM public.r_plan_temp
  GROUP BY r_plan_temp.id_rysunek, r_plan_temp.id_zespol, r_plan_temp.id_kontrakt;


ALTER TABLE public.szef_generator3 OWNER TO postgres;

--
-- TOC entry 429 (class 1259 OID 6060059)
-- Name: szef_generator_1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.szef_generator_1 AS
 SELECT kontrakt2.temat,
    kontrakt2.osobaodp,
    zespoly.zesp_label,
    rysunki2.rys_label,
    rysunki2.nazwa_rysunku,
    rysunki2.min_maks_nr,
    rysunki2.il_sztuk,
    rysunki2.rodzaj_rys,
    rysunki2.id,
    rysunki2.id_zespol,
    rysunki2.id_kontrakt,
    rysunki2.wieloczesc,
    rysunki2.rodz_kooperacji,
    rysunki2.data_wpl
   FROM public.kontrakt2,
    (public.zespoly
     RIGHT JOIN public.rysunki2 ON (((zespoly.id_kontrakt = rysunki2.id_kontrakt) AND (zespoly.id = rysunki2.id_zespol))))
  WHERE (kontrakt2.id = zespoly.id_kontrakt)
  GROUP BY rysunki2.rys_label, kontrakt2.temat, kontrakt2.osobaodp, zespoly.zesp_label, rysunki2.nazwa_rysunku, rysunki2.min_maks_nr, rysunki2.il_sztuk, rysunki2.rodzaj_rys, rysunki2.id, rysunki2.id_zespol, rysunki2.id_kontrakt, rysunki2.wieloczesc, rysunki2.rodz_kooperacji, rysunki2.data_wpl
  ORDER BY rysunki2.rys_label;


ALTER TABLE public.szef_generator_1 OWNER TO postgres;

--
-- TOC entry 430 (class 1259 OID 6060064)
-- Name: szef_generator_2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.szef_generator_2 AS
 SELECT detale.id_kontrakt,
    detale.id_zespol,
    detale.id_rysunki,
    public.iff((sum(detale.rodz_kooperacji) > 0), 'X'::text, '-'::text) AS stan_materdet,
    public.iff(((count(detale.pociety) + sum(detale.pociety)) = 0), 'X'::text, '-'::text) AS pocietydetal
   FROM public.detale
  GROUP BY detale.id_rysunki, detale.id_kontrakt, detale.id_zespol;


ALTER TABLE public.szef_generator_2 OWNER TO postgres;

--
-- TOC entry 431 (class 1259 OID 6060069)
-- Name: szef_raport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.szef_raport (
    id_kontrakt integer,
    id_zespol integer,
    id integer,
    temat text,
    osobaodp text,
    zesp_label character varying,
    rys_label character varying,
    nazwa_rysunku text,
    min_maks_nr text,
    il_sztuk integer,
    sumaofplanowana1 double precision,
    do_zrobienia double precision,
    zliczony2 text,
    stan_materdet text,
    pocietydetal text,
    klucz integer DEFAULT nextval(('"szefrpt_id_seq"'::text)::regclass) NOT NULL,
    zrobione_j integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL,
    rodzaj_rys character varying(19),
    blat bigint,
    wydany date
);


ALTER TABLE public.szef_raport OWNER TO postgres;

--
-- TOC entry 432 (class 1259 OID 6060076)
-- Name: szef_raport_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.szef_raport_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.szef_raport_del_id_seq OWNER TO postgres;

--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 432
-- Name: szef_raport_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.szef_raport_del_id_seq OWNED BY public.szef_raport.del_id;


--
-- TOC entry 433 (class 1259 OID 6060078)
-- Name: szef_raport_gen; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.szef_raport_gen AS
 SELECT szef_generator_1.id_kontrakt,
    szef_generator_1.id_zespol,
    szef_generator_1.id,
    szef_generator_1.temat,
    szef_generator_1.osobaodp,
    szef_generator_1.zesp_label,
    szef_generator_1.rys_label,
    szef_generator_1.nazwa_rysunku,
    szef_generator_1.min_maks_nr,
    szef_generator_1.il_sztuk,
    szef_generator3.sumaofplanowana1,
    szef_generator3.do_zrobienia,
    szef_generator3.zliczony2,
    public.iff((szef_generator_1.rodz_kooperacji > 0), 'X'::text, szef_generator_2.stan_materdet) AS stan_materdet,
    szef_generator_2.pocietydetal,
    szef_generator_1.rodzaj_rys,
    szef_generator_1.wieloczesc,
    szef_generator_1.data_wpl
   FROM ((public.szef_generator_1
     LEFT JOIN public.szef_generator3 ON ((szef_generator_1.id = szef_generator3.id_rysunek)))
     LEFT JOIN public.szef_generator_2 ON ((szef_generator_1.id = szef_generator_2.id_rysunki)))
  ORDER BY szef_generator_1.rys_label;


ALTER TABLE public.szef_raport_gen OWNER TO postgres;

--
-- TOC entry 434 (class 1259 OID 6060083)
-- Name: szefrpt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.szefrpt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.szefrpt_id_seq OWNER TO postgres;

--
-- TOC entry 435 (class 1259 OID 6060085)
-- Name: temp_wika; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.temp_wika AS
 SELECT robocizna_wykonana.id_robplan,
    robocizna_wykonana.id_rysunek,
    sum(robocizna_wykonana.wykonana) AS expr1
   FROM public.robocizna_wykonana
  GROUP BY robocizna_wykonana.id_robplan, robocizna_wykonana.id_rysunek
 HAVING (robocizna_wykonana.id_rysunek IS NOT NULL);


ALTER TABLE public.temp_wika OWNER TO postgres;

--
-- TOC entry 436 (class 1259 OID 6060089)
-- Name: transport_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transport_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transport_del_id_seq OWNER TO postgres;

--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 436
-- Name: transport_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transport_del_id_seq OWNED BY public.transport.del_id;


SET default_with_oids = false;

--
-- TOC entry 437 (class 1259 OID 6060091)
-- Name: tree_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tree_categories (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.tree_categories OWNER TO postgres;

--
-- TOC entry 438 (class 1259 OID 6060097)
-- Name: tree_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tree_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tree_categories_id_seq OWNER TO postgres;

--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 438
-- Name: tree_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tree_categories_id_seq OWNED BY public.tree_categories.id;


--
-- TOC entry 439 (class 1259 OID 6060099)
-- Name: tree_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tree_relations (
    parent_id integer NOT NULL,
    child_id integer NOT NULL,
    depth integer
);


ALTER TABLE public.tree_relations OWNER TO postgres;

--
-- TOC entry 440 (class 1259 OID 6060102)
-- Name: typy_dokumentow_id_dokument_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.typy_dokumentow_id_dokument_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.typy_dokumentow_id_dokument_seq OWNER TO postgres;

--
-- TOC entry 441 (class 1259 OID 6060104)
-- Name: typy_dokumentow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.typy_dokumentow (
    id_dokument integer DEFAULT nextval('public.typy_dokumentow_id_dokument_seq'::regclass) NOT NULL,
    dokument character varying(30),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.typy_dokumentow OWNER TO postgres;

--
-- TOC entry 442 (class 1259 OID 6060108)
-- Name: typy_dokumentow_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.typy_dokumentow_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.typy_dokumentow_del_id_seq OWNER TO postgres;

--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 442
-- Name: typy_dokumentow_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.typy_dokumentow_del_id_seq OWNED BY public.typy_dokumentow.del_id;


--
-- TOC entry 443 (class 1259 OID 6060110)
-- Name: uruchomlinii_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uruchomlinii_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uruchomlinii_id_seq OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 444 (class 1259 OID 6060112)
-- Name: uruchomlinii; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uruchomlinii (
    id integer DEFAULT nextval('public.uruchomlinii_id_seq'::regclass) NOT NULL,
    id_kontrakt integer NOT NULL,
    numer character varying(100),
    osoba character varying(50),
    opis text,
    kwota_plan numeric(10,2),
    kwota_rozl numeric(10,2),
    kiedy date DEFAULT ('now'::text)::date,
    kto character varying(20) DEFAULT "current_user"(),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.uruchomlinii OWNER TO postgres;

--
-- TOC entry 445 (class 1259 OID 6060121)
-- Name: uruchomlinii_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uruchomlinii_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uruchomlinii_del_id_seq OWNER TO postgres;

--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 445
-- Name: uruchomlinii_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uruchomlinii_del_id_seq OWNED BY public.uruchomlinii.del_id;


--
-- TOC entry 446 (class 1259 OID 6060123)
-- Name: v_rob_wyk; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_rob_wyk AS
 SELECT robocizna_wykonana.id,
    robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_zespol,
    robocizna_wykonana.id_rysunek,
    robocizna_wykonana.id_detal,
    robocizna_wykonana.id_robplan,
    robocizna_wykonana.pracownik,
    robocizna_wykonana.wykonana,
    robocizna_wykonana.data_wpl,
    robocizna_wykonana.uwagi,
    robocizna_wykonana.zatwierdzil,
    robocizna_wykonana.znak_operacji,
    robocizna_wykonana.przyczyna,
    robocizna_wykonana.status,
    robocizna_wykonana.klucz_obj,
    robocizna_wykonana.ins_data,
    robocizna_wykonana.ins_user,
    robocizna_wykonana.upd_data,
    robocizna_wykonana.upd_user,
    robocizna_wykonana.del_id,
    zespoly.zesp_label,
    kontrakt2.nrlabel
   FROM public.robocizna_wykonana,
    public.zespoly,
    public.kontrakt2
  WHERE ((robocizna_wykonana.id_kontrakt = kontrakt2.id) AND (robocizna_wykonana.id_zespol = zespoly.id));


ALTER TABLE public.v_rob_wyk OWNER TO postgres;

--
-- TOC entry 447 (class 1259 OID 6060128)
-- Name: v_rob_wyk_kontr; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_rob_wyk_kontr AS
 SELECT robocizna_wykonana.id,
    robocizna_wykonana.id_kontrakt,
    robocizna_wykonana.id_rysunek,
    robocizna_wykonana.id_detal,
    robocizna_wykonana.id_robplan,
    robocizna_wykonana.pracownik,
    robocizna_wykonana.wykonana,
    robocizna_wykonana.data_wpl,
    robocizna_wykonana.uwagi,
    robocizna_wykonana.zatwierdzil,
    robocizna_wykonana.znak_operacji,
    robocizna_wykonana.przyczyna,
    robocizna_wykonana.status,
    robocizna_wykonana.klucz_obj,
    robocizna_wykonana.ins_data,
    robocizna_wykonana.ins_user,
    robocizna_wykonana.upd_data,
    robocizna_wykonana.upd_user,
    robocizna_wykonana.del_id,
    kontrakt2.nrlabel
   FROM public.robocizna_wykonana,
    public.kontrakt2
  WHERE (robocizna_wykonana.id_kontrakt = kontrakt2.id);


ALTER TABLE public.v_rob_wyk_kontr OWNER TO postgres;

--
-- TOC entry 448 (class 1259 OID 6060133)
-- Name: wersja_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wersja_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wersja_id_seq OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 449 (class 1259 OID 6060135)
-- Name: wersja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wersja (
    id integer DEFAULT nextval('public.wersja_id_seq'::regclass) NOT NULL,
    major integer,
    minor integer,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.wersja OWNER TO postgres;

--
-- TOC entry 450 (class 1259 OID 6060139)
-- Name: wersja_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wersja_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wersja_del_id_seq OWNER TO postgres;

--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 450
-- Name: wersja_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wersja_del_id_seq OWNED BY public.wersja.del_id;


--
-- TOC entry 451 (class 1259 OID 6060141)
-- Name: wykonczenie_id_wykonczenie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wykonczenie_id_wykonczenie_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wykonczenie_id_wykonczenie_seq OWNER TO postgres;

--
-- TOC entry 452 (class 1259 OID 6060143)
-- Name: wykonczenie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wykonczenie (
    id_wykonczenie bigint DEFAULT nextval('public.wykonczenie_id_wykonczenie_seq'::regclass) NOT NULL,
    nazwa character varying(30),
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.wykonczenie OWNER TO postgres;

--
-- TOC entry 453 (class 1259 OID 6060147)
-- Name: wykonczenie_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wykonczenie_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wykonczenie_del_id_seq OWNER TO postgres;

--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 453
-- Name: wykonczenie_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wykonczenie_del_id_seq OWNED BY public.wykonczenie.del_id;


--
-- TOC entry 454 (class 1259 OID 6060149)
-- Name: zakupy_czesci; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.zakupy_czesci AS
 SELECT normalia.numer,
    normalia.nazwa,
    normalia.dostawca,
    normalia.ilosc_sztuk,
    zespoly.numer AS nr_zespol,
    zespoly.nazwa_zespolu,
    kontrakt2.temat,
    kontrakt2.nrlabel,
    kontrahent2.nazwa AS inwestor,
    normalia.id_zespol,
    normalia.id_kontrakt,
    normalia.cena,
    normalia.kosztcalkowity,
    normalia.cena_rozl,
    normalia.rozliczony,
    normalia.stan_czesci,
    normalia.symbol
   FROM public.zespoly,
    public.kontrakt2,
    public.normalia,
    public.kontrahent2
  WHERE ((zespoly.id_kontrakt = kontrakt2.id) AND (zespoly.id = normalia.id_zespol) AND (kontrakt2.id = normalia.id_kontrakt) AND ((kontrakt2.znak)::text = (kontrahent2.znak)::text))
  ORDER BY normalia.numer;


ALTER TABLE public.zakupy_czesci OWNER TO postgres;

--
-- TOC entry 455 (class 1259 OID 6060154)
-- Name: zakupy_detali; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.zakupy_detali AS
 SELECT zespoly.id_kontrakt,
    zespoly.id,
    detale.id_rysunki,
    detale.numer,
    detale.material,
    detale.wsad,
    detale.ilsztuk,
    detale.wymiar_a,
    detale.wymiar_b,
    detale.wymiar_c,
    detale.cena,
    detale.ciez_jedn,
    (detale.cena * detale.ciez_calkowity) AS cenatotal,
    detale.ciez_sztuki,
    detale.ciez_calkowity,
    detale.rozliczony,
    detale.cena_rozl,
    detale.stan_materialu,
    detale.pociety,
    kontrakt2.temat,
    zespoly.numer AS num_zesp,
    kontrakt2.nrlabel,
    rysunki2.osobaodp,
    rysunki2.rys_label,
    zespoly.nazwa_zespolu,
    detale.id_zespol
   FROM public.zespoly,
    public.kontrakt2,
    public.rysunki2,
    public.detale
  WHERE ((zespoly.id_kontrakt = kontrakt2.id) AND (zespoly.id = rysunki2.id_zespol) AND (rysunki2.id = detale.id_rysunki))
  ORDER BY detale.numer;


ALTER TABLE public.zakupy_detali OWNER TO postgres;

--
-- TOC entry 456 (class 1259 OID 6060159)
-- Name: zakupy_farb_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zakupy_farb_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zakupy_farb_del_id_seq OWNER TO postgres;

--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 456
-- Name: zakupy_farb_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zakupy_farb_del_id_seq OWNED BY public.zakupy_farb.del_id;


--
-- TOC entry 457 (class 1259 OID 6060161)
-- Name: zarzadzanie_folderami; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zarzadzanie_folderami (
    foldery_id bigint NOT NULL,
    id_rodzica bigint,
    nazwa_folderu character varying(200),
    opis_folderu text,
    dotyczy character varying(100),
    grupa character varying(100),
    sciezka text
);


ALTER TABLE public.zarzadzanie_folderami OWNER TO postgres;

--
-- TOC entry 458 (class 1259 OID 6060167)
-- Name: zarzadzanie_folderami_foldery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zarzadzanie_folderami_foldery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zarzadzanie_folderami_foldery_id_seq OWNER TO postgres;

--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 458
-- Name: zarzadzanie_folderami_foldery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zarzadzanie_folderami_foldery_id_seq OWNED BY public.zarzadzanie_folderami.foldery_id;


--
-- TOC entry 459 (class 1259 OID 6060169)
-- Name: zespol_stan_id_projekt_stan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zespol_stan_id_projekt_stan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zespol_stan_id_projekt_stan_seq OWNER TO postgres;

--
-- TOC entry 460 (class 1259 OID 6060171)
-- Name: zespol_stan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zespol_stan (
    id_projekt_stan bigint DEFAULT nextval('public.zespol_stan_id_projekt_stan_seq'::regclass) NOT NULL,
    id_kontrakt bigint,
    id_zespol bigint,
    naleznosci numeric(10,2),
    data1raty date,
    rata1 numeric(10,2),
    data2raty date,
    rata2 numeric(10,2),
    databledu date,
    bledy numeric(10,2),
    projektant character varying(50),
    procent_wyplaty numeric(3,2) DEFAULT 70,
    ins_data date,
    ins_user character varying(100),
    upd_data date,
    upd_user character varying(100),
    del_id bigint NOT NULL
);


ALTER TABLE public.zespol_stan OWNER TO postgres;

--
-- TOC entry 461 (class 1259 OID 6060176)
-- Name: zespol_stan_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zespol_stan_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zespol_stan_del_id_seq OWNER TO postgres;

--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 461
-- Name: zespol_stan_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zespol_stan_del_id_seq OWNED BY public.zespol_stan.del_id;


--
-- TOC entry 462 (class 1259 OID 6060178)
-- Name: zespoly_del_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zespoly_del_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zespoly_del_id_seq OWNER TO postgres;

--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 462
-- Name: zespoly_del_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zespoly_del_id_seq OWNED BY public.zespoly.del_id;


--
-- TOC entry 463 (class 1259 OID 6060180)
-- Name: zespoly_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zespoly_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.zespoly_id_seq OWNER TO postgres;

--
-- TOC entry 3574 (class 2604 OID 6060182)
-- Name: biblioteka_czesci del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteka_czesci ALTER COLUMN del_id SET DEFAULT nextval('public.biblioteka_czesci_del_id_seq'::regclass);


--
-- TOC entry 3577 (class 2604 OID 6060183)
-- Name: biblioteka_normaliow del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biblioteka_normaliow ALTER COLUMN del_id SET DEFAULT nextval('public.biblioteka_normaliow_del_id_seq'::regclass);


--
-- TOC entry 3579 (class 2604 OID 6060184)
-- Name: branza del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branza ALTER COLUMN del_id SET DEFAULT nextval('public.branza_del_id_seq'::regclass);


--
-- TOC entry 3581 (class 2604 OID 6060185)
-- Name: ceny_rys del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny_rys ALTER COLUMN del_id SET DEFAULT nextval('public.ceny_rys_del_id_seq'::regclass);


--
-- TOC entry 3606 (class 2604 OID 6060186)
-- Name: czesci_zamienne cz_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.czesci_zamienne ALTER COLUMN cz_id SET DEFAULT nextval('public.czesci_zamienne_cz_id_seq'::regclass);


--
-- TOC entry 3607 (class 2604 OID 6060187)
-- Name: del_log id_del_log; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.del_log ALTER COLUMN id_del_log SET DEFAULT nextval('public.del_log_id_del_log_seq'::regclass);


--
-- TOC entry 3609 (class 2604 OID 6060188)
-- Name: delegacje del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delegacje ALTER COLUMN del_id SET DEFAULT nextval('public.delegacje_del_id_seq'::regclass);


--
-- TOC entry 3618 (class 2604 OID 6060189)
-- Name: detale del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detale ALTER COLUMN del_id SET DEFAULT nextval('public.detale_del_id_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 6060190)
-- Name: detale_kopia del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detale_kopia ALTER COLUMN del_id SET DEFAULT nextval('public.detale_kopia_del_id_seq'::regclass);


--
-- TOC entry 3643 (class 2604 OID 6060191)
-- Name: do_us id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.do_us ALTER COLUMN id SET DEFAULT nextval('public.do_us_id_seq'::regclass);


--
-- TOC entry 3647 (class 2604 OID 6060192)
-- Name: doradztwo_nowy del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doradztwo_nowy ALTER COLUMN del_id SET DEFAULT nextval('public.doradztwo_nowy_del_id_seq'::regclass);


--
-- TOC entry 3648 (class 2604 OID 6060193)
-- Name: dostawcy ds_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dostawcy ALTER COLUMN ds_id SET DEFAULT nextval('public.dostawcy_ds_id_seq'::regclass);


--
-- TOC entry 3651 (class 2604 OID 6060194)
-- Name: drzewo dr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drzewo ALTER COLUMN dr_id SET DEFAULT nextval('public.drzewo_dr_id_seq'::regclass);


--
-- TOC entry 3652 (class 2604 OID 6060195)
-- Name: drzewo_rysunki dr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drzewo_rysunki ALTER COLUMN dr_id SET DEFAULT nextval('public.drzewo_rysunki_dr_id_seq'::regclass);


--
-- TOC entry 3655 (class 2604 OID 6060196)
-- Name: efekty del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.efekty ALTER COLUMN del_id SET DEFAULT nextval('public.efekty_del_id_seq'::regclass);


--
-- TOC entry 3658 (class 2604 OID 6060197)
-- Name: firma del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.firma ALTER COLUMN del_id SET DEFAULT nextval('public.firma_del_id_seq'::regclass);


--
-- TOC entry 3660 (class 2604 OID 6060198)
-- Name: formaty del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formaty ALTER COLUMN del_id SET DEFAULT nextval('public.formaty_del_id_seq'::regclass);


--
-- TOC entry 3661 (class 2604 OID 6060199)
-- Name: grupa_operacji del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupa_operacji ALTER COLUMN del_id SET DEFAULT nextval('public.grupa_operacji_del_id_seq'::regclass);


--
-- TOC entry 3663 (class 2604 OID 6060200)
-- Name: jednostki del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jednostki ALTER COLUMN del_id SET DEFAULT nextval('public.jednostki_del_id_seq'::regclass);


--
-- TOC entry 3583 (class 2604 OID 6060201)
-- Name: kontrahent2 del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontrahent2 ALTER COLUMN del_id SET DEFAULT nextval('public.kontrahent2_del_id_seq'::regclass);


--
-- TOC entry 3590 (class 2604 OID 6060202)
-- Name: kontrakt2 del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontrakt2 ALTER COLUMN del_id SET DEFAULT nextval('public.kontrakt2_del_id_seq'::regclass);


--
-- TOC entry 3664 (class 2604 OID 6060203)
-- Name: kontrakt_finanse id_kontrakt_finanse; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontrakt_finanse ALTER COLUMN id_kontrakt_finanse SET DEFAULT nextval('public.kontrakt_finanse_id_kontrakt_finanse_seq'::regclass);


--
-- TOC entry 3675 (class 2604 OID 6060204)
-- Name: kooperacja2 del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kooperacja2 ALTER COLUMN del_id SET DEFAULT nextval('public.kooperacja2_del_id_seq'::regclass);


--
-- TOC entry 3677 (class 2604 OID 6060205)
-- Name: kooperacja_bckp del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kooperacja_bckp ALTER COLUMN del_id SET DEFAULT nextval('public.kooperacja_bckp_del_id_seq'::regclass);


--
-- TOC entry 3685 (class 2604 OID 6060206)
-- Name: kooperacjadok id_kooperacjadok; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kooperacjadok ALTER COLUMN id_kooperacjadok SET DEFAULT nextval('public.kooperacjadok_id_kooperacjadok_seq1'::regclass);


--
-- TOC entry 3686 (class 2604 OID 6060207)
-- Name: kooperacjadok del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kooperacjadok ALTER COLUMN del_id SET DEFAULT nextval('public.kooperacjadok_del_id_seq'::regclass);


--
-- TOC entry 3688 (class 2604 OID 6060208)
-- Name: koszty_ogolne del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.koszty_ogolne ALTER COLUMN del_id SET DEFAULT nextval('public.koszty_ogolne_del_id_seq'::regclass);


--
-- TOC entry 3704 (class 2604 OID 6060209)
-- Name: log_rysunki del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_rysunki ALTER COLUMN del_id SET DEFAULT nextval('public.log_rysunki_del_id_seq'::regclass);


--
-- TOC entry 3705 (class 2604 OID 6060210)
-- Name: logi del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logi ALTER COLUMN del_id SET DEFAULT nextval('public.logi_del_id_seq'::regclass);


--
-- TOC entry 3707 (class 2604 OID 6060211)
-- Name: logi_danych ld_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logi_danych ALTER COLUMN ld_id SET DEFAULT nextval('public.logi_danych_ld_id_seq'::regclass);


--
-- TOC entry 3710 (class 2604 OID 6060212)
-- Name: magazyn_normalia del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magazyn_normalia ALTER COLUMN del_id SET DEFAULT nextval('public.magazyn_normalia_del_id_seq'::regclass);


--
-- TOC entry 3711 (class 2604 OID 6060213)
-- Name: material del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material ALTER COLUMN del_id SET DEFAULT nextval('public.material_del_id_seq'::regclass);


--
-- TOC entry 3712 (class 2604 OID 6060214)
-- Name: miesiace del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.miesiace ALTER COLUMN del_id SET DEFAULT nextval('public.miesiace_del_id_seq'::regclass);


--
-- TOC entry 3597 (class 2604 OID 6060215)
-- Name: normalia del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.normalia ALTER COLUMN del_id SET DEFAULT nextval('public.normalia_del_id_seq'::regclass);


--
-- TOC entry 3729 (class 2604 OID 6060216)
-- Name: of_efekt del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.of_efekt ALTER COLUMN del_id SET DEFAULT nextval('public.of_efekt_del_id_seq'::regclass);


--
-- TOC entry 3731 (class 2604 OID 6060217)
-- Name: of_zespoly del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.of_zespoly ALTER COLUMN del_id SET DEFAULT nextval('public.of_zespoly_del_id_seq'::regclass);


--
-- TOC entry 3739 (class 2604 OID 6060218)
-- Name: oferta_zespoly del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oferta_zespoly ALTER COLUMN del_id SET DEFAULT nextval('public.oferta_zespoly_del_id_seq'::regclass);


--
-- TOC entry 3745 (class 2604 OID 6060219)
-- Name: ofertowanie del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertowanie ALTER COLUMN del_id SET DEFAULT nextval('public.ofertowanie_del_id_seq'::regclass);


--
-- TOC entry 3718 (class 2604 OID 6060220)
-- Name: operacje del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacje ALTER COLUMN del_id SET DEFAULT nextval('public.operacje_del_id_seq'::regclass);


--
-- TOC entry 3746 (class 2604 OID 6060221)
-- Name: opisy id_opisy; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opisy ALTER COLUMN id_opisy SET DEFAULT nextval('public.opisy_id_opisy_seq'::regclass);


--
-- TOC entry 3747 (class 2604 OID 6060222)
-- Name: opisy del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opisy ALTER COLUMN del_id SET DEFAULT nextval('public.opisy_del_id_seq'::regclass);


--
-- TOC entry 3748 (class 2604 OID 6060223)
-- Name: opisy_koop id_opisy_koop; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opisy_koop ALTER COLUMN id_opisy_koop SET DEFAULT nextval('public.opisy_koop_id_opisy_koop_seq'::regclass);


--
-- TOC entry 3749 (class 2604 OID 6060224)
-- Name: opisy_koop del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opisy_koop ALTER COLUMN del_id SET DEFAULT nextval('public.opisy_koop_del_id_seq'::regclass);


--
-- TOC entry 3751 (class 2604 OID 6060225)
-- Name: piaskowanie del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piaskowanie ALTER COLUMN del_id SET DEFAULT nextval('public.piaskowanie_del_id_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 6060226)
-- Name: postac_wsadu del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postac_wsadu ALTER COLUMN del_id SET DEFAULT nextval('public.postac_wsadu_del_id_seq'::regclass);


--
-- TOC entry 3758 (class 2604 OID 6060227)
-- Name: pracownicy del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy ALTER COLUMN del_id SET DEFAULT nextval('public.pracownicy_del_id_seq'::regclass);


--
-- TOC entry 3760 (class 2604 OID 6060228)
-- Name: prawa del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prawa ALTER COLUMN del_id SET DEFAULT nextval('public.prawa_del_id_seq'::regclass);


--
-- TOC entry 3762 (class 2604 OID 6060229)
-- Name: procedurySQL del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."procedurySQL" ALTER COLUMN del_id SET DEFAULT nextval('public."procedurySQL_del_id_seq"'::regclass);


--
-- TOC entry 3764 (class 2604 OID 6060230)
-- Name: projektanci_sumy del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projektanci_sumy ALTER COLUMN del_id SET DEFAULT nextval('public.projektanci_sumy_del_id_seq'::regclass);


--
-- TOC entry 3765 (class 2604 OID 6060231)
-- Name: przyczyna del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.przyczyna ALTER COLUMN del_id SET DEFAULT nextval('public.przyczyna_del_id_seq'::regclass);


--
-- TOC entry 3726 (class 2604 OID 6060232)
-- Name: r_plan_temp del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.r_plan_temp ALTER COLUMN del_id SET DEFAULT nextval('public.r_plan_temp_del_id_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 6060233)
-- Name: rbac_role rl_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_role ALTER COLUMN rl_pk SET DEFAULT nextval('public.rbac_role_rl_pk_seq'::regclass);


--
-- TOC entry 3770 (class 2604 OID 6060234)
-- Name: rbac_role_uprawnienia rp_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_role_uprawnienia ALTER COLUMN rp_pk SET DEFAULT nextval('public.rbac_role_uprawnienia_rp_pk_seq'::regclass);


--
-- TOC entry 3772 (class 2604 OID 6060235)
-- Name: rbac_uprawnienia ua_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_uprawnienia ALTER COLUMN ua_pk SET DEFAULT nextval('public.rbac_uprawnienia_ua_pk_seq'::regclass);


--
-- TOC entry 3775 (class 2604 OID 6060236)
-- Name: rbac_uzytkownicy uz_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_uzytkownicy ALTER COLUMN uz_pk SET DEFAULT nextval('public.rbac_uzytkownicy_uz_pk_seq'::regclass);


--
-- TOC entry 3777 (class 2604 OID 6060237)
-- Name: rbac_uzytkownicy_role ur_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_uzytkownicy_role ALTER COLUMN ur_pk SET DEFAULT nextval('public.rbac_uzytkownicy_role_ur_pk_seq'::regclass);


--
-- TOC entry 3779 (class 2604 OID 6060238)
-- Name: rbac_uzytkownicy_uprawnienia up_pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rbac_uzytkownicy_uprawnienia ALTER COLUMN up_pk SET DEFAULT nextval('public.rbac_uzytkownicy_uprawnienia_up_pk_seq'::regclass);


--
-- TOC entry 3783 (class 2604 OID 6060239)
-- Name: robocizna_wykonana id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.robocizna_wykonana ALTER COLUMN id SET DEFAULT nextval('public.robocizna_wykonana_id_seq'::regclass);


--
-- TOC entry 3784 (class 2604 OID 6060240)
-- Name: robocizna_wykonana del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.robocizna_wykonana ALTER COLUMN del_id SET DEFAULT nextval('public.robocizna_wykonana_del_id_seq'::regclass);


--
-- TOC entry 3788 (class 2604 OID 6060241)
-- Name: robocizna_wykonana_temp del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.robocizna_wykonana_temp ALTER COLUMN del_id SET DEFAULT nextval('public.robocizna_wykonana_temp_del_id_seq'::regclass);


--
-- TOC entry 3790 (class 2604 OID 6060242)
-- Name: rodz_prac del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rodz_prac ALTER COLUMN del_id SET DEFAULT nextval('public.rodz_prac_del_id_seq'::regclass);


--
-- TOC entry 3791 (class 2604 OID 6060243)
-- Name: rodzaj_rys del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rodzaj_rys ALTER COLUMN del_id SET DEFAULT nextval('public.rodzaj_rys_del_id_seq'::regclass);


--
-- TOC entry 3798 (class 2604 OID 6060244)
-- Name: rozliczenie_proj del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rozliczenie_proj ALTER COLUMN del_id SET DEFAULT nextval('public.rozliczenie_proj_del_id_seq'::regclass);


--
-- TOC entry 3800 (class 2604 OID 6060245)
-- Name: rw_detale del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rw_detale ALTER COLUMN del_id SET DEFAULT nextval('public.rw_detale_del_id_seq'::regclass);


--
-- TOC entry 3802 (class 2604 OID 6060246)
-- Name: rw_szczegoly del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rw_szczegoly ALTER COLUMN del_id SET DEFAULT nextval('public.rw_szczegoly_del_id_seq'::regclass);


--
-- TOC entry 3642 (class 2604 OID 6060247)
-- Name: rysunki2 del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rysunki2 ALTER COLUMN del_id SET DEFAULT nextval('public.rysunki2_del_id_seq'::regclass);


--
-- TOC entry 3805 (class 2604 OID 6060248)
-- Name: stan_materialu del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stan_materialu ALTER COLUMN del_id SET DEFAULT nextval('public.stan_materialu_del_id_seq'::regclass);


--
-- TOC entry 3807 (class 2604 OID 6060249)
-- Name: struktura_kontraktu del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.struktura_kontraktu ALTER COLUMN del_id SET DEFAULT nextval('public.struktura_kontraktu_del_id_seq'::regclass);


--
-- TOC entry 3809 (class 2604 OID 6060250)
-- Name: sub_branza del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_branza ALTER COLUMN del_id SET DEFAULT nextval('public.sub_branza_del_id_seq'::regclass);


--
-- TOC entry 3815 (class 2604 OID 6060251)
-- Name: szef_raport del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.szef_raport ALTER COLUMN del_id SET DEFAULT nextval('public.szef_raport_del_id_seq'::regclass);


--
-- TOC entry 3813 (class 2604 OID 6060252)
-- Name: transport del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transport ALTER COLUMN del_id SET DEFAULT nextval('public.transport_del_id_seq'::regclass);


--
-- TOC entry 3816 (class 2604 OID 6060253)
-- Name: tree_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tree_categories ALTER COLUMN id SET DEFAULT nextval('public.tree_categories_id_seq'::regclass);


--
-- TOC entry 3818 (class 2604 OID 6060254)
-- Name: typy_dokumentow del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typy_dokumentow ALTER COLUMN del_id SET DEFAULT nextval('public.typy_dokumentow_del_id_seq'::regclass);


--
-- TOC entry 3822 (class 2604 OID 6060255)
-- Name: uruchomlinii del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uruchomlinii ALTER COLUMN del_id SET DEFAULT nextval('public.uruchomlinii_del_id_seq'::regclass);


--
-- TOC entry 3824 (class 2604 OID 6060256)
-- Name: wersja del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wersja ALTER COLUMN del_id SET DEFAULT nextval('public.wersja_del_id_seq'::regclass);


--
-- TOC entry 3826 (class 2604 OID 6060257)
-- Name: wykonczenie del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wykonczenie ALTER COLUMN del_id SET DEFAULT nextval('public.wykonczenie_del_id_seq'::regclass);


--
-- TOC entry 3811 (class 2604 OID 6060258)
-- Name: zakupy_farb del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakupy_farb ALTER COLUMN del_id SET DEFAULT nextval('public.zakupy_farb_del_id_seq'::regclass);


--
-- TOC entry 3827 (class 2604 OID 6060259)
-- Name: zarzadzanie_folderami foldery_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zarzadzanie_folderami ALTER COLUMN foldery_id SET DEFAULT nextval('public.zarzadzanie_folderami_foldery_id_seq'::regclass);


--
-- TOC entry 3830 (class 2604 OID 6060260)
-- Name: zespol_stan del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zespol_stan ALTER COLUMN del_id SET DEFAULT nextval('public.zespol_stan_del_id_seq'::regclass);


--
-- TOC entry 3605 (class 2604 OID 6060261)
-- Name: zespoly del_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zespoly ALTER COLUMN del_id SET DEFAULT nextval('public.zespoly_del_id_seq'::regclass);


--
-- TOC entry 3832 (class 2606 OID 8023844)
-- Name: pracownicy pracownicypkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicypkey PRIMARY KEY (id_pracownik);


--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 196
-- Name: SEQUENCE biblio_cze_id_biblio_cze_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.biblio_cze_id_biblio_cze_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblio_cze_id_biblio_cze_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblio_cze_id_biblio_cze_seq TO PUBLIC;


--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE biblioteka_czesci; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.biblioteka_czesci TO PUBLIC;


--
-- TOC entry 4016 (class 0 OID 0)
-- Dependencies: 198
-- Name: SEQUENCE biblioteka_czesci_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.biblioteka_czesci_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_czesci_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_czesci_del_id_seq TO PUBLIC;


--
-- TOC entry 4017 (class 0 OID 0)
-- Dependencies: 199
-- Name: SEQUENCE biblioteka_czesci_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.biblioteka_czesci_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_czesci_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_czesci_id_seq TO PUBLIC;


--
-- TOC entry 4018 (class 0 OID 0)
-- Dependencies: 200
-- Name: SEQUENCE biblioteka_normaliow_biblioteka_normaliow_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.biblioteka_normaliow_biblioteka_normaliow_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_normaliow_biblioteka_normaliow_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_normaliow_biblioteka_normaliow_id_seq TO PUBLIC;


--
-- TOC entry 4020 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE biblioteka_normaliow; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.biblioteka_normaliow TO PUBLIC;


--
-- TOC entry 4022 (class 0 OID 0)
-- Dependencies: 202
-- Name: SEQUENCE biblioteka_normaliow_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.biblioteka_normaliow_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_normaliow_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.biblioteka_normaliow_del_id_seq TO PUBLIC;


--
-- TOC entry 4023 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE branza; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.branza TO PUBLIC;


--
-- TOC entry 4025 (class 0 OID 0)
-- Dependencies: 204
-- Name: SEQUENCE branza_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.branza_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.branza_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.branza_del_id_seq TO PUBLIC;


--
-- TOC entry 4026 (class 0 OID 0)
-- Dependencies: 205
-- Name: SEQUENCE branza_id_branza_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.branza_id_branza_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.branza_id_branza_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.branza_id_branza_seq TO PUBLIC;


--
-- TOC entry 4027 (class 0 OID 0)
-- Dependencies: 206
-- Name: SEQUENCE ceny_rys_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ceny_rys_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.ceny_rys_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.ceny_rys_id_seq TO PUBLIC;


--
-- TOC entry 4028 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE ceny_rys; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ceny_rys TO PUBLIC;


--
-- TOC entry 4030 (class 0 OID 0)
-- Dependencies: 208
-- Name: SEQUENCE ceny_rys_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.ceny_rys_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.ceny_rys_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.ceny_rys_del_id_seq TO PUBLIC;


--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE kontrahent2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kontrahent2 TO PUBLIC;


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE kontrakt2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kontrakt2 TO PUBLIC;


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE normalia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.normalia TO PUBLIC;


--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE zespoly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zespoly TO PUBLIC;


--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE czesci_raport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.czesci_raport TO PUBLIC;


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE czesci_zamienne; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.czesci_zamienne TO PUBLIC;


--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE del_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.del_log TO PUBLIC;


--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE del_log_id_del_log_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.del_log_id_del_log_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.del_log_id_del_log_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.del_log_id_del_log_seq TO PUBLIC;


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 218
-- Name: SEQUENCE delegacje_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.delegacje_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.delegacje_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.delegacje_id_seq TO PUBLIC;


--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE delegacje; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.delegacje TO PUBLIC;


--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 220
-- Name: SEQUENCE delegacje_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.delegacje_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.delegacje_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.delegacje_del_id_seq TO PUBLIC;


--
-- TOC entry 4046 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE detale; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detale TO PUBLIC;


--
-- TOC entry 4048 (class 0 OID 0)
-- Dependencies: 222
-- Name: SEQUENCE detale_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.detale_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.detale_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.detale_del_id_seq TO PUBLIC;


--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE detale_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.detale_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.detale_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.detale_id_seq TO PUBLIC;


--
-- TOC entry 4051 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE rysunki2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rysunki2 TO PUBLIC;


--
-- TOC entry 4052 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE detale_raport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detale_raport TO PUBLIC;


--
-- TOC entry 4053 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE detale_raport_szef; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detale_raport_szef TO PUBLIC;


--
-- TOC entry 4054 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE detaleceny_raport_szef; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detaleceny_raport_szef TO PUBLIC;


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 232
-- Name: SEQUENCE doradztwo_nowy_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.doradztwo_nowy_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.doradztwo_nowy_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.doradztwo_nowy_id_seq TO PUBLIC;


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE doradztwo_nowy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.doradztwo_nowy TO PUBLIC;


--
-- TOC entry 4059 (class 0 OID 0)
-- Dependencies: 234
-- Name: SEQUENCE doradztwo_nowy_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.doradztwo_nowy_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.doradztwo_nowy_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.doradztwo_nowy_del_id_seq TO PUBLIC;


--
-- TOC entry 4061 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE drzewo; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.drzewo TO PUBLIC;


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 239
-- Name: SEQUENCE drzewo_dr_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.drzewo_dr_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.drzewo_dr_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.drzewo_dr_id_seq TO PUBLIC;


--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE drzewo_rysunki; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.drzewo_rysunki TO PUBLIC;


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE efekty; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.efekty TO PUBLIC;


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 243
-- Name: SEQUENCE efekty_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.efekty_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.efekty_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.efekty_del_id_seq TO PUBLIC;


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 244
-- Name: SEQUENCE efekty_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.efekty_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.efekty_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.efekty_id_seq TO PUBLIC;


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 245
-- Name: SEQUENCE elementy_id_elementy_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.elementy_id_elementy_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.elementy_id_elementy_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.elementy_id_elementy_seq TO PUBLIC;


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE firma; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.firma TO PUBLIC;


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 247
-- Name: SEQUENCE firma_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.firma_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.firma_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.firma_del_id_seq TO PUBLIC;


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 248
-- Name: SEQUENCE formaty_id_formaty_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.formaty_id_formaty_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.formaty_id_formaty_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.formaty_id_formaty_seq TO PUBLIC;


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE formaty; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.formaty TO PUBLIC;


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 250
-- Name: SEQUENCE formaty_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.formaty_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.formaty_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.formaty_del_id_seq TO PUBLIC;


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE grupa_operacji; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.grupa_operacji TO PUBLIC;


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 252
-- Name: SEQUENCE grupa_operacji_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.grupa_operacji_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.grupa_operacji_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.grupa_operacji_del_id_seq TO PUBLIC;


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE jednostki; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.jednostki TO PUBLIC;


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 254
-- Name: SEQUENCE jednostki_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.jednostki_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.jednostki_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.jednostki_del_id_seq TO PUBLIC;


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 255
-- Name: SEQUENCE jednostki_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.jednostki_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.jednostki_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.jednostki_id_seq TO PUBLIC;


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 256
-- Name: SEQUENCE kontr_opis_id_kontr_opis_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontr_opis_id_kontr_opis_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontr_opis_id_kontr_opis_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontr_opis_id_kontr_opis_seq TO PUBLIC;


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 257
-- Name: SEQUENCE kontrahent2_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrahent2_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrahent2_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrahent2_del_id_seq TO PUBLIC;


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 258
-- Name: SEQUENCE kontrahent_id_kontrah_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrahent_id_kontrah_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrahent_id_kontrah_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrahent_id_kontrah_seq TO PUBLIC;


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 259
-- Name: SEQUENCE kontrakt2_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrakt2_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt2_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt2_del_id_seq TO PUBLIC;


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 260
-- Name: SEQUENCE kontrakt2_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrakt2_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt2_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt2_id_seq TO PUBLIC;


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE kontrakt_finanse; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kontrakt_finanse TO PUBLIC;


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 262
-- Name: SEQUENCE kontrakt_finanse_id_kontrakt_finanse_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrakt_finanse_id_kontrakt_finanse_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt_finanse_id_kontrakt_finanse_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt_finanse_id_kontrakt_finanse_seq TO PUBLIC;


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 263
-- Name: SEQUENCE kontrakt_id_kontrakt_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kontrakt_id_kontrakt_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt_id_kontrakt_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kontrakt_id_kontrakt_seq TO PUBLIC;


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 264
-- Name: SEQUENCE kooperacja2_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacja2_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja2_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja2_id_seq TO PUBLIC;


--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE kooperacja2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kooperacja2 TO PUBLIC;


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 266
-- Name: SEQUENCE kooperacja2_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacja2_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja2_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja2_del_id_seq TO PUBLIC;


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 267
-- Name: SEQUENCE kooperacja_bckp_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacja_bckp_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja_bckp_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja_bckp_id_seq TO PUBLIC;


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE kooperacja_bckp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kooperacja_bckp TO PUBLIC;


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 269
-- Name: SEQUENCE kooperacja_bckp_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacja_bckp_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja_bckp_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacja_bckp_del_id_seq TO PUBLIC;


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE kooperacja_raport_szef; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kooperacja_raport_szef TO PUBLIC;


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE kooperacjadok; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kooperacjadok TO PUBLIC;


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 272
-- Name: SEQUENCE kooperacjadok_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacjadok_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacjadok_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacjadok_del_id_seq TO PUBLIC;


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 273
-- Name: SEQUENCE kooperacjadok_id_kooperacjadok_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.kooperacjadok_id_kooperacjadok_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacjadok_id_kooperacjadok_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.kooperacjadok_id_kooperacjadok_seq TO PUBLIC;


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 275
-- Name: SEQUENCE koszty_ogolne_id_koszty_ogolne_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.koszty_ogolne_id_koszty_ogolne_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.koszty_ogolne_id_koszty_ogolne_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.koszty_ogolne_id_koszty_ogolne_seq TO PUBLIC;


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE koszty_ogolne; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.koszty_ogolne TO PUBLIC;


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 277
-- Name: SEQUENCE koszty_ogolne_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.koszty_ogolne_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.koszty_ogolne_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.koszty_ogolne_del_id_seq TO PUBLIC;


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE log_rysunki; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.log_rysunki TO PUBLIC;


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 280
-- Name: SEQUENCE log_rysunki_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.log_rysunki_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.log_rysunki_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.log_rysunki_id_seq TO PUBLIC;


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE logi; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.logi TO PUBLIC;


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE logi_danych; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.logi_danych TO PUBLIC;


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 283
-- Name: SEQUENCE logi_danych_ld_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.logi_danych_ld_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.logi_danych_ld_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.logi_danych_ld_id_seq TO PUBLIC;


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 284
-- Name: SEQUENCE logi_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.logi_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.logi_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.logi_del_id_seq TO PUBLIC;


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 285
-- Name: SEQUENCE magazyn_normalia_id_magazyn_normalia_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.magazyn_normalia_id_magazyn_normalia_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.magazyn_normalia_id_magazyn_normalia_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.magazyn_normalia_id_magazyn_normalia_seq TO PUBLIC;


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE magazyn_normalia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.magazyn_normalia TO PUBLIC;


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 287
-- Name: SEQUENCE magazyn_normalia_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.magazyn_normalia_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.magazyn_normalia_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.magazyn_normalia_del_id_seq TO PUBLIC;


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE material; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.material TO PUBLIC;


--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 289
-- Name: SEQUENCE material_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.material_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.material_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.material_del_id_seq TO PUBLIC;


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 290
-- Name: SEQUENCE material_id_material_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.material_id_material_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.material_id_material_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.material_id_material_seq TO PUBLIC;


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE miesiace; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.miesiace TO PUBLIC;


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 292
-- Name: SEQUENCE miesiace_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.miesiace_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.miesiace_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.miesiace_del_id_seq TO PUBLIC;


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE normalia2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.normalia2 TO PUBLIC;


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 294
-- Name: SEQUENCE normalia_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.normalia_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.normalia_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.normalia_del_id_seq TO PUBLIC;


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 295
-- Name: SEQUENCE normalia_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.normalia_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.normalia_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.normalia_id_seq TO PUBLIC;


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE normalia_raport_szef; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.normalia_raport_szef TO PUBLIC;


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE operacje; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.operacje TO PUBLIC;


--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE r_plan_temp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.r_plan_temp TO PUBLIC;


--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE obciazenie_maszyn; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.obciazenie_maszyn TO PUBLIC;


--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE of_efekt; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.of_efekt TO PUBLIC;


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 301
-- Name: SEQUENCE of_efekt_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.of_efekt_del_id_seq TO PUBLIC;


--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 302
-- Name: SEQUENCE of_efekt_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.of_efekt_id_seq TO PUBLIC;


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE of_zespoly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.of_zespoly TO PUBLIC;


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 304
-- Name: SEQUENCE of_zespoly_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.of_zespoly_del_id_seq TO PUBLIC;


--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 305
-- Name: SEQUENCE oferta_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.oferta_id_seq TO PUBLIC;


--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE oferta_zespoly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.oferta_zespoly TO PUBLIC;


--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 307
-- Name: SEQUENCE oferta_zespoly_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.oferta_zespoly_del_id_seq TO PUBLIC;


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE ofertowanie; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ofertowanie TO PUBLIC;


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 309
-- Name: SEQUENCE ofertowanie_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ofertowanie_del_id_seq TO PUBLIC;


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 310
-- Name: SEQUENCE operacje_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.operacje_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.operacje_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.operacje_del_id_seq TO PUBLIC;


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 311
-- Name: SEQUENCE "operacje_id-operacje_seq"; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public."operacje_id-operacje_seq" FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."operacje_id-operacje_seq" TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."operacje_id-operacje_seq" TO PUBLIC;


--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 312
-- Name: SEQUENCE operacje_id_operacje_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.operacje_id_operacje_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.operacje_id_operacje_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.operacje_id_operacje_seq TO PUBLIC;


--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE opisy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.opisy TO PUBLIC;


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 316
-- Name: TABLE opisy_koop; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.opisy_koop TO PUBLIC;


--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 319
-- Name: SEQUENCE piaskowanie_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.piaskowanie_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.piaskowanie_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.piaskowanie_id_seq TO PUBLIC;


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE piaskowanie; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.piaskowanie TO PUBLIC;


--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 321
-- Name: SEQUENCE piaskowanie_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.piaskowanie_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.piaskowanie_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.piaskowanie_del_id_seq TO PUBLIC;


--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE plan_robota; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.plan_robota TO PUBLIC;


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 324
-- Name: SEQUENCE podzespol_id_czesc_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.podzespol_id_czesc_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.podzespol_id_czesc_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.podzespol_id_czesc_seq TO PUBLIC;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 325
-- Name: SEQUENCE postac_wsad_id_postac_wsad_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.postac_wsad_id_postac_wsad_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.postac_wsad_id_postac_wsad_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.postac_wsad_id_postac_wsad_seq TO PUBLIC;


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE postac_wsadu; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.postac_wsadu TO PUBLIC;


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 327
-- Name: SEQUENCE postac_wsadu_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.postac_wsadu_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.postac_wsadu_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.postac_wsadu_del_id_seq TO PUBLIC;


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 328
-- Name: SEQUENCE pracownicy_id_pracownik_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.pracownicy_id_pracownik_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.pracownicy_id_pracownik_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.pracownicy_id_pracownik_seq TO PUBLIC;


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE pracownicy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pracownicy TO PUBLIC;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 329
-- Name: COLUMN pracownicy.id_pracownik; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL(id_pracownik) ON TABLE public.pracownicy TO PUBLIC;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 330
-- Name: SEQUENCE pracownicy_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.pracownicy_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.pracownicy_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.pracownicy_del_id_seq TO PUBLIC;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE prawa; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.prawa FROM postgres;
GRANT ALL ON TABLE public.prawa TO PUBLIC;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 332
-- Name: SEQUENCE prawa_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.prawa_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.prawa_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.prawa_del_id_seq TO PUBLIC;


--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 333
-- Name: SEQUENCE prawa_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.prawa_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.prawa_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.prawa_id_seq TO PUBLIC;


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 334
-- Name: SEQUENCE "procedurySQL_idprocedurySql_seq"; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public."procedurySQL_idprocedurySql_seq" FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."procedurySQL_idprocedurySql_seq" TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."procedurySQL_idprocedurySql_seq" TO PUBLIC;


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE "procedurySQL"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."procedurySQL" TO PUBLIC;


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE projektanci_raport_szef; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.projektanci_raport_szef TO PUBLIC;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE projektanci_sumy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.projektanci_sumy TO PUBLIC;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 339
-- Name: SEQUENCE projektanci_sumy_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.projektanci_sumy_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.projektanci_sumy_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.projektanci_sumy_del_id_seq TO PUBLIC;


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 340
-- Name: SEQUENCE "projektanci_sumy_idProjektanciSumy_seq"; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public."projektanci_sumy_idProjektanciSumy_seq" FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."projektanci_sumy_idProjektanciSumy_seq" TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public."projektanci_sumy_idProjektanciSumy_seq" TO PUBLIC;


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE przyczyna; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.przyczyna TO PUBLIC;


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 342
-- Name: SEQUENCE przyczyna_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.przyczyna_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.przyczyna_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.przyczyna_del_id_seq TO PUBLIC;


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 343
-- Name: SEQUENCE r_plan_temp_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.r_plan_temp_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.r_plan_temp_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.r_plan_temp_del_id_seq TO PUBLIC;


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 344
-- Name: SEQUENCE r_plan_temp_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.r_plan_temp_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.r_plan_temp_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.r_plan_temp_id_seq TO PUBLIC;


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE raport_maszyny; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.raport_maszyny TO PUBLIC;


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE rbac_uzytkownicy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rbac_uzytkownicy TO PUBLIC;


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE rbac_uzytkownicy_role; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rbac_uzytkownicy_role TO PUBLIC;


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE rbac_uzytkownicy_uprawnienia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rbac_uzytkownicy_uprawnienia TO PUBLIC;


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 360
-- Name: SEQUENCE robocizna_id_robocizna_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.robocizna_id_robocizna_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_id_robocizna_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_id_robocizna_seq TO PUBLIC;


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 361
-- Name: SEQUENCE robocizna_plan_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.robocizna_plan_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_plan_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_plan_id_seq TO PUBLIC;


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 362
-- Name: SEQUENCE robocizna_wyk_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.robocizna_wyk_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_wyk_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.robocizna_wyk_id_seq TO PUBLIC;


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE robocizna_wykonana; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.robocizna_wykonana TO PUBLIC;


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 364
-- Name: SEQUENCE robocizna_wykonana_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.robocizna_wykonana_del_id_seq TO PUBLIC;


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 365
-- Name: SEQUENCE robocizna_wykonana_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.robocizna_wykonana_id_seq TO PUBLIC;


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 367
-- Name: SEQUENCE robocizna_wykonana_temp_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.robocizna_wykonana_temp_del_id_seq TO PUBLIC;


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE rodz_prac; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rodz_prac TO PUBLIC;


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 369
-- Name: SEQUENCE rodz_prac_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rodz_prac_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodz_prac_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodz_prac_del_id_seq TO PUBLIC;


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 370
-- Name: SEQUENCE rodz_prac_id_rodz_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rodz_prac_id_rodz_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodz_prac_id_rodz_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodz_prac_id_rodz_seq TO PUBLIC;


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 371
-- Name: TABLE rodzaj_rys; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rodzaj_rys TO PUBLIC;


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 372
-- Name: SEQUENCE rodzaj_rys_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rodzaj_rys_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodzaj_rys_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rodzaj_rys_del_id_seq TO PUBLIC;


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE rozliczenie_kooperacji; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_kooperacji TO PUBLIC;


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE rozliczenie_maszyn; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_maszyn TO PUBLIC;


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 375
-- Name: SEQUENCE rozliczenie_proj_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rozliczenie_proj_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rozliczenie_proj_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rozliczenie_proj_id_seq TO PUBLIC;


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 376
-- Name: TABLE rozliczenie_proj; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_proj TO PUBLIC;


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 377
-- Name: SEQUENCE rozliczenie_proj_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rozliczenie_proj_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rozliczenie_proj_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rozliczenie_proj_del_id_seq TO PUBLIC;


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE rozliczenie_projektantow; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_projektantow TO PUBLIC;


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 379
-- Name: TABLE rozliczenie_projektantow3; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_projektantow3 TO PUBLIC;


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 380
-- Name: TABLE rozliczenie_projektantow_total; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rozliczenie_projektantow_total TO PUBLIC;


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 381
-- Name: TABLE rozliczenie_robocizny; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,UPDATE ON TABLE public.rozliczenie_robocizny TO PUBLIC;


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 383
-- Name: SEQUENCE rw_detale_id_rw_detale_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rw_detale_id_rw_detale_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_detale_id_rw_detale_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_detale_id_rw_detale_seq TO PUBLIC;


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE rw_detale; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rw_detale TO PUBLIC;


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 385
-- Name: SEQUENCE rw_detale_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rw_detale_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_detale_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_detale_del_id_seq TO PUBLIC;


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 386
-- Name: SEQUENCE rw_szczegoly_id_rw_szczegoly_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rw_szczegoly_id_rw_szczegoly_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_szczegoly_id_rw_szczegoly_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_szczegoly_id_rw_szczegoly_seq TO PUBLIC;


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE rw_szczegoly; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.rw_szczegoly TO PUBLIC;


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 388
-- Name: SEQUENCE rw_szczegoly_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rw_szczegoly_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_szczegoly_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rw_szczegoly_del_id_seq TO PUBLIC;


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 389
-- Name: SEQUENCE rysunki2_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rysunki2_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki2_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki2_del_id_seq TO PUBLIC;


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 390
-- Name: SEQUENCE rysunki2_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rysunki2_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki2_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki2_id_seq TO PUBLIC;


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 391
-- Name: SEQUENCE rysunki_id_rysunek_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.rysunki_id_rysunek_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki_id_rysunek_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.rysunki_id_rysunek_seq TO PUBLIC;


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 392
-- Name: SEQUENCE stan_materialu_id_stan_materialu_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stan_materialu_id_stan_materialu_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.stan_materialu_id_stan_materialu_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.stan_materialu_id_stan_materialu_seq TO PUBLIC;


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 393
-- Name: TABLE stan_materialu; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stan_materialu TO PUBLIC;


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 394
-- Name: SEQUENCE stan_materialu_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.stan_materialu_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.stan_materialu_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.stan_materialu_del_id_seq TO PUBLIC;


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 395
-- Name: SEQUENCE struktura_kontraktu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.struktura_kontraktu_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.struktura_kontraktu_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.struktura_kontraktu_id_seq TO PUBLIC;


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 396
-- Name: TABLE struktura_kontraktu; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.struktura_kontraktu TO PUBLIC;


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 397
-- Name: SEQUENCE struktura_kontraktu_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.struktura_kontraktu_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.struktura_kontraktu_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.struktura_kontraktu_del_id_seq TO PUBLIC;


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 398
-- Name: SEQUENCE sub_branza_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sub_branza_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.sub_branza_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.sub_branza_id_seq TO PUBLIC;


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE sub_branza; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sub_branza TO PUBLIC;


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 400
-- Name: SEQUENCE sub_branza_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.sub_branza_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.sub_branza_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.sub_branza_del_id_seq TO PUBLIC;


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 401
-- Name: TABLE suma_delegacje; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_delegacje TO PUBLIC;


--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 402
-- Name: TABLE suma_doradztwo_nowy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_doradztwo_nowy TO PUBLIC;


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 403
-- Name: TABLE suma_dostawy_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_dostawy_plan TO PUBLIC;


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 404
-- Name: SEQUENCE zakupy_farb_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zakupy_farb_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zakupy_farb_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zakupy_farb_id_seq TO PUBLIC;


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 405
-- Name: TABLE zakupy_farb; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zakupy_farb TO PUBLIC;


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 406
-- Name: TABLE suma_farby_rozl; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_farby_rozl TO PUBLIC;


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 407
-- Name: TABLE suma_kooperacji_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_kooperacji_plan TO PUBLIC;


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 408
-- Name: TABLE suma_kooperacji_plan1; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_kooperacji_plan1 TO PUBLIC;


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 409
-- Name: TABLE suma_kooperacji_wyk1; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_kooperacji_wyk1 TO PUBLIC;


--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 411
-- Name: TABLE suma_montaz_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_montaz_plan TO PUBLIC;


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 414
-- Name: TABLE suma_piaskowanie_wyk; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_piaskowanie_wyk TO PUBLIC;


--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 416
-- Name: TABLE suma_projektant_wyk; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_projektant_wyk TO PUBLIC;


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 417
-- Name: TABLE suma_przew_material; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_przew_material TO PUBLIC;


--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 419
-- Name: TABLE suma_robocizny_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_robocizny_plan TO PUBLIC;


--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 422
-- Name: TABLE suma_rozliczenie_proj; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_rozliczenie_proj TO PUBLIC;


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 423
-- Name: SEQUENCE transport_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.transport_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.transport_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.transport_id_seq TO PUBLIC;


--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 424
-- Name: TABLE transport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transport TO PUBLIC;


--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 425
-- Name: TABLE suma_transport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suma_transport TO PUBLIC;


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 427
-- Name: TABLE sumy_proj_temp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sumy_proj_temp TO PUBLIC;


--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 428
-- Name: TABLE szef_generator3; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.szef_generator3 TO PUBLIC;


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 429
-- Name: TABLE szef_generator_1; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.szef_generator_1 TO PUBLIC;


--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 430
-- Name: TABLE szef_generator_2; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.szef_generator_2 TO PUBLIC;


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 431
-- Name: TABLE szef_raport; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.szef_raport TO PUBLIC;


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 433
-- Name: TABLE szef_raport_gen; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.szef_raport_gen TO PUBLIC;


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 434
-- Name: SEQUENCE szefrpt_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.szefrpt_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.szefrpt_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.szefrpt_id_seq TO PUBLIC;


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 436
-- Name: SEQUENCE transport_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.transport_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.transport_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.transport_del_id_seq TO PUBLIC;


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 440
-- Name: SEQUENCE typy_dokumentow_id_dokument_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.typy_dokumentow_id_dokument_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.typy_dokumentow_id_dokument_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.typy_dokumentow_id_dokument_seq TO PUBLIC;


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 441
-- Name: TABLE typy_dokumentow; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.typy_dokumentow TO PUBLIC;


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 442
-- Name: SEQUENCE typy_dokumentow_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.typy_dokumentow_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.typy_dokumentow_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.typy_dokumentow_del_id_seq TO PUBLIC;


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 443
-- Name: SEQUENCE uruchomlinii_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.uruchomlinii_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.uruchomlinii_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.uruchomlinii_id_seq TO PUBLIC;


--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 444
-- Name: TABLE uruchomlinii; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.uruchomlinii TO PUBLIC;


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 445
-- Name: SEQUENCE uruchomlinii_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.uruchomlinii_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.uruchomlinii_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.uruchomlinii_del_id_seq TO PUBLIC;


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 448
-- Name: SEQUENCE wersja_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.wersja_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wersja_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wersja_id_seq TO PUBLIC;


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 449
-- Name: TABLE wersja; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.wersja TO PUBLIC;


--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 450
-- Name: SEQUENCE wersja_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.wersja_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wersja_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wersja_del_id_seq TO PUBLIC;


--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 451
-- Name: SEQUENCE wykonczenie_id_wykonczenie_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.wykonczenie_id_wykonczenie_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wykonczenie_id_wykonczenie_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wykonczenie_id_wykonczenie_seq TO PUBLIC;


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 452
-- Name: TABLE wykonczenie; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.wykonczenie TO PUBLIC;


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 453
-- Name: SEQUENCE wykonczenie_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.wykonczenie_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wykonczenie_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.wykonczenie_del_id_seq TO PUBLIC;


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 454
-- Name: TABLE zakupy_czesci; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zakupy_czesci TO PUBLIC;


--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 455
-- Name: TABLE zakupy_detali; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zakupy_detali TO PUBLIC;


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 456
-- Name: SEQUENCE zakupy_farb_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zakupy_farb_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zakupy_farb_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zakupy_farb_del_id_seq TO PUBLIC;


--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 457
-- Name: TABLE zarzadzanie_folderami; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zarzadzanie_folderami TO PUBLIC;


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 459
-- Name: SEQUENCE zespol_stan_id_projekt_stan_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zespol_stan_id_projekt_stan_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespol_stan_id_projekt_stan_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespol_stan_id_projekt_stan_seq TO PUBLIC;


--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 460
-- Name: TABLE zespol_stan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.zespol_stan TO PUBLIC;


--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 461
-- Name: SEQUENCE zespol_stan_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zespol_stan_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespol_stan_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespol_stan_del_id_seq TO PUBLIC;


--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 462
-- Name: SEQUENCE zespoly_del_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zespoly_del_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespoly_del_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespoly_del_id_seq TO PUBLIC;


--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 463
-- Name: SEQUENCE zespoly_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.zespoly_id_seq FROM postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespoly_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE public.zespoly_id_seq TO PUBLIC;


-- Completed on 2018-10-19 14:20:07

--
-- PostgreSQL database dump complete
--

