CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                   NVARCHAR (100)     NOT NULL,
    [UserName]             NVARCHAR (256)     COLLATE Polish_CI_AS NULL,
    [NormalizedUserName]   NVARCHAR (256)     COLLATE Polish_CI_AS NULL,
    [Email]                NVARCHAR (256)     COLLATE Polish_CI_AS NULL,
    [NormalizedEmail]      NVARCHAR (256)     COLLATE Polish_CI_AS NULL,
    [EmailConfirmed]       BIT                NOT NULL,
    [PasswordHash]         NVARCHAR (MAX)     COLLATE Polish_CI_AS NULL,
    [SecurityStamp]        NVARCHAR (MAX)     COLLATE Polish_CI_AS NULL,
    [ConcurrencyStamp]     NVARCHAR (MAX)     COLLATE Polish_CI_AS NULL,
    [PhoneNumber]          NVARCHAR (MAX)     COLLATE Polish_CI_AS NULL,
    [PhoneNumberConfirmed] BIT                NOT NULL,
    [TwoFactorEnabled]     BIT                NOT NULL,
    [LockoutEnd]           DATETIMEOFFSET (7) NULL,
    [LockoutEnabled]       BIT                NOT NULL,
    [AccessFailedCount]    INT                NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);

