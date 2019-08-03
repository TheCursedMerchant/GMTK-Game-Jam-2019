extends 'res://Scripts/engine/entity.gd'

# Scenes 
var melee_scene = preload('res://Scenes/Attacks/Melee_Attack.tscn')
var ranged_scene = preload('res://Scenes/Attacks/Bullet.tscn')

# Children 
onready var state_manager = $State_Manager
onready var animation_player = $AnimatedSprite

# Controlled State
export var jump_buffer = .25 

# State Vars
var current_grounded
var last_grounded 
var pressed_jump 
var time_pressed_jump 
var time_left_ground = 0
var can_act = true 

# Attacking 
export var melee_loc = Vector2()
export var ranged_loc = Vector2() 

# Signals 
signal act 

func _process(delta):
	animation_player.play(state_manager.current_state.get_name())
	
func _physics_process(delta):
	
	if can_act:
		if Input.is_action_just_pressed('melee'):
			attack('Melee')
		elif Input.is_action_just_pressed('shoot'):
			attack('Shoot')
			
	
	# Set these at the start of the frame 
	current_grounded = is_on_floor()
	move_vec = Vector2()
	
	# Apply State
	state_manager.update(delta)
	
	# Apply any changes to motion. Physics Yay! 
	velocity += move_vec * move_speed - drag * Vector2(velocity.x, 0) 
	# velocity += get_floor_velocity()
	motion = move_and_slide(velocity, Vector2.UP)
	last_grounded = current_grounded

func get_cur_time():
	return OS.get_ticks_msec() / 1000.0
	
func check_move():
	if Input.is_action_pressed('ui_right') :
		facing_direction = Vector2.RIGHT
		move_vec.x += 1
	elif Input.is_action_pressed('ui_left') :
		facing_direction = Vector2.LEFT
		move_vec.x -= 1
	
func check_jump():
	# Track if we pressed jump and when we pressed it 
	pressed_jump = Input.is_action_pressed('ui_up')
	if pressed_jump :
		time_pressed_jump = get_cur_time()
		
	# Jumping
	if can_act :
		if pressed_jump and current_grounded:
			state_manager.set_state('Jump')
		elif !last_grounded and current_grounded and get_cur_time() - time_pressed_jump < jump_buffer:
			state_manager.set_state('Jump')
		elif pressed_jump and get_cur_time() - time_left_ground < jump_buffer:
			state_manager.set_state('Jump')
		
		
func attack(type):
	var current_attack
	var loc  

	can_act = false 
	emit_signal('act')
	
	match type:
		'Melee':
			current_attack = melee_scene.instance(0) 
			loc = melee_loc 
		'Shoot':
			current_attack = ranged_scene.instance(0) 
			loc = ranged_loc 
	
	current_attack.direction = facing_direction
	current_attack.creator = self
	current_attack.global_position = global_position + loc * facing_direction
	get_tree().get_root().add_child(current_attack)
	
	