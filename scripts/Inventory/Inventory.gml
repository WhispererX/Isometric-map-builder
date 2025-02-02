/**

*/
function Inventory(_tile_sprite, _slot_sprite, _doctab_reference) constructor{
	
	tile_sprite	= _tile_sprite;
	doc			= _doctab_reference;
	
	width = sprite_get_width(tile_sprite);
	height = sprite_get_height(tile_sprite);
	
	// Create inventory array
	inventory = array_create(sprite_get_number(tile_sprite), 0);
	
	// Populate it
	for (var i = 0; i < sprite_get_number(tile_sprite); i++) {
	    inventory[i] = i + 1;
	}
	
	// Inventory properties
	row_length = 6;

	
	Draw = function()
	{	
		//row_length = max(floor((doc.anchor_w - doc.x - 32 * 2 ) / sprite_get_width(tile_sprite)), 1);
		
		for (var i = 0; i < sprite_get_number(tile_sprite); ++i) {
		    var item_x = doc.x + (i mod row_length) * 42 + 50 ;
			var item_y = doc.y + (i div row_length) * 42 + 50 ;
			
			if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), item_x - width/2, item_y - height/2, item_x + width /2, item_y + height/ 2))
			{
				draw_set_alpha(0.5);
				draw_roundrect(item_x - width/2, item_y - height/2, item_x + width /2, item_y + height/ 2, false)
				draw_set_alpha(1)
				
				if (mouse_check_button_pressed(mb_left))
				{
					IsometricRenderer.current_tile = i + 1;
				}
			}
			
			draw_sprite(tile_sprite, inventory[i], item_x, item_y)
		}	
	}
	
	Search = function(root_object, item_type)
	{
		for (var i = 0; i < sprite_get_number(tile_sprite); i++) {
		    if (root_object.inventory[i] == item_type)
			{
				return i;	
			}
		}	
	}
	Add = function(root_object, item_type)
	{
		var _slot = Search(root_object, 0);
		
		if (_slot != -1)
		{
			root_object.inventory[_slot] = item_type;
			return true;
		}
		else return false;
	}
	Remove = function(root_object, item_type)
	{
		var _slot = Search(root_object, item_type);
		if (_slot != -1)
		{
			root_object.inventory[_slot] = -1;
			return true
		}
		else return false;
	}
	Swap = function(object_from, slot_from, object_to, slot_to)
	{
		var _item_from = object_from.inventory[slot_from];
		
		object_from.inventory[slot_from] = object_to.inventory[slot_to];
		object_to.inventory[slot_to] =  _item_from;
	}
}