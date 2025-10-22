CREATE DATABASE sekolah

CREATE TABLE kelas (
    id_kelas INT PRIMARY KEY IDENTITY(1,1),
    nama_kelas NVARCHAR(50) UNIQUE,
    kapasitas INT CHECK (kapasitas > 0)
);

CREATE TABLE siswa (
    id_siswa INT PRIMARY KEY IDENTITY(1,1),
    nama NVARCHAR(100) NOT NULL,
    umur INT CHECK (umur >= 15),
    id_kelas INT FOREIGN KEY REFERENCES kelas(id_kelas),
    tanggal_daftar DATE DEFAULT GETDATE()
);

INSERT INTO kelas (nama_kelas, kapasitas) VALUES
('Kelas 1', 30),
('Kelas 2', 25),
('Kelas 3', 20),
('Kelas 4', 35),
('Kelas 5', 30)

INSERT INTO siswa (nama, umur, id_kelas) VALUES
('Andi', 16, 1),
('Budi', 19, 2),
('Raisa', 16, 3),
('Tika',19,4),
('Andre',30,5)


CREATE DATABASE db_management_project

CREATE TABLE Projects(
project_id INT PRIMARY KEY IDENTITY (1,1),
nama_project VARCHAR (100) NOT NULL UNIQUE,
anggaran DECIMAL(10,2) CHECK (anggaran > 0)
)

CREATE TABLE Employees(
karyawan_id INT PRIMARY KEY IDENTITY (1,1),
nama_lengkap VARCHAR (50) NOT NULL,
email VARCHAR (75) NOT NULL UNIQUE,
posisi VARCHAR (25) DEFAULT 'STAF'
)

CREATE TABLE Tasks(
task_id INT PRIMARY KEY IDENTITY (1,1),
nama_task VARCHAR (100) NOT NULL,
project_id INT FOREIGN KEY REFERENCES Projects(project_id),
karyawan_id INT FOREIGN KEY REFERENCES Employees(karyawan_id),
status_tugas VARCHAR (20) NOT NULL
)


INSERT INTO Projects (nama_project, anggaran) VALUES
('WEB AML', 1000000.00),
('Android App Judol', 50000000.00),
('Data warehouse', 1000000.00),
('AI',90000000.00),
('Machine Learning', 7000000.00)

INSERT INTO EMPLOYEES (nama_lengkap, email, posisi) VALUES
('Nasrul', 'nasrul@app.com', 'Data Analyst'),
('Budi', 'budi@app.com','' ),
('Rizal', 'rizal@app.com', 'Web Dev'),
('Putri', 'putri@app.com', 'DB Admin'),
('Teguh', 'teguh@app.com', 'AI/ML')

INSERT INTO Tasks (nama_task, project_id, karyawan_id, status_tugas) VALUES
('Create AML', 3, 3, 'Proses'),
('Create Android App', 4, 3, 'Done'),
('Add Data', 5, 1, 'Proses'),
('AI', 6, 5, 'Start'),
('Machine Learning', 7, 5, 'Done')


/*
1. Apa perbedaan antara PRIMARY KEY dan UNIQUE? 
	PRIMARY KEY Menandai kolom unik dan tidak boleh kosong
	UNIQUE Nilai kolom tidak boleh sama	
2. Kapan kita perlu menggunakan DEFAULT?
	Pada saat field yang kosong diberi nilai otomatis
3. Mengapa FOREIGN KEY penting dalam menjaga konsistensi data?
	mencegah adanya data yang tidak valid, serta memperkuat hubungan antar table dan menghindarkan redundansi data
*/

