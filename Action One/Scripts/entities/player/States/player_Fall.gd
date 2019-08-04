extends "res://Scripts/engine/state.gd"

func get_name():
	return 'Fall'
	
func update(delta):
	
	# Apply Gravity 
	target.velocity.y += target.GRAVITY
	
	# Move while falling 
	target.check_move()
	
	# Check for mid air jumps 
	target.check_jump()
	
	if target.current_grounded:
		manager.set_state('Idle')
		
