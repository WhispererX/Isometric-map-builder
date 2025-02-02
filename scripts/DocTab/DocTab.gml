function DocTab(_x, _y, _w, _h, _style = 0) constructor
{
	x = _x;
	y = _y;
	w = _w;
	h = _h;
	
	
	anchor_x = x;
	anchor_y = y;
	anchor_h = y + h;
	anchor_w = x + w;
	
	smallest_size = 25;
	
	style = _style;
	
	header = -1;
	name = "";
	
	locked = true;
	
	Draw = function(header_sprite = undefined, header_image = undefined)
	{	
		// Body
		draw_sprite_stretched(spr_window_background, style, x, y, w, h)
			
		// Header
		DrawHeader(header_sprite, header_image)
		
		// Name
		draw_set_align(fa_left, fa_top);
		draw_text(x + 15, y, name)
		draw_set_align(fa_left, fa_top);
		
	}
	
	Debug = function()
	{
		draw_rectangle(x, y, x + w, y + h, true)	
	}
	
	SetHeader = function(name = "", thickness = 25)
	{
		self.header = new DocTab(x, y, w, thickness, 3);	
		self.header.name = name;
	}
	
	GetLength = function() 
	{
		return x + w;	
	}
	
	GetHeight = function()
	{
		return y + h;
	}	
	
	DrawHeader = function(sprite = spr_tab, image = 0)
	{
		if (header == -1) exit;
		
		static thickness = header.y - y;
			
		header.x = x;
		header.w = w;
		header.y = y + thickness;
			
		header.Draw();
		
		if (header.name == "") && (sprite_get_width(sprite) < header.x + header.w)
		draw_sprite(sprite, image, header.x, header.y);
	}
	
	MouseOver = function(side, collision_width = 25, device = 0)
	{
		var pointed = 0;
		switch(side)
		{
			case "fa_top":		pointed = point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device), x, y, x + w, y + collision_width);			break;
			case "fa_left":		pointed = point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device), x, y, x + collision_width, y + h);			break;
			case "fa_right":	pointed = point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device), x + w - collision_width, y, x + w, y + h);		break;
			case "fa_bottom":	pointed = point_in_rectangle(device_mouse_x_to_gui(device), device_mouse_y_to_gui(device), x, y + h - collision_width, x + w, y + h);	break;
		}
		return pointed;
	}
	
	///@func Drag
	///@param side fa_top fa_bottom fa_left fa_right
	Drag = function(side, max_w = 0, max_h = 0, device = 0)
	{
		
		if (self.MouseOver(side))
		{
			if (side == "fa_top" || side == "fa_bottom")
			{
				window_set_cursor(cr_size_ns);
			} else window_set_cursor(cr_size_we);
			
			if mouse_check_button_pressed(mb_left)
			if mouse_check_button(mb_left)
			{
				self.locked = false;
			}
		}// else if (all_locked) { window_set_cursor(cr_default); }
		
		 if mouse_check_button_released(mb_left)
		{
			self.locked = true;
		}
		
		
		if (self.locked == false)
		{		
			switch(side)
			{
				case "fa_top":		
				{
					self.h  = anchor_h;
					self.y  = clamp(device_mouse_y_to_gui(device), anchor_y - max_h, anchor_h - smallest_size);
				} break;
				case "fa_bottom":
				{
					self.h = clamp(device_mouse_y_to_gui(device), smallest_size, anchor_h + max_h); 
				} break;
				case "fa_right":
				{
					self.w = clamp(device_mouse_x_to_gui(device), smallest_size, anchor_w + max_w); 
				} break;
				case "fa_left":
				{
					self.w = anchor_w;
					self.x = clamp(device_mouse_x_to_gui(device), anchor_x - max_w, anchor_w - smallest_size);			 
				} break;
			}
		}
	}
}



