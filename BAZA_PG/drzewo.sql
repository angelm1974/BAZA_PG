CREATE TABLE [dbo].[drzewo]
(
	[dr_id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [di_dr_did] BIGINT NULL, 
    [dr_parent_id] BIGINT NULL, 
    [bl_element] VARCHAR(20) NULL, 
    [nazwa] VARCHAR(100) NULL, 
    [id_kontrakt] BIGINT NULL, 
    [id_zespol] BIGINT NULL, 
    [ry_id] BIGINT NULL, 
    [de_id] BIGINT NULL, 
    [tag] VARCHAR(100) NULL, 
    [ikona] INT NULL, 
    [il_sztk] INT NULL
)
