
function Button(_sprite, _img,  _x, _y, _w, _h, _text, _func) constructor{
	
	sprite = _sprite;
	image = _img;
	x = _x;
	y = _y;
	w = _w;
	h = _h;
	text = _text;
	func = _func;
	
	width = x + w;
	height = y + h;
	
	Draw = function()
	{
		if (sprite != noone)
		draw_sprite_stretched(sprite, image, x, y, w, h);
		
		draw_set_align(fa_middle, fa_middle);
		draw_text_transformed(x + w/2, y + h/2, text, 0.8, 0.8, 0);
		draw_set_align(fa_left, fa_top);
		
		if (Hover())
		{
			draw_set_alpha(0.3)
			draw_roundrect_color_ext(x, y, x + w, y + h, 3, 3, c_gray,    c_gray, false)	
			draw_roundrect_color_ext(x, y, x + w, y + h, 3, 3, c_black,   c_black,   true)
			draw_set_alpha(1)
			
			if (mouse_check_button_pressed(mb_left))
			{
				func();	
			}
		}
	}
	
	Hover = function()
	{
		return point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + w, y + h);	
	}

}