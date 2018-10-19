CREATE TABLE [dbo].[delegacje]
(
	[Id_delegacje] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [numer] VARCHAR(100) NULL, 
    [osoba] VARCHAR(50) NULL, 
    [kwota] NUMERIC(10, 2) NULL, 
    [id_kontrakt] BIGINT NOT NULL, 

)
