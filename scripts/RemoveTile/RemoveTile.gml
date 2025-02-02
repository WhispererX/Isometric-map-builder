/**
      @description 
      @param {Real} column	Column number of the cell
	  @param {Real} row		Row number of the cell
*/
function RemoveTile(column, row){
	terrain[# column, row][| TILE.TERRAIN] = 0;
}