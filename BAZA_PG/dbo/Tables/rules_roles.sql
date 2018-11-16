CREATE TABLE [dbo].[rules_roles] (
    [id_roles]    NVARCHAR (100) NOT NULL,
    [id_rules]    NVARCHAR (100) NOT NULL,
    [typ_dostepu] INT            NULL,
    CONSTRAINT [PK_rules_roles] PRIMARY KEY CLUSTERED ([id_roles] ASC, [id_rules] ASC),
    CONSTRAINT [FK_rules_roles_AspNetRoles] FOREIGN KEY ([id_roles]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_rules_roles_rules] FOREIGN KEY ([id_rules]) REFERENCES [dbo].[rules] ([id_rules]) ON DELETE CASCADE ON UPDATE CASCADE
);

