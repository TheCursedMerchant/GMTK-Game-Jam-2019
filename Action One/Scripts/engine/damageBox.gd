extends Area2D
 
# Controlled State 
export var move_speed = 0 
export var damage = 1
export var direction = Vector2(1, 0)
export var lifeTime = .5 
export var type = 'DEFAULT'

var snd_bullet_explosion_scene = preload('res://Scenes/Audio/SFX/snd_BulletExplode.tscn')

onready var animation_player = $AnimatedSprite

# State Variables 
var creator
var weakRef = weakref(self)
var timer = Timer.new() 

func _ready():
	if direction.x == 1:
		animation_player.flip_h = false
	else:
		animation_player.flip_h = true

func _physics_process(delta):
	animation_player.play('default')
	if direction.x == 1:
		animation_player.flip_h = false
	else:
		animation_player.flip_h = true
	global_position += move_speed * direction
	
func handle_collision(body):
	if(body != creator):
		if body.has_method('take_damage'):
			body.take_damage(damage) 
			if creator.get('type') == 'Player':
				creator.refresh()
				creator.emit_signal('shake')
			destroy()

func destroy():
	timer.stop()
	var sound = snd_bullet_explosion_scene.instance(0)
	sound.global_position = global_position
	get_tree().get_root().add_child(sound)
	if weakRef.get_ref() != null :
		queue_free() 
 
func _on_Melee_Attack_body_entered(body):
	handle_collision(body) 
	
func _on_Shoot_body_entered(body):
	handle_collision(body)

func _on_AnimatedSprite_animation_finished():
	destroy()
	
func _on_Melee_Attack_area_entered(area):
	if creator.get('type') == creator and area.get('type') == 'bullet' :
		creator.refresh() 
	queue_free()
