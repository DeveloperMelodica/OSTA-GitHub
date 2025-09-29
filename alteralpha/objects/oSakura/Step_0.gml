right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

//Movement
xspd = (right_key - left_key) * move_spd;
yspd = (down_key - up_key) * move_spd;

//Collision
if place_meeting(x+xspd, y, oWall){
    xspd = 0;
}
if place_meeting(x, y+yspd, oWall){
    yspd = 0;
}

if place_meeting(x+xspd, y, oWall2){
    xspd = 0;
}
if place_meeting(x, y+yspd, oWall2){
    yspd = 0;

}
//Animate
if xspd > 0 {
	sprite_index = sSakuraRight;
} else if xspd < 0 {
	sprite_index = sSakuraLeft;
} else if yspd > 0 {
	sprite_index = sSakuraDown;
} else if yspd < 0 {
	sprite_index = sSakuraUp;
}
if(xspd != 0 or yspd != 0){
	image_speed = 1;
} else {
	image_speed = 0;
	image_index = 0;
}

x += xspd
y += yspd