----------------------------------------------------------------------
-- ʱ�䣺2011-10-20
-- ��;�����ݻ���ͳ�ơ�
----------------------------------------------------------------------
USE WHJHTreasureDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PM_StatInfo') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PM_StatInfo
GO

----------------------------------------------------------------------
CREATE PROC NET_PM_StatInfo
			
WITH ENCRYPTION AS

BEGIN
	-- ��������
	SET NOCOUNT ON;	
	--�û�ͳ��
	DECLARE @OnLineCount BIGINT		--��������
	DECLARE @DisenableCount BIGINT		--ͣȨ�û�
	DECLARE @AllCount BIGINT			--ע��������
	DECLARE @MobileRegister BIGINT		--�ֻ�ע��������
	SELECT  TOP 1 @OnLineCount=ISNULL(OnLineCountSum,0) FROM WHJHPlatformDBLink.WHJHPlatformDB.dbo.OnLineStreamInfo ORDER BY InsertDateTime DESC
	SELECT  @DisenableCount=COUNT(UserID) FROM WHJHAccountsDBLink.WHJHAccountsDB.dbo.AccountsInfo WHERE Nullity = 1
	SELECT  @AllCount=COUNT(UserID) FROM WHJHAccountsDBLink.WHJHAccountsDB.dbo.AccountsInfo
	SELECT @MobileRegister=COUNT(UserID) FROM WHJHAccountsDBLink.WHJHAccountsDB.dbo.AccountsInfo WHERE RegisterOrigin>10 AND RegisterOrigin<80

	--���ͳ��
	DECLARE @Score BIGINT		--���Ͻ������
	DECLARE @InsureScore BIGINT	--��������
	DECLARE @AllScore BIGINT
	SELECT  @Score=ISNULL(SUM(Score),0),@InsureScore=ISNULL(SUM(InsureScore),0),@AllScore=ISNULL(SUM(Score+InsureScore),0) 
	FROM GameScoreInfo(NOLOCK)

	--��ʯͳ��
	DECLARE @FKAdminPresent BIGINT	--��̨������ʯ
	DECLARE @FKCreateRoom BIGINT	--��������������ʯ
	DECLARE @FKAACreateRoom BIGINT	--����AA����������ʯ
	DECLARE @FKExchScore BIGINT		--�һ���Ϸ��������ʯ
	DECLARE @FKRMBPay BIGINT		--��ֵ��ʯ
	DECLARE @FKTotal BIGINT			--ƽ̨��ʯ����
	SELECT @FKTotal = ISNULL(SUM(Diamond),0) FROM UserCurrency(NOLOCK)
	SELECT @FKAdminPresent = ISNULL(SUM(AddDiamond),0) FROM WHJHRecordDBLink.WHJHRecordDB.dbo.RecordGrantDiamond
	SELECT @FKExchScore = ISNULL(SUM(ExchDiamond),0) FROM WHJHRecordDBLink.WHJHRecordDB.dbo.RecordCurrencyExch
	SELECT @FKCreateRoom = ISNULL(SUM(CreateTableFee),0) FROM WHJHPlatformDBLink.WHJHPlatformDB.dbo.StreamCreateTableFeeInfo WHERE PayMode=0
	SELECT @FKAACreateRoom = ISNULL(SUM(Diamond),0) FROM WHJHRecordDBLink.WHJHRecordDB.dbo.RecordGameDiamond WHERE TypeID = 1
	SELECT @FKRMBPay = ISNULL(SUM(Diamond),0) FROM OnLinePayOrder WHERE Diamond > 0 
	
	--����ͳ��
	DECLARE @RegPresent BIGINT				--ע������(1)
	DECLARE @AgentRegPresent BIGINT			--����ע������(13)
	DECLARE @DBPresent BIGINT				--�ͱ�����(2)
	DECLARE @QDPresent BIGINT				--ǩ������(3)
	DECLARE @YBPresent BIGINT				--Ԫ���һ�(4)
	DECLARE @MLPresent BIGINT				--�����һ�(5)
	DECLARE @OnlinePresent BIGINT			--����ʱ������(6)
	DECLARE @RWPresent BIGINT				--������(7)
	DECLARE @SMPresent BIGINT				--ʵ����֤(8)
	DECLARE @DayPresent BIGINT				--��Աÿ���ͽ�(9)
	DECLARE @MatchPresent BIGINT			--��������(10)
	DECLARE @DJPresent BIGINT				--�ȼ�����(11)
	DECLARE @SharePresent BIGINT			--��������(12)
	DECLARE @LotteryPresent BIGINT			--ת������(14)
	DECLARE @WebPresent BIGINT				--��̨����
	SELECT @RegPresent=ISNULL(SUM(CONVERT(BIGINT,[PresentScore])),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=1
	SELECT @AgentRegPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=13
	SELECT @DBPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=2
	SELECT @QDPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=3
	SELECT @YBPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=4
	SELECT @MLPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=5
	SELECT @OnlinePresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=6
	SELECT @RWPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=7
	SELECT @SMPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=8
	SELECT @DayPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=9
	SELECT @MatchPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=10
	SELECT @DJPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=11
	SELECT @SharePresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=12
	--SELECT @LotteryPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=14
	SELECT @LotteryPresent=ISNULL(SUM([ItemQuota]),0) FROM WHJHRecordDBLink.WHJHRecordDB.DBO.RecordLottery WHERE ItemType=0
	SELECT @WebPresent=ISNULL(SUM(CONVERT(BIGINT,AddGold)),0) FROM WHJHRecordDBLink.WHJHRecordDB.dbo.RecordGrantTreasure
	
	--˰��ͳ��
	DECLARE @Revenue BIGINT			--˰������
	DECLARE @TransferRevenue BIGINT	--ת��˰��
	SELECT @Revenue=ISNULL(SUM(Revenue),0) FROM GameScoreInfo(NOLOCK)
	SELECT @TransferRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK)

	--���ͳ��
	DECLARE @Waste BIGINT   --�������
	SELECT @Waste=ISNULL(SUM(Waste),0) FROM WHJHRecordDBLink.WHJHRecordDB.dbo.RecordEveryDayData

	--����
	SELECT  @OnLineCount AS	OnLineCount,				--��������
			@DisenableCount AS DisenableCount,			--ͣȨ�û�
			@AllCount AS AllCount,						--ע��������
			@MobileRegister AS MobileRegister,			--�ֻ���ע��������
			@Score AS Score,							--���Ͻ������
			@InsureScore AS InsureScore,				--��������
			@AllScore AS AllScore,						--�������

			@FKAdminPresent AS FKAdminPresent,			--��̨������ʯ
			@FKCreateRoom AS FKCreateRoom,				--��������������ʯ
			@FKAACreateRoom AS FKAACreateRoom,			--����AA����������ʯ
			@FKExchScore AS FKExchScore,				--�һ���Ϸ��������ʯ
			@FKRMBPay AS FKRMBPay,						--����ҹ�����ʯ
			@FKTotal AS FKTotal,						--ƽ̨��ʯ����

			@RegPresent AS RegPresent,					--ע������
			@AgentRegPresent AS AgentRegPresent,		--����ע������
			@DBPresent AS DBPresent,					--�ͱ�����
			@QDPresent AS QDPresent,					--ǩ������
			@YBPresent AS YBPresent,					--Ԫ���һ�
			@MLPresent AS MLPresent,					--�����һ�
			@OnlinePresent AS OnlinePresent,			--����ʱ������
			@RWPresent AS RWPresent,					--������
			@SMPresent AS SMPresent,					--ʵ����֤
			@DayPresent AS DayPresent,					--��Աÿ���ͽ�
			@MatchPresent AS MatchPresent,				--��������
			@DJPresent AS DJPresent,					--�ȼ�����
			@SharePresent AS SharePresent,				--��������
			@LotteryPresent AS LotteryPresent,			--ת������
			@WebPresent AS WebPresent,					--��̨����

			@Revenue AS Revenue,						--˰������
			@TransferRevenue AS TransferRevenue,		--ת��˰��	
			@Waste AS Waste								--�������
END































