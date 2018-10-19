CREATE TABLE [dbo].[drzewo]
(
	[id_dr_id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [di_dr_did] BIGINT NULL, 
    [id_dr_parent_id] BIGINT NULL, 
    [dr_lbl_element] VARCHAR(20) NULL, 
    [dr_nazwa] VARCHAR(100) NULL, 
    [id_kontrakt] BIGINT NULL, 
    [id_zespol] BIGINT NULL, 
    [id_rysunki] BIGINT NULL, 
    [id_detale] BIGINT NULL, 
    [dr_tag] VARCHAR(100) NULL, 
    [dr_ikona ] INT NULL, 
    [dr_ilszt] INT NULL
)
