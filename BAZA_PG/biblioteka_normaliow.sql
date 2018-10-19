CREATE TABLE [dbo].[biblioteka_normaliow]
(
	[bn_Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [pr-Id] BIGINT NOT NULL, 
    [typ_elementu] INT NOT NULL, 
    [nazwa_elementu] VARCHAR(100) NOT NULL, 
    [symbol] VARCHAR(100) NULL, 
    [norma] VARCHAR(100) NULL, 
    [opis] TEXT NULL, 
    [cena] DECIMAL(10, 2) NULL, 
    [data_zmiany_ceny] DATE NULL, 
    [zmieniajacy] VARCHAR(100) NULL
	
)