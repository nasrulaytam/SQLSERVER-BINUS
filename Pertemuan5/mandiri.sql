/*Query Lambat*/6
SELECT *
FROM buku
WHERE judul LIKE '%python%'

/* Query Cepat */
SELECT *
FROM buku
WHERE judul LIKE 'python%'

/* jika menggunakan wildcard di awal string, maka indeks tidak dapat digunakan secara efektif, sehingga query menjadi lambat.
maka disarankan untuk menghindari penggunaan wildcard di awal string pada klausa LIKE agar indeks dapat dimanfaatkan dengan baik dan meningkatkan kinerja query.*/

SELECT CONCAT(namadepan,' ',namabelakang) AS FullName
FROM anggota

SELECT LEN(NamaDepan)
FROM anggota

SELECT SUM(id_buku) AS total_Buku
FROM buku
WHERE tahun_terbit < 2010

CREATE TRIGGER trg_LogAnggotaBaru
ON anggota
AFTER INSERT -- Berjalan SETELAH data anggota baru masuk
AS
BEGIN
    -- Masukkan data dari tabel 'inserted' (data baru) ke tabel log
    INSERT INTO log_anggota_baru (id_anggota_baru, nama_lengkap_anggota)
    SELECT
        i.id_anggota,
        i.NamaDepan + ' ' + ISNULL(i.NamaBelakang, '')
    FROM
        inserted i;
END
GO
