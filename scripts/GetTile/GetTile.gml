/**
      @description Returns tile index of specified cell
      @param {Real} column	Column number of the cell
	  @param {Real} row		Row number of the cell
*/
function GetTile(column, row){
	return terrain[# column, row][| TILE.TERRAIN];
}