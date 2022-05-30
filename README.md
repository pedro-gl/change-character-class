## Change Character Class
### Change Character Class for CABAL ONLINE

Changes the class of an informed character.

### Usage

Add the stored procedure to the Server01 database and run the command:

`EXEC Server01.dbo.Change_Character_Class 'CharacterIdx', 'New Battle Style';`

- **CharacterIdx** = character id whose class will be changed.
- **New Battle Style** = Number of the new Class.

**BattleStyles:**

1. Warrior
2. Blader
3. Wizzard
4. Force Archer
5. Force Shielder
6. Force Blader
