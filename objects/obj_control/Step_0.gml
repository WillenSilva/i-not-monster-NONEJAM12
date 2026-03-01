if(keyboard_check(ord("R"))) 
{
    audio_play_sound(snd_reset,1,false); room_restart();
}
checa_room();



if ( room_atual == rm_fase6) {
	layer_set_visible("UiLayer_2", true);
}
else
{
    layer_set_visible("UiLayer_2", false);
}