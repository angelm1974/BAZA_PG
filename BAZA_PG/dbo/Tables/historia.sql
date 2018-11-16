CREATE TABLE [dbo].[historia] (
    [id_hist]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [nazwa_tabeli] VARCHAR (150)  NULL,
    [id_user]      NVARCHAR (100) NULL,
    [data_wpisu]   DATETIME       CONSTRAINT [DF_historiia_data_wpisu] DEFAULT (getdate()) NULL,
    [zdarzenie]    NCHAR (15)     COLLATE Latin1_General_BIN2  ENCRYPTED WITH (
     COLUMN_ENCRYPTION_KEY = [CEK_Auto1],
     ALGORITHM = N'AEAD_AES_256_CBC_HMAC_SHA_256',
     ENCRYPTION_TYPE = RANDOMIZED
    ) NULL,
    [opis_xml]     XML            NULL,
    [label]        VARCHAR (200)  NULL,
    [id_wartosc]   VARCHAR (250)  NULL,
    [id_typ]       VARCHAR (50)   NULL,
    CONSTRAINT [PK_historiia] PRIMARY KEY CLUSTERED ([id_hist] ASC),
    CONSTRAINT [FK_historia_AspNetUsers] FOREIGN KEY ([id_user]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE SET NULL ON UPDATE CASCADE
);

