create database online_iletisim_rehberi;
use online_iletisim_rehberi;

create table Kisiler (
   KisiID int primary key identity(1,1),
   Ad varchar(50),
   Soyad varchar(50)
);

create table Telefonlar (
   TelefonID int primary key identity(1,1),
   KisiID int,
   Telefon varchar(50),
   constraint FK_telefon_Kisi foreign key (KisiID) references Kisiler(KisiID)

);

create table Epostalar (
    EpostaID int primary key identity(1,1),
    KisiID int,
    Eposta varchar(100),
    constraint FK_Eposta_Kisi foreign key (KisiID) references Kisiler(KisiID),

);

create table Adresler (
   AdresID int primary key identity(1,1),
   KisiID int,
   Adres varchar(100),
   constraint FK_Adres_Kisi foreign key (KisiID) references Kisiler(KisiID)

);

create table Gruplar (
  GrupID int primary key identity(1,1),
  KisiID int,
  GrupAdi varchar(50),
  constraint FK_Grup_kisi foreign key (KisiID) references Kisiler(KisiID)

);

insert into Kisiler (Ad, Soyad) 
values
('Ali', 'Yılmaz'),
('Ayşe', 'Demir'),
('Mehmet', 'Kara');


insert into Telefonlar (KisiID, Telefon)
values
(1, '0532 111 11 11'),
(2, '0535 222 22 22'),
(3, '0536 333 33 33');

insert into Epostalar(KisiID, Eposta)
values
(1, 'ali@example.com'),
(2, 'ayse@example.com'),
(3, 'mehmet@example.com');

insert into Adresler (KisiID, Adres)
values
(1, 'Ankara Etimesgut'),
(2, 'Istanbul Arnavutkoy'),
(3, 'Izmir Bornova');

insert into Gruplar (KisiID, GrupAdi)
values
(1, 'Aile'),
(2, 'is'),
(3, 'Arkadas');



