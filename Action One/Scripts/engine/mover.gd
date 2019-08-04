extends KinematicBody2D

export var travel_speed = 5
export var travel_distance = 100
export var travel_direction = Vector2.UP 
var origin_loc = Vector2()   
var distance_travelled
var motion = Vector2() 
var velocity = Vector2() 

func _ready():
	origin_loc = global_position

func _physics_process(delta):
	distance_travelled = global_position.distance_to(origin_loc)
		
	if distance_travelled >= travel_distance or distance_travelled <= 0  :
		travel_direction *= -1 
		
	velocity = travel_speed * travel_direction
	motion = move_and_slide(velocity, Vector2.UP) 
