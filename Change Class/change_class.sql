CREATE PROCEDURE [dbo].[Change_Character_Class]
	@CharacterIdx bigint,
	@NewBattleStyle int
AS
BEGIN
	DECLARE @_result int

	DECLARE @newSkillData varbinary(75)
	DECLARE @newQuickSlotData varbinary(75)
	SELECT @newSkillData = SkillData, @newQuickSlotData = QuickSlotData FROM SERVER01.dbo.cabal_new_character_data WHERE ClassType = @NewBattleStyle
	IF(@@ROWCOUNT = 0)
	BEGIN
		-- Invalid class
		SELECT @_result = -2
		GOTO finish;
	END
	
	DECLARE @login int
	DECLARE @p_str int
	DECLARE @p_int int
	DECLARE @p_dex int
	DECLARE @p_pnt int
	SELECT 
		@login = Login,
		@p_str = STR,
		@p_int = INT,
		@p_dex = DEX,
		@p_pnt = PNT
	FROM Server01.dbo.cabal_character_table WHERE CharacterIdx = @CharacterIdx
	IF(@@ROWCOUNT = 0)
	BEGIN
		-- Character not found
		SELECT @_result = -1
		GOTO finish;
	END

	IF(@login != 0)
	BEGIN
		-- Character online
		SELECT @_result = -4
		GOTO finish;
	END
	
	BEGIN TRAN updt

	UPDATE Server01.dbo.cabal_character_table SET 
		Style = ((Style - (Style & (POWER(2, 3) - 1))) + @NewBattleStyle),
		STR = 0,
		INT = 0,
		DEX = 0,
		PNT = (@p_str + @p_int + @p_dex + @p_pnt)
	WHERE CharacterIdx = @CharacterIdx
	IF(@@ROWCOUNT = 0)
	BEGIN
		-- Failed to update new style
		ROLLBACK TRAN updt
		SELECT @_result = -3
		GOTO finish;
	END

	UPDATE Server01.dbo.cabal_skilllist_table SET Data = @newSkillData WHERE CharacterIdx = @CharacterIdx
	IF(@@ROWCOUNT = 0)
	BEGIN
		-- Failed to update skilldata
		ROLLBACK TRAN updt
		SELECT @_result = 3
		GOTO finish;
	END

	UPDATE Server01.dbo.cabal_quickslot_table SET Data = @newQuickSlotData WHERE CharacterIdx = @CharacterIdx
	IF(@@ROWCOUNT = 0)
	BEGIN
		-- Failed to update quickslotdata
		ROLLBACK TRAN updt
		SELECT @_result = -3
		GOTO finish;
	END

	COMMIT TRAN t1
	
	SELECT @_result = 0
	GOTO finish;
    
    finish:
		SELECT @_result as result;
		RETURN;
END