CREATE TABLE [dbo].[biblioteka_czesci]
(
	[bc_Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [br_id] BIGINT NOT NULL, 
    [nazwa] VARCHAR(50) NOT NULL, 
    [symbol] VARCHAR(100) NULL, 
    [norma] VARCHAR(60) NULL, 
    [cena] DECIMAL(10, 2) NULL, 
    [opis] TEXT NULL, 
    [sb_id] BIGINT NULL, 
    [sortowanie] VARCHAR(3) NULL, 
    [data_zmiany_ceny] DATE NULL, 
    [zmieniajacy] VARCHAR(50) NULL
)
