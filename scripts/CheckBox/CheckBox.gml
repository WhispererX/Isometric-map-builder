/**
      @description  
*/
function CheckBox(_text, _doctab_reference,  _enabled_by_default = false, _func = function(){ show_debug_message("Clicked")}) constructor{
	
	sprite = spr_window_checkbox;
	
	text = _text;
	func = _func;
	doc  = _doctab_reference;
	
	enabled = _enabled_by_default;
	
	// Count checkboxes
	static count = 0;
	count++;
	
	id = count;
	
	x_offset = 5;
	y_offset = 32;
	
	text_offset = 35;
	
	Draw = function()
	{
		// Update coordinates
		x = doc.x + x_offset;
		y = doc.y + y_offset * id;
		
		// Draw checkbox
		draw_sprite(sprite, enabled, x, y);
		
		// Draw outline
		if (Hover())
		{
			draw_sprite(sprite, 2, x, y);
			
			if (mouse_check_button_pressed(mb_left))
			{
				enabled = !enabled;
				func();
			}
		}
		
		// Draw text
		var _text = text;
		var char_width = string_width("W");
		var max_chars = round((doc.w - doc.x - text_offset) / char_width);
		
		// Fold & Expand the text
		if (string_length(_text) > max_chars - 1)
		{
			_text = string_copy(_text, 0, max_chars - 1);
		}
		
		
		draw_text(x + text_offset, y, _text);
	}
	
	Hover = function( device = 0 )
	{
		return point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device), x, y, x + sprite_get_width(sprite), y + sprite_get_height(sprite));
	}
}