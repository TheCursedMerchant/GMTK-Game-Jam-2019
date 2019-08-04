extends "res://Scripts/engine/state.gd"

func get_name():
	return 'Jump'
	
func enter():
	var sound = target.snd_jump_scene.instance(0)
	sound.global_position = target.global_position
	get_tree().get_root().add_child(sound)
	target.can_act = false 
	target.emit_signal('act')
	target.time_left_ground = target.get_cur_time()
	target.velocity.y = -target.jump_speed
	
func update(delta):
	
	# Apply Jump Gravity 
	target.velocity.y += target.JUMP_GRAVITY 
	
	# Check for mid air jumps 
	target.check_jump()
	
	# Move logic 
	target.check_move() 
	
	if target.velocity.y > 0 || Input.is_action_just_released('ui_up'):
		manager.set_state('Fall') 
	
	
