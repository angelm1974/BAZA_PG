CREATE TABLE [dbo].[biblioteka_czesci]
(
	[de_Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [tabela] VARCHAR(30) NULL, 
    [id_tabeli] BIGINT NULL, 
    [data_kasowania] DATE NULL, 
    [skasowal] VARCHAR(50) NULL
)
