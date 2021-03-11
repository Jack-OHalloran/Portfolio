USE [COVID_SYMPTOMS]
GO

/****** Object:  Table [dbo].[Age]    Script Date: 2020-12-02 4:44:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Age](
	[Age_ID] [varchar](50) NOT NULL,
	[Age_0-9] [varchar](50) NULL,
	[Age_10-19] [varchar](50) NULL,
	[Age_20-24] [varchar](50) NULL,
	[Age_25-59] [varchar](50) NULL,
	[Age_60+] [varchar](50) NULL,
 CONSTRAINT [PK_Age] PRIMARY KEY CLUSTERED 
(
	[Age_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [COVID_SYMPTOMS]
GO

/****** Object:  Table [dbo].[Individual]    Script Date: 2020-12-02 4:44:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Individual](
	[Gender_Female] [varchar](50) NULL,
	[Gender_Male] [varchar](50) NULL,
	[Gender_Transgender] [varchar](50) NULL,
	[Severity_Mild] [varchar](50) NULL,
	[Severity_Moderate] [varchar](50) NULL,
	[Severity_None] [varchar](50) NULL,
	[Severity_Severe] [varchar](50) NULL,
	[Contact_Dont-Know] [varchar](50) NULL,
	[Contact_No] [varchar](50) NULL,
	[Contact_Yes] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[Individual_ID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Individual] PRIMARY KEY CLUSTERED 
(
	[Individual_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [COVID_SYMPTOMS]
GO

/****** Object:  Table [dbo].[Individual_Symptoms]    Script Date: 2020-12-02 4:44:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Individual_Symptoms](
	[Individual_ID] [varchar](50) NOT NULL,
	[Symptom_ID] [varchar](50) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Individual_Symptoms]  WITH CHECK ADD  CONSTRAINT [FK_Individual_Symptoms_Individual] FOREIGN KEY([Individual_ID])
REFERENCES [dbo].[Individual] ([Individual_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Individual_Symptoms] CHECK CONSTRAINT [FK_Individual_Symptoms_Individual]
GO


USE [COVID_SYMPTOMS]
GO

/****** Object:  Table [dbo].[Symptoms]    Script Date: 2020-12-02 4:44:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Symptoms](
	[Symptom_ID] [varchar](50) NOT NULL,
	[Fever] [varchar](50) NULL,
	[Tiredness] [varchar](50) NULL,
	[Dry-Cough] [varchar](50) NULL,
	[Difficulty-in-Breathing] [varchar](50) NULL,
	[Sore-Throat] [varchar](50) NULL,
	[None_Sympton] [varchar](50) NULL,
	[Pains] [varchar](50) NULL,
	[Nasal-Congestion] [varchar](50) NULL,
	[Runny-Nose] [varchar](50) NULL,
	[Diarrhea] [varchar](50) NULL,
	[None_Experiencing] [varchar](50) NULL,
 CONSTRAINT [PK_Symptoms] PRIMARY KEY CLUSTERED 
(
	[Symptom_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO








