-- <Migration ID="731d617d-f764-4ce6-980c-49008fe96b94" />
GO

PRINT N'Creating schemas'
GO
PRINT N'Creating [dbo].[Course]'
GO
CREATE TABLE [dbo].[Course]
(
[CourseID] [int] NOT NULL,
[Credits] [int] NOT NULL,
[Title] [nvarchar] (50) NULL,
[DepartmentID] [int] NOT NULL CONSTRAINT [DF__Course__Departme__33D4B598] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Course] on [dbo].[Course]'
GO
ALTER TABLE [dbo].[Course] ADD CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED  ([CourseID])
GO
PRINT N'Creating index [IX_Course_DepartmentID] on [dbo].[Course]'
GO
CREATE NONCLUSTERED INDEX [IX_Course_DepartmentID] ON [dbo].[Course] ([DepartmentID])
GO
PRINT N'Creating [dbo].[Person]'
GO
CREATE TABLE [dbo].[Person]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) NOT NULL,
[HireDate] [datetime2] NULL,
[LastName] [nvarchar] (50) NOT NULL,
[EnrollmentDate] [datetime2] NULL,
[Discriminator] [nvarchar] (128) NOT NULL CONSTRAINT [DF__Person__Discrimi__38996AB5] DEFAULT (N'Instructor')
)
GO
PRINT N'Creating primary key [PK_Instructor] on [dbo].[Person]'
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED  ([ID])
GO
PRINT N'Creating [dbo].[Department]'
GO
CREATE TABLE [dbo].[Department]
(
[DepartmentID] [int] NOT NULL IDENTITY(1, 1),
[Budget] [money] NOT NULL,
[InstructorID] [int] NULL,
[Name] [nvarchar] (50) NULL,
[StartDate] [datetime2] NOT NULL,
[RowVersion] [timestamp] NULL
)
GO
PRINT N'Creating primary key [PK_Department] on [dbo].[Department]'
GO
ALTER TABLE [dbo].[Department] ADD CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED  ([DepartmentID])
GO
PRINT N'Creating index [IX_Department_InstructorID] on [dbo].[Department]'
GO
CREATE NONCLUSTERED INDEX [IX_Department_InstructorID] ON [dbo].[Department] ([InstructorID])
GO
PRINT N'Creating [dbo].[CourseAssignment]'
GO
CREATE TABLE [dbo].[CourseAssignment]
(
[CourseID] [int] NOT NULL,
[InstructorID] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_CourseAssignment] on [dbo].[CourseAssignment]'
GO
ALTER TABLE [dbo].[CourseAssignment] ADD CONSTRAINT [PK_CourseAssignment] PRIMARY KEY CLUSTERED  ([CourseID], [InstructorID])
GO
PRINT N'Creating index [IX_CourseAssignment_InstructorID] on [dbo].[CourseAssignment]'
GO
CREATE NONCLUSTERED INDEX [IX_CourseAssignment_InstructorID] ON [dbo].[CourseAssignment] ([InstructorID])
GO
PRINT N'Creating [dbo].[Enrollment]'
GO
CREATE TABLE [dbo].[Enrollment]
(
[EnrollmentID] [int] NOT NULL IDENTITY(1, 1),
[CourseID] [int] NOT NULL,
[Grade] [int] NULL,
[StudentID] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Enrollment] on [dbo].[Enrollment]'
GO
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED  ([EnrollmentID])
GO
PRINT N'Creating index [IX_Enrollment_CourseID] on [dbo].[Enrollment]'
GO
CREATE NONCLUSTERED INDEX [IX_Enrollment_CourseID] ON [dbo].[Enrollment] ([CourseID])
GO
PRINT N'Creating index [IX_Enrollment_StudentID] on [dbo].[Enrollment]'
GO
CREATE NONCLUSTERED INDEX [IX_Enrollment_StudentID] ON [dbo].[Enrollment] ([StudentID])
GO
PRINT N'Creating [dbo].[OfficeAssignment]'
GO
CREATE TABLE [dbo].[OfficeAssignment]
(
[InstructorID] [int] NOT NULL,
[Location] [nvarchar] (50) NULL
)
GO
PRINT N'Creating primary key [PK_OfficeAssignment] on [dbo].[OfficeAssignment]'
GO
ALTER TABLE [dbo].[OfficeAssignment] ADD CONSTRAINT [PK_OfficeAssignment] PRIMARY KEY CLUSTERED  ([InstructorID])
GO
PRINT N'Creating [dbo].[__EFMigrationsHistory]'
GO
CREATE TABLE [dbo].[__EFMigrationsHistory]
(
[MigrationId] [nvarchar] (150) NOT NULL,
[ProductVersion] [nvarchar] (32) NOT NULL
)
GO
PRINT N'Creating primary key [PK___EFMigrationsHistory] on [dbo].[__EFMigrationsHistory]'
GO
ALTER TABLE [dbo].[__EFMigrationsHistory] ADD CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED  ([MigrationId])
GO
PRINT N'Adding foreign keys to [dbo].[CourseAssignment]'
GO
ALTER TABLE [dbo].[CourseAssignment] ADD CONSTRAINT [FK_CourseAssignment_Course_CourseID] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseAssignment] ADD CONSTRAINT [FK_CourseAssignment_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [dbo].[Person] ([ID]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Enrollment]'
GO
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [FK_Enrollment_Course_CourseID] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollment] ADD CONSTRAINT [FK_Enrollment_Person_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Person] ([ID]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Course]'
GO
ALTER TABLE [dbo].[Course] ADD CONSTRAINT [FK_Course_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Department]'
GO
ALTER TABLE [dbo].[Department] ADD CONSTRAINT [FK_Department_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [dbo].[Person] ([ID])
GO
PRINT N'Adding foreign keys to [dbo].[OfficeAssignment]'
GO
ALTER TABLE [dbo].[OfficeAssignment] ADD CONSTRAINT [FK_OfficeAssignment_Instructor_InstructorID] FOREIGN KEY ([InstructorID]) REFERENCES [dbo].[Person] ([ID]) ON DELETE CASCADE
GO
