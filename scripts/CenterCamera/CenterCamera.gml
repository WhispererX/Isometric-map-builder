/**
      @description 
      @param {Bool} isometric 
      @param {Id.camera}  camera 
	  @param {Real}	  tile_width
*/
function CenterCameraToGrid(isometric, camera, tile_width){
	if (isometric){
		camera_x = (tile_width / 2) - (camera_get_view_width(camera) / 2);
		camera_y = -(camera_get_view_height(camera) / 4);

		camera_set_view_pos(camera, camera_x, camera_y);	
	} else{
		camera_x = (tile_width / 2) - (camera_get_view_width(camera) / 3);
		camera_y = -(camera_get_view_width(camera) / 8)

		camera_set_view_pos(camera, camera_x, camera_y);	
	}
}