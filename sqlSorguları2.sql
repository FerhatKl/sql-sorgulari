create database siparis_sistemi;
use siparis_sistemi;

create table Kategoriler(
   id int not null primary key identity(1,1),
   Ad varchar(50)
);

create table Urunler(
    id int not null primary key identity(1,1),
    Aciklama varchar(50),
    Fiyat varchar(50),
    SaticiID int not null,  -- bunlari int yaptik cunku bu id ile birbirine baglayacaz sonradan
    KategoriID int not null -- kategori tablosuna baglayacaz
);

alter table Urunler 
add constraint FK_Urun_Kategori  -- 'Urunler tablosuna eklenen bir KategoriID değeri mutlaka Kategoriler tablosunda var olmalıdır.' Demek kullanılır güvenlik icin bu 
foreign key (KategoriID) references Kategoriler(id); -- burada Urunler tablosundaki KategoriID ile Kategoriler tablosundaki id ' yi birbirine bagladik ! 

create table Saticilar (
   id int not null primary key identity(1,1),
   Ad varchar(50) not null,
   Soyad varchar(50) not null,
   TelefonNumarasi varchar(20) not null,
   KullaniciAdi varchar(50) not null
);

alter table Urunler
add constraint FK_Urun_Saticisi --  bagladigimiz ikincil anahatara bu isim uzerinden ulasiiyoruz 
foreign key (SaticiID) references Saticilar(id); -- Urunler tablosundaki SaticiID ile Saticilar tablosundaki id birbirine bagladik !

create table SaticiAdresler(
   id int not null primary key identity(1,1),
   Sehir varchar(50),
   Ilce varchar(50),
   Mahalle varchar(50),
   SaticiID int -- bu id ile baglanti kuracaz 
   constraint FK_SaticiAdres_Satici
   foreign key (SaticiID) references Saticilar(id)
);

insert into Saticilar(Ad, Soyad, TelefonNumarasi, KullaniciAdi)
values ('Ege', 'Arka', '123456', 'ArkaEge');

insert into Kategoriler
values ('Elektronik1');

insert into Kategoriler
values ('Ofis'),
       ('Ev');  
 
select * from Urunler;

insert into Urunler (Aciklama, Fiyat, SaticiID, KategoriID)
values ('Laptop', '15000', 1, 1);

select * from Saticilar;

insert into Urunler (Aciklama, Fiyat, SaticiID, KategoriID)
values ('Mouse', '500', 1, 1); -- Bu artık id = 1 olur

insert into Urunler (Aciklama, Fiyat, SaticiID, KategoriID)
values ('Klavye', '750', 1, 1);

-- update komutuna bak
-- delete,
-- top 2 -> mssqlde  2 satır getir demek 'top'
-- where ile kosul belirtiyoruz bu kosula uyabları getir 'where'
-- and, or , between, in(), ' like -> detayına bak bunun ' , 
-- min, max, count, sum, avg, group by,order by,  asc, desc



---- SİPARİŞ SİSTEMİ VERİ TABANI ------

create database siparis_sistemi;
use siparis_sistemi;

create table Musteriler (
   MusteriID int not null primary key identity(1,1),
   Ad varchar(50),
   Soyad varchar(50),
   Email varchar(50),
   Telefon varchar(50)
);

create table Saticilar (
   SaticiID int not null primary key identity(1,1),
   SaticiAdi varchar(50),
   Sehir varchar(50)
);

create table Kategoriler(
   KategoriID int not null primary key identity(1,1),
   KategoriAdi varchar(50)
);

create table Urunler (
   UrunID int not null primary key identity(1,1),
   UrunAdi varchar(50),
   Fiyat decimal(10,2),
   Stok int
);

create table Siparisler (
    SiparisID int not null primary key identity(1,1),
    SiparisTarihi date,
    Miktar int,
    ToplamFiyat decimal(10,2),
    Durum varchar(50),
    MusteriID int,
    UrunID int,
    SaticiID int
);

alter table Urunler
add KategoriID int; -- Urunler tablosunu Kategoriler ile iliskilendirmek inic KategoriID kolonunu ekledik !  

alter table Urunler
add constraint FK_Urunler_Kategoriler
foreign key (KategoriID) references Kategoriler(KategoriID);

alter table Siparisler
add constraint FK_Siparisler_Musteriler
foreign key (MusteriID) references Musteriler(MusteriID); -- Siparisler Tablosundaki MusteriID ' yi Musteriler tablosundaki MusteriID ye bagladik

alter table Siparisler
add constraint FK_Siparisler_Urunler
foreign key (UrunID) references Urunler(UrunID);

alter table Siparisler
add constraint FK_Siparisler_Saticilar
foreign key (SaticiID) references Saticilar(SaticiID);

INSERT INTO Musteriler (Ad, Soyad, Email, Telefon)
VALUES
('Ali', 'Yılmaz', 'ali.yilmaz@mail.com', '05001234567'),
('Ayşe', 'Demir', 'ayse.demir@mail.com', '05007654321');

INSERT INTO Saticilar (SaticiAdi, Sehir)
VALUES 
('TeknoMarket', 'İstanbul'),
('KitapDunyasi', 'Ankara');

INSERT INTO Kategoriler (KategoriAdi)
VALUES
('Elektronik'),
('Kitap');

INSERT INTO Urunler (UrunAdi, Fiyat, Stok, KategoriID)
VALUES 
('Laptop', 15000.00, 10, 1),
('Roman Kitap', 50.00, 100, 2);

INSERT INTO Siparisler (SiparisTarihi, Miktar, ToplamFiyat, Durum, MusteriID, UrunID, SaticiID)
VALUES
('2025-11-20', 1, 15000.00, 'Hazırlanıyor', 1, 1, 1),
('2025-11-21', 2, 100.00, 'Gönderildi', 2, 2, 2);

select * from Siparisler
where Durum = 'Hazırlanıyor' and Miktar > 0; -- "WHERE ile filtreleme yaparız. Eger AND kullanırsak, her iki kosulun da aynı anda sağlanması gerekir.

select * from Siparisler
where Durum = 'Hazırlanıyor' or ToplamFiyat > 1000;  -- or en az bi tanesi saglasa yeterli

select * from Siparisler
where ToplamFiyat between 100 and 10000; -- 100 ve 1000 degerleri arasinda (between) olanlari getir sadece

select * from Siparisler
where MusteriID in (1, 2); -- MusteriID icindeki '(in)' 1 veya 2 id olanlari getir 

select * from Siparisler
where Durum like '%Hazır%'; -- icinde 'Hazır' gecen leri getir 'like'-> bunu bir kelime uc bes kelime verekde yazabiliriz ! 

-- where Email like '%@mail.com'; --  ->Sonu @mail.com ile biten e-posta adreslerini getirir.
-- where Ad like 'A%'; -- → Adı "A" harfiyle başlayan müşteriler
-- where Soyad like '_emir'; -- -> 5 harfli soyadlar, ikinci harfi "e", sonu "mir" olanlar getir .  Bu sekilde filtreleyebilrisin ! 

SELECT MAX(ToplamFiyat) AS EnYuksekFiyat -- MAX() en büyük değeri bulur, AS ise bu değere anlamlı bir isim verir.
FROM Siparisler;

SELECT MIN(ToplamFiyat) AS EnDusukFiyat  -- min en dusuk degeri bulur
FROM Siparisler;

SELECT COUNT(*) AS ToplamSiparis -- * yıldızı, COUNT(*) içinde tüm satırları saymak için kullanılır. Yani sütun fark etmeden, tablodaki her satırı sayar.
FROM Siparisler;  -- * yıldızı,tüm satirlari belirtir

SELECT COUNT(*) AS HazirlananSiparis -- Durumu "Hazırlanıyor" olan siparişlerin sayısını bulur ve sonucu HazirlananSiparis adıyla gösterir.
FROM Siparisler
WHERE Durum = 'Hazırlanıyor';

SELECT SUM(ToplamFiyat) AS ToplamGelir -- Siparisler tablosundaki tüm siparişlerin ToplamFiyat değerlerini 'toplayarak(sum)' toplam geliri hesaplar ve sonucu ToplamGelir adıyla gösterir.
FROM Siparisler;

SELECT AVG(ToplamFiyat) AS OrtalamaSiparis -- BSiparisler tablosundaki tüm siparişlerin 'ortalama (avg) ' ToplamFiyat değerini hesaplar ve sonucu OrtalamaSiparis adıyla gösterir.
FROM Siparisler;

SELECT * FROM Siparisler
ORDER BY ToplamFiyat DESC; --  Siparisler tablosundaki tüm siparişleri ToplamFiyat’a göre 'büyükten küçüğe sıralar (desc)'.

SELECT * FROM Siparisler
ORDER BY SiparisTarihi ASC; -- siparis tarihine gore 'ASC(kucukten büyüğe siralar)'
