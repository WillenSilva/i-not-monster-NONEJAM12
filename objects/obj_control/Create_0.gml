
global.tempo = game_get_speed(gamespeed_fps);


vence_fase = function (){
    if (object_exists(obj_player)) {
    	if (obj_player.x > room_width or obj_player.x < 0) {
        	room_restart()
            show_message("venceu");
        }
        
    }
    
}