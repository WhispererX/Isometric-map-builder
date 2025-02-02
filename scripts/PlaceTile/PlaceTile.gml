/**
      @description 
      @param {Real} tile_index	Image Index of the sprite that holds all tiles
	  @param {Real} height		The height of this tile
      @param {Real} column		Column number of the cell
	  @param {Real} row			Row number of the cell
*/
function PlaceTile(tile_index, height, column, row){
	terrain[# column, row][| tile_type   ]	= tile_index;	
	terrain[# column, row][| TILE.HEIGHT ]	= height;
}