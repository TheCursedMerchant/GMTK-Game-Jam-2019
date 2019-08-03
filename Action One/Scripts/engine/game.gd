extends Node

export var spawn_point_path : NodePath 
onready var spawn_point = get_node(spawn_point_path)

var camera_scene = preload('res://Scenes/Game/MainCamera.tscn') 
var player_scene = preload('res://Scenes/Player/Player.tscn')

var camera
var player
var main_gui 

func _ready():
	spawn_player()
	spawn_camera() 
	
func spawn_player():
	if(spawn_point != null):
		player = player_scene.instance(0) 
		player.global_position = spawn_point.global_position 
		player.connect('act', self, '_on_act') 
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

