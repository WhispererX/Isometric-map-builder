/**
      @description 
      @param {bool} _bool 
*/
function enable_isometric_view(_bool){
	isometric = _bool
	CenterCameraToGrid(isometric, view_camera[0], tile_width)
}