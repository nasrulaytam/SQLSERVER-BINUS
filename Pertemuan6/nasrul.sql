/* Mengurutkan data dalam tabel 'buku' berdasarkan kolom 'penulis' secara ascending (A-Z) */
SELECT * FROM buku
ORDER BY penulis ASC;

/* Menghitung jumlah buku yang diterbitkan oleh setiap penerbit */
SELECT 
    Penerbit,
    COUNT(*) AS Jumlah_Buku
FROM 
    Buku
GROUP BY 
    Penerbit
ORDER BY 
    Jumlah_Buku DESC;

/* Menampilkan penerbit yang memiliki lebih dari 3 buku */
SELECT 
    Penerbit,
    COUNT(*) AS Jumlah_Buku
FROM 
    Buku
GROUP BY 
    Penerbit
HAVING
	COUNT(*) > 3

/* Menampilkan judul, tahun terbit, dan penerbit dari buku yang diterbitkan setelah tahun 2018 oleh 'Penerbit Keagamaan Spesialis' */
SELECT judul, tahun_terbit, penerbit
FROM buku
WHERE tahun_terbit > 2018 AND penerbit = 'Penerbit Keagamaan Spesialis'

/* Menampilkan judul, tahun terbit, dan penulis dari buku yang diterbitkan sebelum tahun 2010 atau ditulis oleh 'Andrea Hirata' */
SELECT judul, tahun_terbit, penulis
FROM buku
WHERE tahun_terbit < 2010 OR penulis = 'Andrea Hirata'

/* Menampilkan judul, tahun terbit, dan penulis dari buku yang tidak ditulis oleh 'JK Rowling' */
SELECT judul, tahun_terbit, penulis
FROM buku
WHERE NOT penulis = 'JK Rowling'

/* Menampilkan judul, tahun terbit, dan status tahun terbit dari buku dengan kriteria tertentu */
SELECT 
    Judul,
    tahun_terbit,
    CASE 
        WHEN tahun_terbit > 2018 THEN 'Terbaru'
        WHEN tahun_terbit BETWEEN 2010 AND 2018 THEN 'Menengah'
        ELSE 'Klasik'
    END AS StatusTahun
FROM Buku
ORDER BY tahun_terbit DESC;

/* Menampilkan jumlah buku yang ditulis oleh setiap penulis */
	penulis,
	COUNT(*) AS JumlahBuku
FROM buku
GROUP BY penulis;

/* Menampilkan tahun terbit tertua dan terbaru untuk setiap penulis */
SELECT
	penulis,
	MIN(tahun_terbit) AS Tahun_Terbit_Tertua
FROM buku
GROUP BY penulis
ORDER BY Tahun_Terbit_Tertua ASC;


/* Menampilkan tahun terbit tertua dan terbaru untuk setiap penulis */
SELECT
	penulis,
	MAX(tahun_terbit) AS Tahun_Terbit_Terbaru
FROM buku
GROUP BY penulis
ORDER BY Tahun_Terbit_Terbaru DESC;

/* Mengkategorikan penulis berdasarkan tahun terbit terbaru dari bukunya */
SELECT 
	penulis,
    MAX(tahun_terbit) AS Tahun_Terbit_Terbaru,
    CASE 
        WHEN MAX(tahun_terbit) >= 2022 THEN 'Aktif'
        WHEN MAX(tahun_terbit) BETWEEN 2015 AND 2021 THEN 'Produktif'
        ELSE 'Tidak aktif lagi'
    END AS Kategori_pengarang
FROM buku
GROUP BY penulis
ORDER BY penulis DESC;
