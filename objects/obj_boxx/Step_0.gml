if (!place_meeting(x + velh,y, obj_player)) velh = 0;
if (!place_meeting(x,y, obj_player)) velv = 0;
    
if (place_meeting(x + velh,y, obj_colisor)) travado = true;
    

move_and_collide(velh,0,obj_colisor,12);
move_and_collide(0,velv,obj_colisor,12);


show_debug_message(show_debug_message(travado));
