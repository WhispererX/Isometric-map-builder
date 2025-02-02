/// @description 

/// @description 
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Coordinates for game window border
var border_x1, border_x2, border_y1, border_y2;

// Top header
var _margin = 0;
draw_sprite_stretched(spr_window_background, 2, 0 + _margin, 0, gui_w - _margin * 2, 25)


// Create doc tabs / panels
if (OutputDoc == -1)
{
OptionsDoc = new DocTab(0, 25, 300, gui_h, 1);
OptionsDoc.SetHeader("");
	
InspectorDoc = new DocTab(gui_w - 300, 25, 300, 300, 1);
InspectorDoc.SetHeader("");
	
InventoryDoc = new DocTab(gui_w - 300, 300, 300, gui_h - 300, 1);
InventoryDoc.SetHeader("");

OutputDoc = new DocTab(300, gui_h - 225, gui_w - 600, 225, 1);
OutputDoc.SetHeader("");

// Inventory
Inv = new Inventory(tile_sprite, spr_window_background, InventoryDoc)

// Window Buttons
File	= new Button(noone, 0, 0 , 0, 75, 25, "File", undefined);
Edit	= new Button(noone, 0, File.width , 0, 75, 25, "Edit", undefined);
Build	= new Button(noone, 0, Edit.width, 0, 75, 25, "Build", undefined);
Help	= new Button(noone, 0, Build.width , 0, 75, 25, "Help", undefined);

// Checkboxes
ToggleHeights = new CheckBox("Display All Layers", OptionsDoc, true);
ToggleHeights.func = function() { display_all_heights = ToggleHeights.enabled }

InvertCameraMovement  = new CheckBox("Invert Camera Movement", OptionsDoc);
InvertCameraMovement.func = function()  { camera_speed = -camera_speed }

ToggleDebug = new CheckBox("Enable Debugging", OptionsDoc);
ToggleDebug.func = function() { debug_enabled = ToggleDebug.enabled }

DrawHeight = new CheckBox("Display current height when in 2D perspective", OptionsDoc)
DrawHeight.func = function() { draw_current_height = DrawHeight.enabled }

EnableIsometric = new CheckBox("Enable isometric view", OptionsDoc, true)
EnableIsometric.func = function() { enable_isometric_view(EnableIsometric.enabled)}


// Tools
Camera = new Button(spr_icon_isometric, 0, 0, 0, 50, 50, "", undefined)

}

if OptionsDoc.locked && InspectorDoc.locked && InventoryDoc.locked && OutputDoc.locked 
{
	window_set_cursor(cr_default);	
}

OptionsDoc.Draw(undefined, 3);
OptionsDoc.Drag("fa_right", 830);

// Checkboxes
ToggleHeights.Draw();
InvertCameraMovement.Draw();
ToggleDebug.Draw();
DrawHeight.Draw();
EnableIsometric.Draw();
/////

InspectorDoc.Draw(undefined, 2);
InspectorDoc.Drag("fa_left", 200);

#region Draw Selected Tile

// Position
var padding = 150;
var draw_x = max(InspectorDoc.x + (gui_w - InspectorDoc.x) / 2, InspectorDoc.x + padding)  //+ padding;
var draw_y = max(InspectorDoc.GetHeight()/2, InspectorDoc.y + 70)

// Drawing Scale
var scale = 4;

var sprite = cell_sprites[tile_type];

draw_sprite_ext(sprite, current_tile, draw_x, draw_y + tile_type * 16, scale, scale, 0, c_white, 1);

// For Debugging Purposes
draw_set_halign(fa_middle)
draw_text(draw_x, draw_y + 100, $"{tile_type == TILE.TERRAIN ? "Terrain" : "Decorations"}")
draw_set_halign(fa_left)
#endregion

InventoryDoc.Draw(undefined, 1);
InventoryDoc.Drag("fa_top", undefined, 250);

Inv.tile_sprite = cell_sprites[tile_type];
Inv.Draw();

// Draw current Height
if (draw_current_height) && (!isometric)
{
	draw_sprite_ext(spr_ruler, tile_z, OptionsDoc.x + OptionsDoc.w, max(OutputDoc.y, sprite_get_height(spr_ruler)), 1, 1, 0, c_white, 1)
}

OutputDoc.Draw(undefined, 0);
OutputDoc.Drag("fa_top", undefined, 830);


// Linking!
OutputDoc.x = OptionsDoc.GetLength();
OutputDoc.anchor_w = InspectorDoc.x;
OutputDoc.w = OutputDoc.anchor_w - OutputDoc.x;



InventoryDoc.x = InspectorDoc.x;
InventoryDoc.w = InspectorDoc.w;

InspectorDoc.h = InspectorDoc.y + InventoryDoc.y;

// Output Log
for (var i = 0; i < array_length(output_log); i++) {
    draw_set_color(c_ltgray);
	draw_text_transformed(OutputDoc.x + 5, OutputDoc.y + 20 + 14 * (i + 1), output_log[i], 0.8, 0.8, 0);
	draw_set_color(c_white);
	
}

// Draw Window Buttons
File.Draw();
Edit.Draw();
Build.Draw();
Help.Draw();


// Game Border
border_y1 = OptionsDoc.y
border_x1 = OptionsDoc.w;
border_x2 = InspectorDoc.x;
border_y2 = OutputDoc.y;

Camera.x = border_x2 - Camera.width - 16;
Camera.y = border_y1 + 16;
Camera.sprite = isometric ? spr_icon_isometric : spr_icon_2D;
Camera.func = function() { enable_isometric_view(!isometric) };
Camera.Draw();


if (border_y2 - border_y1) > 1
draw_roundrect_color_ext(border_x1, border_y1, border_x2, border_y2, 0, 0, c_white, c_white, 1)


#region Cell Coordinates
// Header for cell coordinates
var _width	= 200;
var _height = 25;

var __x = (border_x2 + border_x1) / 2
draw_sprite_stretched(spr_window_background, 3, __x - _width / 2, 25, _width, _height)

border_y1 = _height

// Properties
var _input_h = 15;					// Box sprite's that will display values, height
var _input_w = 30;					// Box sprite's that will display values, width
var _input_offset = -10;			// Box's horizontal offset
var _text_offset = -10;				// Text like x,  y, z, horizontal offset
var _value_offset = -15;			// Value horizontal offset
var _distance = (_input_w + 20);	// Distance between boxes

draw_set_halign(fa_middle);

// x
draw_text(__x - _width / 2 + _distance * 1 + _input_offset + _text_offset, _height, "x")
draw_sprite_stretched(spr_window_background, 1, __x - _width / 2 + _distance * 1 + _input_offset, _height * 1.5 - _input_h / 2, _input_w, _input_h)
draw_text(__x - _width / 2 + _distance * 1 + _input_offset - _value_offset, _height + 2, IsometricRenderer.mouse_gx)


// y
draw_text(__x - _width / 2 + _distance * 2 + _input_offset + _text_offset, _height, "y")
draw_sprite_stretched(spr_window_background, 1, __x - _width / 2 + _distance * 2 + _input_offset, _height * 1.5 - _input_h / 2, _input_w, _input_h)
draw_text(__x - _width / 2 + _distance * 2 + _input_offset - _value_offset, _height + 2, IsometricRenderer.mouse_gy)

// z
draw_text(__x - _width / 2 + _distance * 3 + _input_offset + _text_offset, _height, "z")
draw_sprite_stretched(spr_window_background, 1, __x - _width / 2 + _distance * 3 + _input_offset, _height * 1.5 - _input_h / 2, _input_w, _input_h)
draw_text(__x - _width / 2 + _distance * 3 + _input_offset - _value_offset, _height + 2, IsometricRenderer.current_cell_height)
#endregion



global.GameWindowActive = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), border_x1, border_y1, border_x2, border_y2) && (window_get_cursor() == cr_default);


