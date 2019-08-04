extends "res://Scripts/engine/entity.gd"

onready var animation_player = $AnimatedSprite

var collision

func die():
	animation_player.play('die')

func _on_AnimatedSprite_animation_finished():
	if animation_player.animation == 'die':
		queue_free() 
		
func _physics_process(delta):
	
	if animation_player.animation != 'die':
		collision = move_and_collide(Vector2())
		
		if collision : 
			if collision.get_collider().get('type') == 'Player':
				collision.get_collider().take_damage(1)
				die()
