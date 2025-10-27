/*Bagian 1*/
/* Membuat database perpustakaan */
CREATE DATABASE db_perpustakaan
go;

/* Membuat table anggota, buku, dan peminjaman */
CREATE TABLE anggota (
	id_anggota INT PRIMARY KEY IDENTITY(1,1),
	nama VARCHAR(100) NOT NULL,
	alamat VARCHAR(200)
	)

CREATE TABLE buku (
	id_buku INT PRIMARY KEY IDENTITY(1,1),
	judul VARCHAR(100) NOT NULL,
	penulis VARCHAR(100)
)

CREATE TABLE peminjaman (
	id_peminjaman INT PRIMARY KEY IDENTITY(1,1),
	id_anggota INT FOREIGN KEY REFERENCES anggota(id_anggota),
	id_buku INT FOREIGN KEY REFERENCES buku(id_buku),
	tanggal_pinjam DATE DEFAULT GETDATE()
)

/* Memasukkan data contoh ke dalam tabel anggota */
INSERT INTO anggota (nama, alamat) VALUES
('Rizky', 'Jakarta'),
('Siti ', 'Bandung'),
('Dhani', 'Surabaya'),
('Dewi', 'Yogyakarta'),
('Budi', 'Medan'),
('Citra', 'Semarang'),
('Faisal', 'Malang'),
('Gita', 'Jakarta'),
('Hendra', 'Makassar'),
('Intan', 'Denpasar');

/* Memasukkan data contoh ke dalam tabel buku*/
INSERT INTO buku (judul, penulis) VALUES
('Filosofi Kopi', 'Dewi Lestari'),
('Laskar Pelangi', 'Andrea Hirata'),
('Bumi Manusia', 'Pramoedya Ananta Toer'),
('Negeri 5 Menara', 'Ahmad Fuadi'),
('Perahu Kertas', 'Dewi Lestari'),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling'),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari'),
('Atomic Habits', 'James Clear'),
('The Old Man and the Sea', 'Ernest Hemingway'),
('Pulang', 'Tere Liye');

/* Memasukkan data contoh ke dalam tabel peminjaman*/
INSERT INTO peminjaman (id_anggota, id_buku, tanggal_pinjam) VALUES
(1, 3, '2025-09-01'),
(2, 5, '2025-09-05'),
(3, 1, '2025-09-10'),
(4, 7, '2025-09-12'),
(5, 2, '2025-09-15'),
(6, 4, '2025-09-18'),
(7, 8, '2025-09-20'),
(8, 10, '2025-09-21'),
(9, 6, '2025-09-25'),
(10, 9, '2025-09-28'),
(1, 6, '2025-10-01'),
(2, 1, '2025-10-03'),
(3, 2, '2025-10-05'),
(4, 10, '2025-10-10'),
(5, 7, '2025-10-15');

/* Contoh query: Menampilkan semua anggota yang beralamat di Jakarta */
SELECT * FROM anggota
WHERE alamat = 'Jakarta'

/* Contoh query: Memperbarui alamat anggota dengan id_anggota 10 menjadi 'Bogor' */
UPDATE anggota
	SET alamat = 'Bogor'
WHERE id_anggota = 10

/* Contoh query: Menghapus anggota dengan id_anggota 10 */
DELETE anggota
WHERE id_anggota = 10

/* Menambahkan data 1 buku baru */
INSERT INTO buku (judul, penulis) VALUES
('Panduan Lima Jari', 'Edward Suhadi');

/* Bagian 2 */

/* Menampilkan daftar peminjaman beserta nama anggota dan judul bukunya */
SELECT a.nama, b.judul
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN buku b ON p.id_buku = b.id_buku;

/* Menampilkan semua anggota beserta buku yang mereka pinjam (jika ada) */
SELECT a.nama, b.judul, p.tanggal_pinjam FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
LEFT JOIN buku b ON b.id_buku = p.id_buku;

/* Menampilkan semua anggota beserta buku yang mereka pinjam (jika ada) */
SELECT a.nama, b.judul, p.tanggal_pinjam FROM anggota a
RIGHT JOIN peminjaman p ON a.id_anggota = p.id_anggota
RIGHT JOIN buku b ON p.id_buku = b.id_buku;

/* Menampilkan semua buku beserta informasi peminjamannya (jika ada) */
SELECT b.judul, b.penulis, p.tanggal_pinjam
FROM peminjaman p
RIGHT JOIN buku b ON p.id_buku = b.id_buku;

/* Menampilkan kombinasi semua anggota dengan semua buku yang ada */
SELECT a.nama AS Nama_Anggota, b.id_buku, b.judul AS Judul_Buku
FROM anggota a
CROSS JOIN buku b;

/* Menampilkan tanggal peminjaman, nama anggota, dan penulis buku untuk setiap peminjaman */
SELECT p.tanggal_pinjam, a.nama AS Nama_Anggota, b.penulis AS Penulis_Buku
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN buku b ON p.id_buku = b.id_buku;

/* Menampilkan jumlah buku yang dipinjam oleh setiap anggota */
SELECT a.nama AS Nama_Anggota, COUNT(p.id_peminjaman) AS Jumlah_Buku_Dipinjam
FROM anggota a
LEFT JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama

/* Menampilkan daftar buku yang belum pernah dipinjam */
SELECT b.judul, b.penulis
FROM buku b
LEFT JOIN peminjaman p ON b.id_buku = p.id_buku
WHERE p.id_peminjaman IS NULL;
