extends Control

var player
onready var animation_player = $CenterContainer/AnimatedSprite

func update_gui():
	if player != null : 
		if player.can_act :
			animation_player.play('active') 
		else :
			animation_player.play('inactive') 