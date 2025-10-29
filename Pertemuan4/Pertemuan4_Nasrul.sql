/*Latihan 6 */
/* 
  Stored Procedure: CariAnggota
  Description: Mencari anggota berdasarkan nama depan yang diberikan.
  Parameter: 
	@searchNamaDepan - Nama depan yang akan dicari (VARCHAR(100))
*/
CREATE PROCEDURE CariAnggota
@searchNamaDepan VARCHAR(100)
AS
BEGIN
	SELECT 
		NamaDepan,
		alamat
	FROM
	anggota
	WHERE NamaDepan LIKE '%' + @searchNamaDepan + '%'
END;

EXEC CariAnggota @searchNamaDepan = 'Rizky';

/* 
  Stored Procedure: TambahAnggota
  Description: Menambahkan anggota baru ke dalam tabel anggota.
  Parameter: 
	@NamaDepan - Nama depan anggota baru (NVARCHAR(100))
	@NamaBelakang - Nama belakang anggota baru (NVARCHAR(100))
	@alamat - Alamat anggota baru (NVARCHAR(200))
*/
CREATE PROCEDURE TambahAnggota
    @NamaDepan NVARCHAR(100),
    @NamaBelakang NVARCHAR(100),
    @alamat NVARCHAR(200)
AS
BEGIN
    INSERT INTO anggota (NamaDepan, NamaBelakang, alamat)
    VALUES (@NamaDepan, @NamaBelakang, @alamat);

    SELECT * FROM anggota
END;

EXEC TambahAnggota @NamaDepan = 'Nasrul', @NamaBelakang = 'Aytam', @alamat = 'Jakarta Selatan'

/* 
  Stored Procedure: UbahJudulBuku
  Description: Mengubah judul buku berdasarkan ID buku yang diberikan.
  Parameter: 
	@id_buku - ID buku yang akan diubah (INT)
	@JudulBaru - Judul baru untuk buku tersebut (VARCHAR(100))
*/
CREATE PROCEDURE UbahJudulBuku
	@id_buku INT,
	@JudulBaru VARCHAR (100)
AS
BEGIN
	UPDATE buku
	SET judul = @JudulBaru
	WHERE id_buku = @id_buku
END

EXEC UbahJudulBuku @JudulBaru = 'Laut Tidak Bisa Cerita', @id_buku = 13

/* 
  Stored Procedure: HapusBuku
  Description: Menghapus buku berdasarkan ID buku yang diberikan.
  Parameter: 
	@id_buku - ID buku yang akan dihapus (INT)
*/
CREATE PROCEDURE HapusBuku
	@id_buku INT
AS
BEGIN
	DELETE buku
	WHERE id_buku = @id_buku
END
EXEC HapusBuku @id_buku = 14

/* 
  Stored Procedure: TambahTransaksi
  Description: Menambahkan transaksi peminjaman baru ke dalam tabel peminjaman.	
  Parameter: 
	@idAnggota - ID anggota yang melakukan peminjaman (INT)
	@idBuku - ID buku yang dipinjam (INT)
	@tanggalPinjam - Tanggal peminjaman (DATE)
*/
CREATE PROCEDURE TambahTransaksi
	@idAnggota INT,
	@idBuku INT,
	@tanggalPinjam DATE
AS
BEGIN
	INSERT INTO peminjaman(id_anggota, id_buku, tanggal_pinjam)
	VALUES (@idAnggota, @idBuku, @tanggalPinjam);

	SELECT * FROM peminjaman;
END;

EXEC TambahTransaksi @idAnggota = 4, @idBuku = 15, @tanggalPinjam = '2025-10-27'

/*Latihan 7 */
/* 
  Stored Procedure: PengembalianBuku
  Description: Memperbarui tanggal_kembali pada tabel peminjaman berdasarkan ID peminjaman yang diberikan.
  Parameter: 
	@idPeminjaman - ID peminjaman yang akan diperbarui (INT)
*/
CREATE PROCEDURE PengembalianBuku
 @idPeminjaman INT
AS
BEGIN

	UPDATE peminjaman
	SET tanggal_kembali = GETDATE()
	WHERE id_peminjaman = @idPeminjaman

END

EXEC PengembalianBuku @idPeminjaman = 5

/* 
  Stored Procedure: BukuPopuler
  Description: Mengambil daftar buku paling populer berdasarkan jumlah peminjaman.
  Parameter: 
	@TopFive - Jumlah buku teratas yang akan ditampilkan (INT)
*/
CREATE PROCEDURE BukuPopuler
	@TopFive INT
AS
BEGIN
	SELECT TOP (@TopFive)
		b.judul AS Judul_Buku,
		b.penulis AS Penulis,
		COUNT(p.id_peminjaman) AS Jumlah_Peminjam
	FROM
	buku b
	INNER JOIN
	peminjaman p ON b.id_buku = p.id_buku
	GROUP BY
	b.id_buku, b.judul, b.penulis
	ORDER BY
	Jumlah_Peminjam DESC
END

EXEC BukuPopuler @TopFive = 1

/* 
  Stored Procedure: TambahBuku
  Description: Menambahkan buku baru ke dalam tabel buku.
  Parameter: 
	@JudulNew - Judul buku baru (NVARCHAR(100))
	@penulisNew - Penulis buku baru (NVARCHAR(100))
*/
CREATE PROCEDURE TambahBuku
    @JudulNew NVARCHAR(100),
    @penulisNew NVARCHAR(100)
AS
BEGIN
    INSERT INTO buku (judul, penulis)
    VALUES (@JudulNew, @penulisNew);

    SELECT * FROM buku
END;

EXEC TambahBuku @JudulNew = 'Python for Data Analysis', @penulisNew = 'Wes McKinney'
