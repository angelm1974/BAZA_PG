CREATE TABLE [dbo].[ceny_rys]
(
	[ce_id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [rodzajrys] VARCHAR(20) NULL, 
    [cena] DECIMAL(10, 2) NULL
)
