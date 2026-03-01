float_time = current_time / 2

y = base_y + sin(current_time * float_speed) * float_height;

image_xscale = 0.5;
image_yscale = 0.5;

image_angle = sin(current_time * float_speed) * float_height;



show_debug_message(float_time)