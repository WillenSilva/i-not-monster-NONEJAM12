//MOVIMETO
velh = 0;
velv = 0;
acel = 0.5
grav = 0.2
maxvel = 5;

//PLATAFORMA



//CONTROLES
jump  = false;
left  = false;
right = false;
up    = false;
down  = false;


checa_chao = function (){
    chao = place_meeting(x,y + 1, obj_colisor);
}

pega_controle = function() {
    
    jump = keyboard_check(vk_space);
    left = keyboard_check(ord("A"));
    up = keyboard_check(ord("W"));
    down = keyboard_check(ord("S"));
    right = keyboard_check(ord("D"));
}

plataforma = function (){
    
    pega_controle();
    velh = (right - left) * maxvel
    
   
    
    if(!chao)
    {
        velv += grav
    }    
    else {
    	velv = 0
        
        if(jump){
        velv -= maxvel
    }
    }
    
     
    move_and_collide(velh,0,obj_colisor,4);
    
    move_and_collide(0,velv,obj_colisor);
    
    
    show_debug_message(velv)
}

