/****** Object:  View [dbo].[ViewCollectiblesNP]    Script Date: 06/24/2009 14:45:12 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewCollectiblesNP]'))
DROP VIEW [dbo].[ViewCollectiblesNP]
GO
/****** Object:  View [dbo].[ViewCollectiblesNP]    Script Date: 06/24/2009 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewCollectiblesNP]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW dbo.ViewCollectiblesNP
AS
SELECT     dbo.Adviser.A_AdviserId, dbo.AdviserRM.AR_RMId, dbo.Customer.C_CustomerId, dbo.CustomerCollectibleNetPosition.CCNP_CollectibleNPId, 
                      dbo.CustomerCollectibleNetPosition.CP_PortfolioId, dbo.CustomerCollectibleNetPosition.PAIC_AssetInstrumentCategoryCode, 
                      dbo.CustomerCollectibleNetPosition.PAG_AssetGroupCode, dbo.CustomerCollectibleNetPosition.CCNP_PurchasePrice, 
                      dbo.CustomerCollectibleNetPosition.CCNP_Name, dbo.CustomerCollectibleNetPosition.CCNP_PurchaseDate, 
                      dbo.CustomerCollectibleNetPosition.CCNP_PurchaseValue, dbo.CustomerCollectibleNetPosition.CCNP_CurrentPrice, 
                      dbo.CustomerCollectibleNetPosition.CCNP_CurrentValue, dbo.CustomerCollectibleNetPosition.CCNP_Remark, 
                      dbo.CustomerCollectibleNetPosition.CCNP_Quantity, dbo.CustomerCollectibleNetPosition.CCNP_CreatedBy, 
                      dbo.CustomerCollectibleNetPosition.CCNP_CreatedOn, dbo.CustomerCollectibleNetPosition.CCNP_ModifiedBy, 
                      dbo.CustomerCollectibleNetPosition.CCNP_ModifiedOn, dbo.CustomerPortfolio.CP_PortfolioId AS Expr1, 
                      dbo.ProductAssetInstrumentCategory.PAIC_AssetInstrumentCategoryName, dbo.ProductAssetGroup.PAG_AssetGroupName
FROM         dbo.Adviser INNER JOIN
                      dbo.AdviserRM ON dbo.Adviser.A_AdviserId = dbo.AdviserRM.A_AdviserId INNER JOIN
                      dbo.Customer ON dbo.AdviserRM.AR_RMId = dbo.Customer.AR_RMId INNER JOIN
                      dbo.CustomerPortfolio ON dbo.Customer.C_CustomerId = dbo.CustomerPortfolio.C_CustomerId INNER JOIN
                      dbo.CustomerCollectibleNetPosition ON dbo.CustomerPortfolio.CP_PortfolioId = dbo.CustomerCollectibleNetPosition.CP_PortfolioId INNER JOIN
                      dbo.ProductAssetInstrumentCategory ON 
                      dbo.CustomerCollectibleNetPosition.PAIC_AssetInstrumentCategoryCode = dbo.ProductAssetInstrumentCategory.PAIC_AssetInstrumentCategoryCode AND
                       dbo.CustomerCollectibleNetPosition.PAG_AssetGroupCode = dbo.ProductAssetInstrumentCategory.PAG_AssetGroupCode INNER JOIN
                      dbo.ProductAssetGroup ON dbo.ProductAssetInstrumentCategory.PAG_AssetGroupCode = dbo.ProductAssetGroup.PAG_AssetGroupCode
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewCollectiblesNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[19] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -229
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Adviser"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AdviserRM"
            Begin Extent = 
               Top = 6
               Left = 298
               Bottom = 121
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 543
               Bottom = 121
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerPortfolio"
            Begin Extent = 
               Top = 126
               Left = 337
               Bottom = 241
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerCollectibleNetPosition"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 299
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductAssetInstrumentCategory"
            Begin Extent = 
               Top = 126
               Left = 546
               Bottom = 241
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductAssetGroup"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 354
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCollectiblesNP'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane2' , N'SCHEMA',N'dbo', N'VIEW',N'ViewCollectiblesNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCollectiblesNP'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewCollectiblesNP', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCollectiblesNP'
GO
