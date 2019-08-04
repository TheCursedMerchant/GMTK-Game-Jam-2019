extends Area2D

export var travel_distance = 100 
export var travel_speed = 5
export var travel_direction = 1 
export var mover = false 

onready var particle_scene = preload('res://Scenes/Player/Death Particle.tscn')
onready var pick_up_clip = preload('res://Scenes/Audio/SFX/snd_Pick_Up.tscn')
onready var audio_player = $AudioStreamPlayer2D

var origin_loc = Vector2() 
var distance_travelled = 0

func _ready():
	origin_loc = global_position

func _on_SkillPellet_body_entered(body):
	if body.get('type') == 'Player' :
		body.refresh()
		var particle = particle_scene.instance(0) 
		var sound = pick_up_clip.instance(0)
		sound.global_position = global_position
		particle.global_position = global_position
		particle.emitting = true
		particle.one_shot = true 
		get_tree().get_root().add_child(particle)
		get_tree().get_root().add_child(sound)
		queue_free()

func _physics_process(delta): 
	
	if mover :
		distance_travelled = global_position.x - origin_loc.x
		
		if distance_travelled >= travel_distance :
			travel_direction = -1
		elif distance_travelled <= 0 :
			travel_direction = 1
			
		global_position += Vector2( travel_speed * travel_direction, 0) 