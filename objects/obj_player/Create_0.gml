//MOVIMETO
velh = 0;
velv = 0;
acel = 0.5
grav = 0
maxvel = 5;

//PLATAFORMA
chao = noone;


//CONTROLES
jump  = false;
left  = false;
right = false;
up    = false;
down  = false;


checa_chao = function (){
  
   if(place_meeting(x,y + 1, obj_colisor)) chao = true;
    else{
        chao = false;
    }
   if(place_meeting(x,y + 1, obj_boxx)) chao = true;
    
    
      if(!chao){
        grav = 0.2;
        velv += grav;
        
    }else {
    	grav = 0;
        velv = 0;
    }
        
}

pega_controle = function() {
    
    jump = keyboard_check(vk_space);
    left = keyboard_check(ord("A"));
    up = keyboard_check(ord("W"));
    down = keyboard_check(ord("S"));
    right = keyboard_check(ord("D"));
    action = keyboard_check(ord("E"))
}

plataforma = function (){
    checa_chao();
    pega_controle();
    velh = (right - left) * maxvel
    
    if(jump && chao)velv -= maxvel* 2;
   
    
    move_and_collide(velh,0,global.colisores,4);
    move_and_collide(0,velv,global.colisores,24);
    
}

empurra_caixa = function (){
     pega_controle();
    //detecta caixa na frente
    var _caixa = instance_place(x + velh,y,obj_boxx);
  
    if(!place_meeting(x,y+1, obj_boxx))
    {
        velv += grav
    }    
    else {
    	velv = 0
        grav = 0
        
        if(jump){
        velv -= maxvel* 2
    }}
    
if (_caixa != noone)
{
    //checando se a caixa pode se mexer
    if(!place_meeting(_caixa.x + _caixa.velh, _caixa.y + _caixa.velv, obj_colisor ))
    {
    
        // Verifica se a caixa pode se mover
        if(place_meeting(x + velh , y, obj_boxx) && place_meeting(x, y+1, obj_colisor) && _caixa.travado == false)
        {
            _caixa.velh = velh
        }
    
    }
    else{
        _caixa.velh = 0;
        velh = 0;
    }
        
   
      
    
}

    
}

quebra_porta =  function (){
    pega_controle();
    if(action){
    var _dir    = point_direction(x,y,x + velh,y)    
    var _hit_box = instance_create_layer(x + velh,y, "Instances", obj_hit);
    
    with (_hit_box) {
    	 var _porta = instance_place(x,y,obj_porta);
        if(_porta != noone) _porta.dura = 0;
        }
}
}