/**
      @description  Returns mouse x coordinate snapped to a grid
      @param {bool} isometric Isometric view or 2D
	  @param {real} cell_size The dimensions of a cell
	  @param {real} tile_width The width of an isometric tile
	  @param {real} tile_height The height of an isometric tile
*/
function mouse_x_to_grid(isometric, cell_size, tile_width, tile_height){
	if (!isometric){
		// Get raw position	(2D)
		return floor(mouse_x / cell_size);
	} else{
		// Get raw position (ISO)
		return floor((mouse_x / tile_width)  + (mouse_y / tile_height));
	}
}


/**
      @description  Returns mouse y coordinate snapped to a grid
      @param {bool} isometric Isometric view or 2D
	  @param {real} cell_size The dimensions of a cell
	  @param {real} tile_width The width of an isometric tile
	  @param {real} tile_height The height of an isometric tile
*/
function mouse_y_to_grid(isometric, cell_size, tile_width, tile_height){
	if (!isometric){
		// Get raw position	(2D)
		return floor(mouse_y / cell_size);
	} else{
		// Get raw position (ISO)
		return floor((mouse_y / tile_height) - (mouse_x / tile_width ));
	}
}
