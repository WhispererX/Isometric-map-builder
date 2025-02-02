/// @description Properties

#region Create a Grid

// Setup variables for world size
columns	= 20;
rows	= 20;

globalvar terrain;
terrain = ds_grid_create(columns, rows);

// Populate the grid
for (var column = 0; column < columns; column++) {
    for (var row = 0; row < rows; row++) {
	
		// Create a list for each cell
		var cell_data = ds_list_create();
		
		// Set initial cell data for each list
		for (var data_type = 0; data_type < TILE.LAST; data_type++) {
			cell_data[| data_type] = data_type == TILE.TERRAIN ? 72 : 0
		}
		
		// Save the list pointer in the grid cell
		terrain[# column, row] = cell_data;
	}
}
#endregion

#region Sprite Array

globalvar cell_sprites;
cell_sprites[TILE.TERRAIN]		= spr_terrain;
cell_sprites[TILE.DECORATION]	= spr_decoration;
#endregion

// Mouse position on the grid
mouse_gx = 0;
mouse_gy = 0;

//	Used to change tile index
current_tile = 1;

tile_width	= sprite_get_width(spr_ISO_mask);
tile_height	= sprite_get_height(spr_ISO_mask);

// Initializing height variables
tile_z = 0;
tile_max_z = 12;

// Sprite Management
tile_type	= TILE.TERRAIN;
tile_sprite = cell_sprites[tile_type];

//
display_all_heights = true;

// Toggle between 2D & ISO
isometric = true;

// Used to draw current height for 2D
draw_current_height = false;


// Informational variables for display
current_cell_height = 0;

#region Camera

camera_speed = 2;

// Shifting camera to the middle of the room
camera_x = (tile_width / 2) - (camera_get_view_width(view_camera[0]) / 2);
camera_y = -(camera_get_view_height(view_camera[0]) / 4);

camera_set_view_pos(view_camera[0], camera_x, camera_y);
#endregion

#region Docs
OutputDoc = -1;

global.GameWindowActive = true;

// ➽───────────────❥ Output ➽───────────────❥
output_log = [];
array_push(output_log, $">  GMSC serialisation:  SUCCESSFUL LOAD AND LINK TIME: {current_time}ms");
array_push(output_log, $">  Loaded Project: Isometric world editor")
array_push(output_log, $"#  Resolution {camera_get_view_width(view_camera[0])}x{camera_get_view_height(view_camera[0])}");
array_push(output_log, $"#  Grid size {columns}x{rows}");
array_push(output_log, $"#  Cell size {CELL_SIZE}x{CELL_SIZE}");
array_push(output_log, $"#  Tile size {tile_width}x{tile_height}");