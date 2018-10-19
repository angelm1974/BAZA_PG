CREATE TABLE [dbo].[del_log]
(
	[de_Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [tabela] VARCHAR(30) NULL, 
    [ta_id] BIGINT NULL, 
    [data_kasowania] DATE NULL, 
    [skasowal] VARCHAR(50) NULL
)
