CREATE TABLE [dbo].[biblioteka_czesci]
(
	[cz_Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [tabcz_lbl_element] VARCHAR(200) NULL, 
    [cz_nazwa] VARCHAR(200) NULL, 
    [cz_ilszt] INT NULL, 
    [cz_wartosc] DECIMAL(10, 2) NULL, 
    [cz_jedn] VARCHAR(20) NULL
)
