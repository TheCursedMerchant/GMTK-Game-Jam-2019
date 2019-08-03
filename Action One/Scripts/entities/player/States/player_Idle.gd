extends 'res://Scripts/engine/state.gd'

func get_name():
	return 'Idle'
	
func update(delta): 

	# Apply Gravity 
	target.velocity.y += target.GRAVITY
	
	# Enter the move state on input 
	if Input.is_action_pressed('ui_right') :
		target.facing_direction = Vector2.RIGHT
		manager.set_state('Move')
	elif Input.is_action_pressed('ui_left') :
		target.facing_direction = Vector2.LEFT 
		manager.set_state('Move')
		
	# Jump 
	target.check_jump()
	
	# Check if we are on the ground 
	if !target.current_grounded:
		manager.set_state('Fall')
		
	#Clamp falling velocity 
	if target.velocity.y > 10:
		target.velocity.y = 10
