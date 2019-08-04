extends Node

export var spawn_point_path : NodePath 
onready var spawn_point = get_node(spawn_point_path)

var camera_scene = preload('res://Scenes/Game/MainCamera.tscn') 
var player_scene = preload('res://Scenes/Player/Player.tscn')

var camera
var player
var main_gui 
var timer = Timer.new()
var death_delay = 1.0  

func _ready():
	spawn_player()
	spawn_camera() 
	timer.set_one_shot(true)
	timer.set_wait_time(death_delay)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
func spawn_player():
	if(spawn_point != null):
		player = player_scene.instance(0) 
		player.global_position = spawn_point.global_position 
		player.connect('act', self, '_on_act')
		player.connect('player_died', self, '_on_player_dead') 
		player.connect('shake', self, '_on_shake')
		add_child(player)
	else: 
		print('No Spawn Point found!')
		
func spawn_camera():
	if(player != null):
		camera = camera_scene.instance(0)
		camera.player = player
		main_gui = camera.get_node('HUD/MainGUI')
		main_gui.player = player 
		add_child(camera) 
	else:
		print('No Player!')
		
func _on_act():
	main_gui.update_gui()
	
func reset():
	get_tree().reload_current_scene()
	
func _process(delta):
	if Input.is_action_just_pressed('reset'):
		reset()
		
func _on_player_dead(): 
	camera.follow = false 
	camera.shake(0.5, 30, 8)
	timer.start()

func _on_shake():
	print('Shake!')
	camera.shake(0.5, 15, 8)

func on_timeout_complete():
	reset()

