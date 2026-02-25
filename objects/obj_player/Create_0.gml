//MOVIMETO
velh = 0;
velv = 0;
acel = 0.5
grav = 0
maxvel = 5;

//PLATAFORMA
chao = noone;

//MAQUINA DE ESTADO
estado = noone
estado_txt = "parado";
tempo_humano = game_get_speed(gamespeed_fps) * 5
sou_humano = tempo_humano
human = false;

//CONTROLES
jump  = false;
left  = false;
right = false;
up    = false;
down  = false;


#region //MECANICAS E FUNÇÕES

checa_chao = function (){
  
    
    if (place_meeting(x,y,obj_colisor))
        {
    	 room_restart();
        }
    
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
    agacha = keyboard_check(ord("G"))
}

plataforma = function (){
    checa_chao();
    pega_controle();
    velh = (right - left) * maxvel
    
    if(jump && chao && human)velv -= maxvel* 2;
        
     if (agacha && human && chao) estado = agachado;
    
    move_and_collide(velh,0,global.colisores,24);
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
    bbox_right
    
    //checando se a caixa pode se mexer
    if(!place_meeting(_caixa.x + _caixa.velh, _caixa.y + _caixa.velv, obj_colisor ))
    {
    
        // MOVENDO A CAIXA SE ELA NÃO ESTIVER TRAVADA, E EU FOR UM MONSTRO
        if(place_meeting(x, y, obj_boxx) && place_meeting(x, y+1, obj_colisor) && _caixa.travado == false)
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
    if(action and !human){
    var _dir    = point_direction(x,y,x + velh,y)    
    var _hit_box = instance_create_layer(x + velh,y, "Instances", obj_hit);
    
    with (_hit_box) {
    	 var _porta = instance_place(x,y,obj_porta);
        if(_porta != noone) _porta.dura = 0;
        }
}
}

coleta_antidoto = function (){
    var _anti = instance_place(x + velh, y + 1, obj_antidoto)
    
    if (_anti and !human) {
    	with (_anti) {
            instance_destroy(id)
        }
        estado = transforma;
    }
    
}

checha_tranformado = function (){
    if (human == true) {
    	sou_humano--;
        
        if(sou_humano <= 0){
            sprite_index = spr_monstro;
            human = false;
            sou_humano = tempo_humano;
            
        }
         
    }
    else {
    	sprite_index = spr_player
    }
    
    
}

#endregion

#region //MAQUINA DE ESTADO

parado = function (){
    
    //CORPO ESTADO
    estado_txt = "parado"
    velh = 0;
    plataforma();
    coleta_antidoto();
    checha_tranformado();
    empurra_caixa();
    
    
    //SAIDA ESTADO
    if(left or right ) estado = andando;
    if(jump && human) estado = pulando;
}

andando = function (){
    
    //CORPO ESTADO
    estado_txt = "andando"
    plataforma();
    coleta_antidoto();
    checha_tranformado()
    empurra_caixa();
    
    //SAIDA ESTADO
    if(velh == 0 )estado = parado;
        if(jump and human) estado = pulando;
}

pulando = function (){
    
    //CORPO ESTADO
    estado_txt = "pulando"
    plataforma();
    coleta_antidoto();
    checha_tranformado()
    empurra_caixa();
    
    //SAIDA ESTADO
    if(chao) estado = parado;
}

agachado = function (){
    
    //CORPO ESTADO
    estado_txt = "agachado"
    sprite_index = spr_player_agachado
    plataforma();
    checha_tranformado();
    
    //SAIDA ESTADO
    
    if (!human or agacha) {
    	estado = parado;
    }
    
}

transforma = function (){
    
    //CORPO ESTADO
    estado_txt = "transforma"
    sprite_index = spr_monstro;
    //animação de transformação
    // ao fim dela  human = true
    //inicia cronometro
    // pode andar
    //pode pular
    human = true;
    
    //SAIDA ESTADO
    estado = parado;
}

estado = parado;

#endregion