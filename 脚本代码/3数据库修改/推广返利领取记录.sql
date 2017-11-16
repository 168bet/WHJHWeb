USE [WHJHRecordDB]
GO

IF EXISTS (SELECT 1 FROM [DBO].SYSObjects WHERE ID = OBJECT_ID(N'[dbo].[RecordSpreadReturnReceive]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
	DROP TABLE [dbo].[RecordSpreadReturnReceive]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RecordSpreadReturnReceive](
	[RecordID] [int] IDENTITY(1,1) NOT NULL, -- ��¼��ʶ
	[UserID] [int] NOT NULL,  -- �û���ʶ
	[ReceiveType] [tinyint] NOT NULL, -- ��ȡ���� 0����� 1����ʯ	
	[ReceiveNum] [int] NOT NULL,	-- ��ȡ��ֵ ������ReceiveType 0����� 1����ʯ��
	[ReceiveBefore] [bigint] NOT NULL, -- ��ȡǰ��ֵ������ReceiveType 0����� 1����ʯ��
	[ReceiveAddress] [nvarchar](15) NOT NULL, -- ��ȡIP��ַ
	[CollectDate] [datetime] NOT NULL, -- ��¼����
 CONSTRAINT [PK_RecordSpreadReturnReceive] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveNum]  DEFAULT ((0)) FOR [ReceiveNum]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveType]  DEFAULT ((0)) FOR [ReceiveType]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveBefore]  DEFAULT ((0)) FOR [ReceiveBefore]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveAddress]  DEFAULT (N'') FOR [ReceiveAddress]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ���ͣ�0����ҡ�1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ��ֵ������ReceiveType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡǰ��ֵ������ReceiveType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveBefore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ��ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO