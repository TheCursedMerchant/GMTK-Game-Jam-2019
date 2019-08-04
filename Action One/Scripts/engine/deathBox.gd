extends Area2D

func _on_DeathBox_body_entered(body):
	if body.has_method('die') :
		body.die()
