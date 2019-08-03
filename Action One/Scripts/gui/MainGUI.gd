extends Control

var player
onready var animation_player = $CenterContainer/AnimatedSprite

func update_gui():
	print('My animation player is: ', animation_player)
	if player != null : 
		if player.can_act :
			print('Setting active!') 
			animation_player.play('active') 
		else :
			print('Setting inactive!') 
			animation_player.play('inactive') 