/// @description 

#region Calculate Mouse position on the Grid

mouse_gx = mouse_x_to_grid(isometric, CELL_SIZE, tile_width, tile_height);
mouse_gy = mouse_y_to_grid(isometric, CELL_SIZE, tile_width, tile_height);

// Clamp it between 0 & maximum amount of cells
mouse_gx = clamp(mouse_gx, 0, rows	  - 1);
mouse_gy = clamp(mouse_gy, 0, columns - 1);
#endregion

#region Change Cell Index

// Increasing the index
if (keyboard_check_pressed(vk_right))
{
	if (!keyboard_check(vk_shift))
	{
		if (current_tile < sprite_get_number(tile_sprite) - 1)
		{
			current_tile++;	
		} else // Loop Back to the starting index
		{
			current_tile = 0;
		}
	}
	else
	{
		// If we are pressing shift, change tile type
		if (tile_type) <= TILE.DECORATION - 1
		{
			tile_type++;
		}
		else
		{
			tile_type = 0;	
		}
		tile_sprite = cell_sprites[tile_type];
		
		// Reset tile index
		current_tile = 1;
	}
}

// Decreasing the index
if (keyboard_check_pressed(vk_left))
{
	if (!keyboard_check(vk_shift))
	{
		if (current_tile > 0)
		{
			current_tile--;	
		} else // Loop Back to the starting index
		{
			current_tile = sprite_get_number(tile_sprite) - 1;
		}
	}
	else
	{
		// If we are pressing shift, change tile type
		if (tile_type) > 0
		{
			tile_type--;
		}
		else
		{
			tile_type = TILE.DECORATION;	
		}
		tile_sprite = cell_sprites[tile_type];
		
		// Reset tile index
		current_tile = 1;
	}
}
#endregion

#region Paint the world

if (mouse_check_button(mb_left)) && (global.GameWindowActive)
{
	PlaceTile(current_tile, tile_z, mouse_gx, mouse_gy);
}
#endregion

#region Move Camera

if (keyboard_check(ord("W"))) camera_y -= camera_speed;
if (keyboard_check(ord("S"))) camera_y += camera_speed;
if (keyboard_check(ord("A"))) camera_x -= camera_speed;
if (keyboard_check(ord("D"))) camera_x += camera_speed;

if ((keyboard_check(ord("W"))) || (keyboard_check(ord("A"))) || (keyboard_check(ord("S"))) || (keyboard_check(ord("D"))))
{
	camera_set_view_pos(view_camera[0], camera_x, camera_y);	
}
#endregion

#region Change the Height

if (!keyboard_check(vk_shift))
{
	if (mouse_wheel_up())
	{
		SetTileHeight(tile_z + 1);
	}

	if (mouse_wheel_down())
	{
		SetTileHeight(tile_z - 1);
	}
}
else
{
	if (mouse_wheel_up())
	{
		if (current_tile < sprite_get_number(tile_sprite) - 1)
		{
			current_tile++;	
		} else // Loop Back to the starting index
		{
			current_tile = 0;
		}
	}

	if (mouse_wheel_down())
	{
		if (current_tile > 0)
		{
			current_tile--;	
		} else // Loop Back to the starting index
		{
			current_tile = sprite_get_number(tile_sprite) - 1;
		}
	}	
}
#endregion

#region Toggle display_all_heights

if (keyboard_check_pressed(vk_tab))
{
	DisplayAllHeights(!display_all_heights);
}
#endregion

#region Toggle between 2D & Isometric

if (keyboard_check_pressed(vk_control))
{
	enable_isometric_view(!isometric)
	
	CenterCameraToGrid(isometric, view_camera[0], tile_width);
}
#endregion

#region Toggle between tile types
if (mouse_check_button_pressed(mb_right))
{
	tile_type = !tile_type;	
}
#endregion