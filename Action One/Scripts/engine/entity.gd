extends KinematicBody2D

# Main entity object for living 'things' 

# Stats 
export var health = 1 

# Movement Vars 
export var GRAVITY = 20
export var JUMP_GRAVITY = 10 
export var move_speed = 1
export var jump_speed = 1
export var drag = 1.00
export var type = 'DEFAULT'

# Entity state 
var velocity = Vector2()
var motion = Vector2()  
var move_vec = Vector2()
var facing_direction = Vector2.RIGHT

var weakRef = weakref(self) 

func die(): 
	if(weakRef.get_ref() != null):
		queue_free() 
		
func take_damage(damage):
	health -= damage 
	if health <= 0 :
		die() 



