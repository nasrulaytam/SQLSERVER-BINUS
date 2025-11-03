/* Latihan 1.1 */
SELECT UPPER (NamaDepan) AS Nama_Depan
FROM anggota

/* Latihan 1.2 */
SELECT LEFT(judul,5) AS Judul_Buku
FROM buku

/* Latihan 1.3 */
SELECT COUNT(id_buku) AS Jumlah_Buku
FROM buku
WHERE tahun_terbit > 2015\

/* Latihan 2.1 */
SELECT 
	DATEADD(DAY,7,tanggal_pinjam) AS Tanggal_Pinjam, DATEADD(DAY,7, tanggal_kembali) AS Tanggal_Kembali
FROM peminjaman

/*Latihan 2.2 */
SELECT COUNT(id_peminjaman) AS Jumlah_Transaksi
FROM peminjaman
WHERE YEAR(tanggal_pinjam) > 2024

/* Latihan 3.1 */
CREATE TRIGGER trg_LogTransaksi
ON peminjaman
AFTER INSERT
AS
BEGIN
    PRINT 'Data Peminjaman Buku Telah Ditambahkan';
END;

/* Latihan 3.2 */
CREATE TRIGGER Trg_CekStok
ON peminjaman
AFTER INSERT
AS
BEGIN
    UPDATE b
	SET b.stok = b.stok - 1
	FROM buku b
	INNER JOIN inserted i ON b.id_buku = i.id_buku
END;

/* Latihan 4.1 */
BEGIN TRY
    INSERT INTO buku(judul, penulis, tahun_terbit) VALUES (NULL, 'Nasrul', 2025);
END TRY
BEGIN CATCH
    PRINT 'Terjadi kesalahan saat menambah data buku baru!';
END CATCH;

/* Latihan 4.2 */
SET STATISTICS TIME ON;
SELECT * FROM buku;
SET STATISTICS TIME OFF;

SET STATISTICS TIME ON;
SELECT judul, tahun_terbit FROM buku;
SET STATISTICS TIME OFF;
