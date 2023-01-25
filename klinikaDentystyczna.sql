CREATE DATABASE KlinikaDentystyczna
go

use KlinikaDentystyczna

-- Table Pracownicy

CREATE TABLE [Pracownicy]
(
 [pracownicy_id] int constraint pracownicy_id primary key identity(1,1),
 [imie] char(30) NOT NULL,
 [nazwisko] char(30) NOT NULL,
 [data_ur] Date NOT NULL,
 [nr_telefonu] char(24) NULL,
 [pesel] char(11) constraint u_p_pesel unique,
 [nr_konta_bankowego] char(26) NOT NULL,
 [kod_pocztowy] char(10) NOT NULL,
 [miasto] char(30) NOT NULL,
 [ulica] char(30) NOT NULL,
 [nr_domu] char(4) NOT NULL,
 [nr_mieszkania] char(4) NULL
)

-- Table Klienci

CREATE TABLE [Klienci]
(
 [id] int constraint klienci_id primary key identity(1,1),
 [imie] char(30) NOT NULL,
 [nazwisko] char(30) NOT NULL,
 [data_ur] Date NOT NULL,
 [pesel] char(11) constraint u_k_pesel unique,
 [nr_telefonu] char(24) NULL,
 [email] char(50) NULL
)

-- Table Wizyta

CREATE TABLE [Wizyta]
(
 [id] int constraint wizyta_id primary key identity(1,1),
 [id_klienta] int constraint ref_id_klienta_wizyty references Klienci(id),
 [id_pracownika] int constraint ref_id_pracownika_wizyty references Pracownicy(pracownicy_id),
 [data] Date NOT NULL,
 [godzina] time(0) NOT NULL
)

-- Table Uslugi

CREATE TABLE [Uslugi]
(
 [id_usluga] Int constraint id_usluga primary key identity(1,1),
 [nazwa] Varchar(100) NOT NULL,
 [cena] Decimal(8,2) NOT NULL
)

-- Table UslugiWykonane

CREATE TABLE [UslugiWykonane]
(
 [id] Int constraint id_wykonane primary key identity(1,1),
 [id_wizyty] Int constraint ref_id_wizyty references Wizyta(id),
 [id_uslugi] Int constraint ref_id_uslugi references Uslugi(id_usluga),
 [ilosc] Int NOT NULL DEFAULT '1'
)

-- Table Rezerwacje

CREATE TABLE [Rezerwacje]
(
 [id] Int constraint id_rezerwacje primary key identity(1,1),
 [data] Date NOT NULL,
 [godzina] time(0) NOT NULL,
 [id_pracownik] Int constraint ref_id_pracownika_rezerwacje references Pracownicy(pracownicy_id),
 [id_klient] Int constraint ref_id_klienta references Klienci(id)
)

-- Table Produkty

CREATE TABLE [Produkty]
(
 [id] Int constraint id_produkty primary key identity(1,1),
 [nazwa] char(100) NOT NULL,
 [cena] decimal(8,2) NOT NULL DEFAULT '0'
)

-- Table Magazyn

CREATE TABLE [Magazyn]
(
 [id] Int constraint id_magazyn primary key identity(1,1),
 [id_produktu] Int constraint ref_id_produktu_magazyn references Produkty(id),
 [ilosc] Int NOT NULL
)

-- Table Dostawcy

CREATE TABLE [Dostawcy]
(
 [id] Int constraint id_dostawcy primary key identity(1,1),
 [nazwa_firmy] char(100) NOT NULL,
 [NIP] char(10) NOT NULL,
 [kod_pocztowy] char(10) NOT NULL,
 [miasto] char(30) NOT NULL,
 [ulica] char(30) NOT NULL,
 [nr_budynku] char(4) NOT NULL
)

-- Table Zamowienia

CREATE TABLE [Zamowienia]
(
 [id] Int constraint id_zamowienia primary key identity(1,1),
 [id_produktu] Int constraint ref_id_produktu_zamowienia references Produkty(id),
 [id_pracownika] Int constraint ref_id_pracownika references Pracownicy(pracownicy_id),
 [ilosc] Int NOT NULL,
 [id_dostawcy] int constraint ref_id_dostawcy references Dostawcy(id)
)

-- INSERT INTO dane testowe

INSERT INTO Klienci (imie,nazwisko,data_ur,pesel,nr_telefonu,email) values 
('Jan','Kowalski', '2001-08-11', '98457345812', '+48654234534', 'jkowalski2@email.com'),
('Andrzej','Nowak', '1999-05-22', '99123456789', '+48123456789', 'nowak.a@gmail.pl'),
('Katarzyna','Budzbon', '1989-03-30', '12345678910', '+48987654321', 'katarzyna.bu@email.pl'),
('Violetta','Mardy�a', '1990-12-24', '45632178909', '+48696969696', 'violettam90@mail.edu.pl'),
('Dorota','Budz', '1998-05-13', '76584354632', '+48654234345', 'jkowalski2@email.com')

INSERT INTO Pracownicy(imie,nazwisko,data_ur,nr_telefonu,pesel,nr_konta_bankowego,kod_pocztowy,miasto,ulica,nr_domu,nr_mieszkania) values
('Tomasz','J�drzewski','1990-08-12','+48987654321','39318479626','24809300006476177804307655','30-645','Krak�w','Armii Krajowej','22',NULL),
('Tadeusz','Czerwi�ski','1998-04-27','+48715658074','98042778519','86249081865168442448262194','26-345','Gliwice','Kili�skiego','15','3'),
('Maciej','Zieli�ska','1947-11-23','+48838972496','47112387146','54248004642992981680069486','34-345','Chorz�w','Nowobielawska','45',NULL),
('Adolf','Nowakowski','1967-05-16','+48973127649','67051672897','79106019432854639357819451','12-454','Jaworzno','Jutrzenki','65','2'),
('Eryk','Kasprzak','1954-02-01','+48790248886','54020192254','92102068328035212062549978','62-207','Tychy','Kasztanowa','42',NULL)

INSERT INTO Dostawcy(nazwa_firmy,NIP,kod_pocztowy,miasto,ulica,nr_budynku) values
('MedicalMed','7399888635','70-376','Wa�brzych','Makowa','2'),
('Assort','4586748250','09-472','�ory','Szkolna','12'),
('TechMedical','4799231564','75-398','Bielsko-Bia�a','Krzywa','33'),
('Dostawcowo','8625202965','92-579','Rzesz�w','Brze�na','10'),
('SprintHelp','5089072269','46-781','Gdynia','Nieca�a','72')

INSERT INTO Wizyta(id_klienta,id_pracownika,data,godzina) values
('2','1','2022-12-18','18:30'),
('1','2','2022-12-18','17:30'),
('3','4','2022-12-19','12:30'),
('5','5','2022-12-19','14:30'),
('4','3','2022-12-19','15:45')

INSERT INTO Rezerwacje(id_klient,id_pracownik,data,godzina) values 
('1','1','2023-01-22','19:30'),
('3','1','2023-02-15','12:30'),
('2','4','2023-04-01','11:00'),
('4','2','2023-03-12','16:45'),
('3','2','2023-02-21','09:30')

INSERT INTO Produkty(nazwa,cena) values 
('igla','0.80'),
('wiertlo','35.20'),
('kubeczki','12.00'),
('maseczki','5.50'),
('plomba','12.90')

INSERT INTO Uslugi(nazwa,cena) values 
('plombowanie','40.00'),
('usuwanie kamienia naz�bnego','55.00'),
('usuni�cie z�ba','250.00'),
('wizyta kontorlna','160.00'),
('wymiana korony','10000.00')

INSERT INTO UslugiWykonane(id_wizyty,id_uslugi,ilosc) values
('1','3','1'),
('2','1','1'),
('3','2','2'),
('4','5','1'),
('5','4','2')

INSERT INTO Zamowienia(id_produktu,id_pracownika,ilosc,id_dostawcy) values
('1','5','10','2'),
('4','2','2','1'),
('5','1','1','3'),
('2','3','20','5'),
('3','4','20','4')

INSERT INTO Magazyn(id_produktu,ilosc) values 
('1','3'),
('2','10'),
('2','50'),
('4','7'),
('5','10')