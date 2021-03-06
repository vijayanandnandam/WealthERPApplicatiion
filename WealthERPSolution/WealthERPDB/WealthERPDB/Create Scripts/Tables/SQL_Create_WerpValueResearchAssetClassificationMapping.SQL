/****** Object:  Table [dbo].[WerpValueResearchAssetClassificationMapping]    Script Date: 06/23/2009 19:02:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WerpValueResearchAssetClassificationMapping]') AND type in (N'U'))
DROP TABLE [dbo].[WerpValueResearchAssetClassificationMapping]
GO
/****** Object:  Table [dbo].[WerpValueResearchAssetClassificationMapping]    Script Date: 06/23/2009 19:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WerpValueResearchAssetClassificationMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WerpValueResearchAssetClassificationMapping](
	[WVRACM_VRCode] [int] NULL,
	[PAISSC_AssetInstrumentSubSubCategoryCode] [varchar](8) NULL,
	[PAISC_AssetInstrumentSubCategoryCode] [varchar](6) NULL,
	[PAIC_AssetInstrumentCategoryCode] [varchar](4) NULL,
	[PAG_AssetGroupCode] [varchar](2) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WerpValueResearchAssetClassificationMapping_ProductAssetInstrumentSubSubCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[WerpValueResearchAssetClassificationMapping]'))
ALTER TABLE [dbo].[WerpValueResearchAssetClassificationMapping]  WITH CHECK ADD  CONSTRAINT [FK_WerpValueResearchAssetClassificationMapping_ProductAssetInstrumentSubSubCategory] FOREIGN KEY([PAISSC_AssetInstrumentSubSubCategoryCode], [PAISC_AssetInstrumentSubCategoryCode], [PAIC_AssetInstrumentCategoryCode], [PAG_AssetGroupCode])
REFERENCES [dbo].[ProductAssetInstrumentSubSubCategory] ([PAISSC_AssetInstrumentSubSubCategoryCode], [PAISC_AssetInstrumentSubCategoryCode], [PAIC_AssetInstrumentCategoryCode], [PAG_AssetGroupCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WerpValueResearchAssetClassificationMapping_ProductAssetInstrumentSubSubCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[WerpValueResearchAssetClassificationMapping]'))
ALTER TABLE [dbo].[WerpValueResearchAssetClassificationMapping] CHECK CONSTRAINT [FK_WerpValueResearchAssetClassificationMapping_ProductAssetInstrumentSubSubCategory]
GO
