CREATE TABLE [dbo].[rules_user] (
    [id_user]    NVARCHAR (100) NOT NULL,
    [id_rules]   NVARCHAR (100) NOT NULL,
    [ty_dostepu] INT            NULL,
    CONSTRAINT [PK_rules_user] PRIMARY KEY CLUSTERED ([id_user] ASC, [id_rules] ASC),
    CONSTRAINT [FK_rules_user_AspNetUsers] FOREIGN KEY ([id_user]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_rules_user_rules] FOREIGN KEY ([id_rules]) REFERENCES [dbo].[rules] ([id_rules]) ON DELETE CASCADE ON UPDATE CASCADE
);

