/****** Object:  Table [dbo].[SSIS Configurations]    Script Date: 06/23/2009 19:00:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSIS Configurations]') AND type in (N'U'))
DROP TABLE [dbo].[SSIS Configurations]
GO
/****** Object:  Table [dbo].[SSIS Configurations]    Script Date: 06/23/2009 19:00:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSIS Configurations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SSIS Configurations](
	[ConfigurationFilter] [nvarchar](255) NOT NULL,
	[ConfiguredValue] [nvarchar](255) NULL,
	[PackagePath] [nvarchar](255) NOT NULL,
	[ConfiguredValueType] [nvarchar](20) NOT NULL
) ON [PRIMARY]
END
GO
