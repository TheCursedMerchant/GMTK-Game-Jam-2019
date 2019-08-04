extends "res://Scripts/engine/state.gd"

func get_name(): 
	return 'Move' 
	
func update(delta):
	# Apply Gravity 
	target.velocity.y += target.GRAVITY
	
	target.check_move()
	
	target.check_jump()
	
	if !( Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_left') ):
		manager.set_state('Idle')
	
	# Check if we are on the ground 
	if !target.current_grounded:
		manager.set_state('Fall')