destino = noone
xscale = image_xscale;
yscale = image_yscale;

xscale_t = xscale;
yscale_t = yscale;

checa_destino = function (){
    
    switch (destino) {
    	case "Jogar":
               room_goto(rm_fase0);
                layer_set_visible("UiLayer_1", 0)
            break;
        
        case "Sair":
                game_end();
            break;
    }
}