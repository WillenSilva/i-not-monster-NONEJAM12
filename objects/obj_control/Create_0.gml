global.allobj = [obj_boxx,obj_colisor,obj_porta]
global.colisores = [obj_colisor,obj_porta]
global.menu = layer_get_visible("UiLaiyer_1");
room_atual = noone
gpu_set_texfilter(false);

checa_room = function() {
    room_atual = room
    
    switch (room_atual) {
    	case rm_menu:
             //desenha_menu()
            break
        case rm_fase0:
             vence_fase()
            break
        case rm_fase1:
             vence_fase()
            break
        case rm_fase2:
             vence_fase()
            break
        case rm_fase3:
             vence_fase()
            break
        case rm_fase4:
             vence_fase()
            break
        case rm_fase5:
             vence_fase()
            break
        case rm_fase6:
             vence_fase()
            break
        case rm_fase7:
             vence_fase()
            break
        case rm_fase8:
             vence_fase()
            break
        case rm_fase9:
             vence_fase()
            break
        case rm_fase10:
             vence_fase()
            break
    }
    
}
 
desenha_menu = function (){
    
   
    
    var _w = room_width;
    var _h = room_height;
    var _marg = 30 ;
    var _scale = 1
    var _botons = ["COMEÇAR","CREDITOS"]
    var _botons_tam = array_length(_botons)
    //posição
   
    var _mx = mouse_x;
    var _my = mouse_y
    
    for (var i = 0; i < _botons_tam; i++) {
    	    var _xx = _marg
            var _yy = _h / 2 + (_marg * (i +1))
        
        draw_set_font(Fnt_menu)
        
            draw_rectangle(_marg,_yy + _marg, _marg + 300,_yy + _marg + 30 ,true)
        
            draw_text_transformed(_marg,_yy + _marg, _botons[i], _scale,_scale,0)
         
        draw_set_font(-1)
        
        if (m_x ) {
        	
        }
    }
    
    
}

vence_fase = function (){
    if (object_exists(obj_player)) {
    	if (obj_player.x > room_width or obj_player.x < 0) {
        	room_restart()
            show_message("venceu");
        }
        
    } else {
        
    }
    
}