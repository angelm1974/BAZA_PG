CREATE TABLE [dbo].[rules] (
    [id_rules] NVARCHAR (100) NOT NULL,
    [regula]   VARCHAR (100)  NULL,
    [opis]     VARCHAR (500)  NULL,
    CONSTRAINT [PK_rules] PRIMARY KEY CLUSTERED ([id_rules] ASC)
);

