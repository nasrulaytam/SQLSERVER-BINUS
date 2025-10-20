CREATE DATABASE db_kampus


CREATE TABLE Mahasiswa (
    IDMahasiswa INT PRIMARY KEY IDENTITY(1,1),
    Nama NVARCHAR(50) NOT NULL,
	Jurusan NVARCHAR (25),
	Tgl_Lahir DATE,
	Email NVARCHAR (100),
);

CREATE TABLE Dosen (
    ID_Dosen INT PRIMARY KEY IDENTITY(1,1),
    Nama_Dosen NVARCHAR(100) NOT NULL,
	Departemen NVARCHAR(50),
	No_HP NVARCHAR(15),
);

CREATE TABLE Mata_Kuliah (
    ID_MataKuliah INT PRIMARY KEY IDENTITY(1,1),
    Nama_MataKuliah NVARCHAR(100) NOT NULL,
	SKS INT,
	ID_Dosen INT FOREIGN KEY REFERENCES Dosen(ID_Dosen)
);


INSERT INTO Mahasiswa (Nama, Jurusan, Tgl_Lahir, Email) VALUES
('Siti Aisyah', 'Teknik Informatika', '2003-05-15', 'siti.aisyah@std.ac.id'),
('Joko Susilo', 'Teknik Informatika', '2004-01-20', 'joko.susilo@std.ac.id'),
('Maria Dewi', 'Manajemen', '2002-11-10', 'maria.dewi@std.ac.id'),
('Peter Halim', 'Manajemen', '2003-08-25', 'peter.halim@std.ac.id'),
('Dinda Kirana', 'Teknik Sipil', '2004-04-01', 'dinda.kirana@std.ac.id'),
('Wisnu Murti', 'Teknik Sipil', '2003-07-19', 'wisnu.murti@std.ac.id'),
('Rini Handayani', 'Sastra Inggris', '2002-12-05', 'rini.handayani@std.ac.id'),
('Kevin Lie', 'Teknik Elektro', '2004-09-08', 'kevin.lie@std.ac.id'),
('Zahra Khoirunnisa', 'Hukum', '2003-02-12', 'zahra.khoirunnisa@std.ac.id'),
('Taufik Hidayat', 'Akuntansi', '2002-10-28', 'taufik.hidayat@std.ac.id');

INSERT INTO Dosen (Nama_Dosen, Departemen, No_HP) VALUES
('Prof. Dr. Budi Santoso, M.Kom', 'Teknik Informatika', '081234567890'),
('Dr. Rina Puspita, S.E., M.M.', 'Manajemen', '087654321098'),
('Ir. Ahmad Fauzi, M.T.', 'Teknik Sipil', '085566778899'),
('Dra. Maya Sari, M.Hum.', 'Sastra Inggris', '089900112233'),
('Dr. Andi Wijaya, S.Si., M.Sc.', 'Biologi', '081122334455'),
('Prof. Ir. Nina Hartati, Ph.D.', 'Teknik Elektro', '085788990011'),
('Dr. Eko Prasetyo, S.H., M.H.', 'Hukum', '082233445566'),
('Drs. Sigit Pamungkas, M.Pd.', 'Pendidikan Matematika', '081900112233'),
('Dr. Liliana Chandra, Akt., M.Ak.', 'Akuntansi', '085677889900'),
('Prof. Dr. Yusuf Bahar, M.Psi.', 'Psikologi', '081344556677');


INSERT INTO Mata_Kuliah (Nama_MataKuliah, SKS, ID_Dosen) VALUES
('Algoritma dan Pemrograman', 3, '1'),
('Manajemen Pemasaran', 3, '2'),
('Struktur Beton Bertulang I', 4, '3'),
('English for Academic Purpose', 2, '4'),
('Genetika Dasar', 3, '5'),
('Rangkaian Listrik', 4, '6'),
('Hukum Tata Negara', 3, '7'),
('Statistik Pendidikan', 2, '8'),
('Auditing I', 3, '9'),
('Psikologi Klinis', 4, '10');


SELECT * FROM Mahasiswa;

SELECT * FROM Dosen;

SELECT * FROM Mata_Kuliah;

/*
1. Apa perbedaan antara tabel dan database? Tabel merupakan kumpulan terstruktur dari rekaman terkait (baris) dalam basis data sedangkan basis data merupakan wadah yang menyimpan, mengatur, mengelola, dan mengontrol akses ke satu atau beberapa set data.
2. Mengapa kita membutuhkan relasi antar tabel? untuk mengelola data secara efisien dengan menghindari duplikasi, memastikan integritas data, dan memudahkan analisis.
3. Apa keuntungan menggunakan SQL Server dibanding menyimpan data di Excel?
	- penanganan data bervolume besar, 
	- keamanan yang lebih baik,
	- integritas dan akurasi data yang lebih tinggi, 
	- skalabilitas, 
	- kemudahan manajemen data kompleks,
	- kemampuan kueri yang canggih
*/
