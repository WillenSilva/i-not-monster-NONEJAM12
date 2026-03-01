//MOVIMETO
velh    = 0;
velv    = 0;
acel    = 0.5
grav    = 0
maxvel  = 2;
forc    = 4;

//PLATAFORMA
chao = noone;


//MAQUINA DE ESTADO
estado = noone
estado_txt = "parado";
tempo_humano = game_get_speed(gamespeed_fps) * 3;
sou_humano = tempo_humano
human = false;

//CONTROLES
jump  = false;
left  = false;
right = false;
up    = false;
down  = false;
action = false;
agacha = false;
face = 0;

//ANIMAÇÃO E SPRITES
sprites = [
     //SPRITE PARADO 
    [spr_player_idle,spr_player2_idle],
    //SSPRITE ANDANDO 
    [spr_player_andando,spr_player2_andando],
    //SPRITE AGACHADO
    [0,spr_player_agachado],
    //SPRITE PULANDO
    [spr_player_idle,spr_player2_idle],
    //SPRITE TRANFORMAÇÃO
    [spr_player_idle,spr_player2_idle],
    //SPRITE ataque
    [spr_player_ataque]
                                    ];
sprite  = noone

#region //MECANICAS E FUNÇÕES

controla_sprite = function (_index){
    //muda a sprite de acordo com o estado
    //variaveis de controle
    var _spr_modo = human
    
    if (velh > 0) {
        face = 0
    }
    else {
    	face = 1
    }
     
        
    sprite = sprites[_index,_spr_modo]
    
    sprite_index = sprite;
    if(face = 0) image_xscale = 1; 
        if(face = 1) image_xscale = -1;
}

checa_chao = function (){
  
    
    //if (place_meeting(x,y,obj_colisor))
        //{
    	 //
        //}
    //
   if(place_meeting(x,y + 1, obj_colisor)) chao = true;
    else{
        chao = false;
    }
   if(place_meeting(x,y + 1, obj_boxx)) chao = true;
    
    
      if(!chao){
        grav = 0.4;
        velv += grav;
        
    }else {
    	grav = 0;
        velv = 0;
    }
        
}

pega_controle = function() {
    
    jump    = keyboard_check_pressed(vk_space);
    left    = keyboard_check(ord("A"));
    up      = keyboard_check(ord("W"));
    down    = keyboard_check(ord("S"));
    right   = keyboard_check(ord("D"));
    action  = keyboard_check(ord("J"))
    agacha  = keyboard_check_pressed(ord("K"))
}

plataforma = function (){
    checa_chao();
    pega_controle();
    
    velh = (right - left) * maxvel
    
    if(jump && chao && human) {
        
        velv -= maxvel * forc; 
        audio_play_sound(snd_jump,1,false);
         estado = pulando; 
    }
    if (agacha && human && chao) estado = agachado;
    
    
    if (!human) {
        move_and_collide(velh,0,global.colisores,24);
        move_and_collide(0,velv,global.colisores,24);
    }
    else { 
        move_and_collide(velh,0,global.allobj,24);
        move_and_collide(0,velv,global.allobj,24);
    }
}

empurra_caixa = function (){
     
    //detecta caixa na frente
    var _caixa = instance_place(x + velh,y,obj_boxx);
    
    if(!place_meeting(x,y+1, obj_boxx))
    {
        velv += grav
    }    
    else {
    	velv = 0
        grav = 0
        
        }
    
if (_caixa != noone)
{
        // MOVENDO A CAIXA SE ELA NÃO ESTIVER TRAVADA, E EU FOR UM MONSTRO
        if(place_meeting(x + velh, y, obj_boxx) && place_meeting(x, y+1, obj_colisor) && _caixa.travado == false && !human)
        {
            _caixa.velh = velh
        }
}
}

quebra_porta =  function (){
    pega_controle();
    
    if(action and !human){
    var _dir    = point_direction(x,y,x + velh,y)    
    var _hit_box = instance_create_layer(x,y - 32, "Instances", obj_hit); 
    if (right = 0) _hit_box.image_xscale = 1;
    if (left= 1) _hit_box.image_xscale = -1;
        
    with (_hit_box) {
    	 var _porta = instance_place(x,y,obj_porta);
        if(_porta != noone) {
            _porta.x += lengthdir_x(10,_dir);
            _porta.dura = 30;
            _porta.levei = true;
            
        }
        
        }
}
}

coleta_antidoto = function (){
    var _anti = instance_place(x, y, obj_antidoto)
    
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
            if (!place_meeting(x,y - 10, obj_colisor)) {
            velh  = 0;
            human = false;
            sou_humano = tempo_humano;
                
            }else {
                audio_play_sound(snd_reset,1,false); 
            	room_restart();
            }
        }
    }
}

#endregion

#region //MAQUINA DE ESTADO

parado = function (){
    
    //CORPO ESTADO
    estado_txt = "parado"
    velh = 0;
    controla_sprite(0);
    coleta_antidoto();
    checha_tranformado();
    empurra_caixa();
    quebra_porta()
    plataforma();
    
    //SAIDA ESTADO
    if(left or right ) estado = andando;
    if(jump && human ){
        audio_play_sound(snd_jump,1,false); 
        estado = pulando;
    }
}

andando = function (){
    
    //CORPO ESTADO
    estado_txt = "andando"
    controla_sprite(1);
    coleta_antidoto();
    checha_tranformado();
    empurra_caixa();
    quebra_porta()
    plataforma();
    
    //SAIDA ESTADO
    if(velh == 0 )estado = parado;
        
}

pulando = function (){
    
    //CORPO ESTADO
    estado_txt = "pulando"
    controla_sprite(0);
    coleta_antidoto();
    checha_tranformado();
    plataforma();
    
    //SAIDA ESTADO
    if(chao) estado = parado;
}

agachado = function (){
    
    //CORPO ESTADO
    estado_txt = "agachado"
    controla_sprite(2);
    plataforma();
    checha_tranformado();
    
    //SAIDA ESTADO
    if (agacha) {
    	estado = parado;
    }
    if(jump) {
        audio_play_sound(snd_jump,1,false); 
        estado = pulando;
    }
    if (!human) {
    	estado = parado;
    }
    
}

transforma = function (){
    
    //CORPO ESTADO
    estado_txt = "transforma"
    controla_sprite(5);
    audio_play_sound(snd_jump,1,false); 
    velh = 0;
    //animação de transformação
    // ao fim dela  human = true
    //inicia cronometro
    // pode andar
    //pode pular
    //SAIDA ESTADO
     if (fim_da_animacao()) {
    	human = true;
        estado = parado;
    }
}

estado = parado;

#endregion