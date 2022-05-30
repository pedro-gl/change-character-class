## Change Character Class
### Change Character Class for CABAL ONLINE

Changes the class of an informed character.

### Usage

Add the stored procedure to the **Server01** database and run the command:

```sql
EXEC [Server01].[dbo].[Change_Character_Class] '@CharacterIdx', '@New_Battle_Style_ID';
```

- **@CharacterIdx** = character id whose class will be changed.
- **@New_Battle_Style_ID** = number of the new Class.

<p>&nbsp;</p>

Style ID | Class
:---:|:---:
1  | Warrior
2  | Blader
3  | Wizzard
4  | Force Archer
5  | Force Shielder
6  | Force Blader
