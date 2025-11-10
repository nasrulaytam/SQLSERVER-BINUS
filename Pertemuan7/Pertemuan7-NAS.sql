/* 
  Membuat index pada kolom NamaDepan dan NamaBelakang
  di tabel anggota untuk meningkatkan performa pencarian.
*/
CREATE INDEX namaDepan
ON anggota (NamaDepan);

CREATE INDEX idx_alamat
ON anggota (alamat);

/* 
  Menguji performa pencarian setelah pembuatan index
  dengan mengaktifkan STATISTICS IO.
*/
SET STATISTICS IO ON
SELECT *  
FROM anggota
WHERE NamaBelakang LIKE '%N%' 
SET STATISTICS IO OFF;

SET STATISTICS IO ON
SELECT *  
FROM anggota
WHERE NamaDepan LIKE '%N%'
SET STATISTICS IO OFF;

/* 
  Mengganti nama index namaDepan menjadi idx_NamaDepanAnggota
*/
EXEC sp_rename 'anggota.namaDepan', 'idx_NamaDepanAnggota', 'INDEX';

/* 
  Melakukan backup database db_perpustakaan
  ke lokasi C:\BackupLocal\Perpustakaan.bak
*/
BACKUP DATABASE db_perpustakaan
TO DISK = 'C:\BackupLocal\Perpustakaan.bak'
WITH FORMAT,
     MEDIANAME = 'BackupPerpustakaan',
     NAME = 'Full Backup of Perpustakaan';

/*
  Melakukan Restore database db_perpustakaan
*/
RESTORE DATABASE db_perpustakaan_backup
FROM DISK = 'C:\BackupLocal\Perpustakaan.bak'
WITH MOVE 'db_perpustakaan' TO 'C:\RestoreLocal\Perpustakaan_Restore.mdf',
     MOVE 'db_perpustakaan_Log' TO 'C:\RestoreLocal\Perpustakaan_Restore.ldf';
