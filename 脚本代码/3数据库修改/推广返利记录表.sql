USE [WHJHRecordDB]
GO

IF EXISTS (SELECT 1 FROM [DBO].SYSObjects WHERE ID = OBJECT_ID(N'[dbo].[RecordSpreadReturn]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
	DROP TABLE [dbo].[RecordSpreadReturn]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RecordSpreadReturn](
	[RecordID] [int] IDENTITY(1,1) NOT NULL, -- ��¼��ʶ
	[SourceUserID] [int] NOT NULL,  -- ��ֵ����
	[TargetUserID] [int] NOT NULL,	-- ��������
	[SourceDiamond] [int] NOT NULL,  -- ��ֵ������ʯ
	[SpreadLevel] [int] NOT NULL, -- ���������ƹ㼶��
	[ReturnScale] [decimal](18, 6) NOT NULL, -- ��������
	[ReturnNum] [int] NOT NULL,	-- ������ֵ ������ReturnType 0����� 1����ʯ��
	[ReturnType] [tinyint] NOT NULL, -- �������� 0����� 1����ʯ
	[CollectDate] [datetime] NOT NULL, -- ��¼����
 CONSTRAINT [PK_RecordSpreadReturn] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SourceUserID]  DEFAULT ((0)) FOR [SourceUserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_TargetUserID]  DEFAULT ((0)) FOR [TargetUserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SourceDiamond]  DEFAULT ((0)) FOR [SourceDiamond]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SpreadLevel]  DEFAULT ((0)) FOR [SpreadLevel]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnScale]  DEFAULT ((0)) FOR [ReturnScale]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnNum]  DEFAULT ((0)) FOR [ReturnNum]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnType]  DEFAULT ((0)) FOR [ReturnType]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SourceUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'TargetUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ������ʯ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SourceDiamond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������ƹ㼶��Ŀǰ��֧��3����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SpreadLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnScale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ֵ ������ReturnType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������ͣ�0����ҡ�1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO