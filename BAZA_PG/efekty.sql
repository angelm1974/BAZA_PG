CREATE TABLE dbo.efekty
(
    [ef_id] BIGINT NOT NULL IDENTITY,
    [id_kontrakt] BIGINT NOT NULL, 
    [id_zespol] BIGINT NULL, 
    [el_kalkulacja] TEXT NULL, 
    [wykonawca] TEXT NULL, 
    [od_ciez] TEXT NULL, 
    [of_wartosc] NUMERIC(10, 2) NULL, 
    [przew_ciez] NUMERIC(8, 2) NULL, 
    [przew_wartosc] NUMERIC(10, 2) NULL, 
    [rozl_ciez] NUMERIC(8, 2) NULL, 
    [rozl_wartosc] NUMERIC(10, 2) NULL, 
    [flaga1] BIGINT NULL, 
    [flaga2] BIGINT NULL, 
    [flaga3] TEXT NULL, 
    [flagatyp] BIGINT NULL, 
    [ins_data] DATE NULL, 
    [ins_user] VARCHAR(100) NULL, 
    [upd_data] DATE NULL, 
    [upd_user] VARCHAR(100) NULL, 
    [del_id] BIGINT NOT NULL, 
    [obiekt] TEXT NULL, 
    CONSTRAINT [PK_efekty] PRIMARY KEY ([ef_id]), 
    CONSTRAINT [FK_efekty_ToTable] FOREIGN KEY ([id_zespol]) REFERENCES [zespol]([id_zespol]), 
    CONSTRAINT [FK_efekty_ToTable_1] FOREIGN KEY ([id_kontrakt]) REFERENCES [kontrakt]([id_kontrakt]) 
);