extends Node

# Defined States 
export (Array, NodePath) var state_paths
var states = [] 

# Store States 
var previous_state 
var current_state 

# Entity info 
onready var target = get_parent()

# Initialize 
func _ready():
	# Create states from paths 
	initialize_states(state_paths)
	
	if states.size() > 0 :
		current_state = states[0] 
		set_state(current_state.get_name())

# Defer our physics process to our state 
func update(delta):
	current_state.update(delta) 

# Change state based on state name 
func set_state(state_name):
	var next_state = find_state(state_name)
	
	if current_state != next_state:
		
		if current_state.saved :
			previous_state = current_state
		
		if current_state.has_method('exit') :	
			current_state.exit()
			
		current_state = next_state
		next_state.enter()
		print(current_state.get_name())

# Initialize our states array 
func initialize_states(state_paths):
	for state in state_paths :
		 states.append(get_node(state))
	previous_state = states[0] 

# Return a state object based on name 
func find_state(state_name):
	var index = 0
	if(states.size() > 0):
		for state in states:
			if state.get_name() == state_name:
				return states[index]
			else :
				index += 1