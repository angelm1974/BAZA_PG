CREATE TABLE [dbo].[detale]
(
	[Id_detale] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [id_rysunki] BIGINT NOT NULL, 
    [numer] INT NOT NULL, 
    [material] VARCHAR(20) NOT NULL, 
    [wsad] VARCHAR(25) NOT NULL, 
    [ilsztuk] INT NOT NULL, 
    [wymiar_a] FLOAT NULL, 
    [wymiar_b] FLOAT NULL, 
    [wymiar_c] FLOAT NULL, 
    [ciez_jedn] FLOAT NULL, 
    [ciez_sztuki] FLOAT NULL, 
    [ciez_calkowity] FLOAT NULL, 
    [cena] FLOAT NULL, 
    [id_kontrakt] BIGINT NOT NULL, 
    [id_zespol] BIGINT NOT NULL, 
    [rozliczony boolean] BIT NULL DEFAULT 0, 
    [cena_rozl] FLOAT NULL DEFAULT 0, 
    [stan_materialu] SMALLINT NULL DEFAULT 0, 
    [pociety] SMALLINT NULL DEFAULT 0, 
    [cena_bufor] FLOAT NULL DEFAULT 0, 
    [rodz_kooperacji] SMALLINT NULL DEFAULT 0, 
    [id_rw_detale] BIGINT NULL, 
    [data_ciecia] DATE NULL, 
    [kolejnosc_rw] INT NULL, 
    [rw_wb] VARCHAR(MAX) NULL, 
    [wb_ok] INT NULL DEFAULT 0, 
    [kieszen] VARCHAR(2) NULL, 
    [data_wpl] DATE NULL
)
