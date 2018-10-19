CREATE TABLE [dbo].[doradztwo_nowy]
(
	[Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [ko_kontrakt] BIGINT NOT NULL, 
    [nr_raty] VARCHAR(120) NULL, 
    [opis] TEXT NULL, 
    [rozliczane] NUMERIC(10, 2) NULL, 
    [wykonane] NUMERIC(10, 2) NULL, 
    [kiedy] DATE NULL , 
    [kto] VARCHAR(20) NULL , 
    [data1raty] DATE NULL, 
    [rata1] NUMERIC(10, 2) NULL, 
    [data2raty] DATE NULL, 
    [rata2] NUMERIC(10, 2) NULL, 
    [data3raty] DATE NULL, 
    [rata3] NUMERIC(10, 3) NULL
)
