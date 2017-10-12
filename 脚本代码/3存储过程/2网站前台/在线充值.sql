----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-8
-- ��;�����߳�ֵ
----------------------------------------------------------------------

USE [WHJHTreasureDB]
GO

-- ���߳�ֵ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FinishOnLineOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FinishOnLineOrder
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- ���߳�ֵ
CREATE PROCEDURE NET_PW_FinishOnLineOrder
	@strOrdersID		NVARCHAR(50),			--	�������
	@PayAmount			DECIMAL(18,2),			--  ֧�����
	@strIPAddress		NVARCHAR(31),			--	�û��ʺ�	
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	�����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @Amount DECIMAL(18,2)
DECLARE @Diamond INT
DECLARE @PresentDiamond INT
DECLARE @OtherPresent INT
DECLARE @BeforeDiamond BIGINT
DECLARE @OrderStatus TINYINT
DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ������ѯ
	SELECT @UserID=UserID,@Amount=Amount,@Diamond=Diamond,@OtherPresent=OtherPresent,@OrderStatus=OrderStatus FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderID = @strOrdersID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����������!'
		RETURN 1001
	END
	IF @OrderStatus=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ���������!'
		RETURN 1002
	END
	IF @Amount != @PayAmount
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֧��������!'
		RETURN 1003
	END
	SET @PresentDiamond = @Diamond + @OtherPresent

	-- ������
	BEGIN TRAN

	SELECT @BeforeDiamond=Diamond FROM UserCurrency WITH(ROWLOCK) WHERE UserID=@UserID
	IF @BeforeDiamond IS NULL
	BEGIN
		SET @BeforeDiamond=0
		INSERT INTO UserCurrency VALUES(@UserID,@PresentDiamond)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET Diamond = Diamond + @PresentDiamond WHERE UserID=@UserID
	END
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 2001
	END
	UPDATE OnLinePayOrder SET OrderStatus=1,BeforeDiamond=@BeforeDiamond,PayDate=@DateTime,PayAddress=@strIPAddress WHERE OrderID = @strOrdersID
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 2001
	END

	COMMIT TRAN

	-- д����ʯ��ˮ��¼
	INSERT INTO WHJHRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@UserID,3,@BeforeDiamond,@PresentDiamond,@strIPAddress,@DateTime)
	
END 
RETURN 0
GO



