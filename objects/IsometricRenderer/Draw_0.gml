/// @description Draw Isometric World
for (var column = 0; column < columns; column++) {
    for (var row = 0; row < rows; row++) {
		
		#region Draw Each Cell
		
		// Retreave cell data
		var cell_data = terrain[# column, row];
		// Get tile index for this cell
		var tile_index	= cell_data[| TILE.TERRAIN];
		// Get tile height for this cell
		var cell_height = cell_data[| TILE.HEIGHT];
		
		if (!isometric)
		{
			// 2D position of the cell
			var cell_x = column * CELL_SIZE;
			var cell_y = row	* CELL_SIZE;
		
			// Drawing 2D tiles
			draw_sprite(spr_2D_terrain_tiles, tile_index, cell_x, cell_y);
		}
		
		if (isometric)
		{
			// ISO cell x position
			var cell_x = (column - row) * (tile_width  / 2);
			// ISO cell y position
			for (var cell_z = 0; cell_z <= cell_height; cell_z++) {
			
				if (!display_all_heights && cell_z <= tile_z) || (display_all_heights)
				{
					// Calculate y position
				    var cell_y = (column + row) * (tile_height / 2) - (cell_z * (tile_height / 2))
			
					// Change the color of the tile based on it's height
					var rgb = 150 + (cell_z * 9);
					var color = make_color_rgb(rgb, rgb, rgb);
			
					// Draw as many tiles as there are height for this cell
					draw_sprite_ext(cell_sprites[TILE.TERRAIN], tile_index, cell_x, cell_y, 1, 1, 0, color, 1);
			
					// Draw decorations
					if (cell_z == cell_height)	// If current tile is the highest one
					{
						var sprite = cell_sprites[TILE.DECORATION];
						var index  = cell_data[| TILE.DECORATION];
						draw_sprite_ext(sprite, index, cell_x, cell_y, 1, 1, 0, color, 1);
					}
				}
			}
		}
		
		
		
		#region Debugging
		if (debug_enabled) 
		{
			// Center / Middle for ISO ---- Top / Left for 2D
			if (isometric)
			{
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
			}
			draw_text(cell_x, cell_y, $"{tile_index}");
			
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
		}
		#endregion
		
		#endregion
		
		#region Draw Cursor
		
		if (column == mouse_gx) && (row == mouse_gy) && (global.GameWindowActive)
		{
			if (!isometric)
			{
				// 2D Cursor
				draw_sprite(spr_2D_tile_cursor, 0, cell_x, cell_y);
				
				current_cell_height = cell_height;
			}
			
			if (isometric)
			{
				current_cell_height = cell_height;
				// ISO Cursor
				for (var cursor_z = 0; cursor_z <= tile_z; cursor_z++) {
				    cell_y = (column + row) * (tile_height / 2) - (cursor_z * (tile_height / 2))
					draw_sprite(spr_ISO_tile_cursor, 0, cell_x, cell_y);
				}
			}
		#region Draw a blueprint for decoration editing
				
			if (tile_type == TILE.DECORATION) && (isometric)
			{
				var sprite = cell_sprites[tile_type];
				draw_sprite_ext(sprite, current_tile, cell_x, cell_y, 1, 1, 0, c_yellow, 1)
			}
			#endregion
		}
		#endregion
	}
}
