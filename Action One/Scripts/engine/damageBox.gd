extends Area2D
 
# Controlled State 

export var move_speed = 0 
export var damage = 1
export var direction = Vector2(1, 0)
export var lifeTime = .5 

onready var animation_player = $AnimatedSprite

# State Variables 
var creator
var weakRef = weakref(self)
var timer = Timer.new() 

#func _ready(): 
#	timer = Timer.new()
#	timer.set_one_shot(true)
#	timer.set_wait_time(lifeTime)
#	timer.connect("timeout", self, "on_timeout_complete")
#	add_child(timer)
#	timer.start() 
#
#func on_timeout_complete():
#	destroy()
	
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

func destroy():
	timer.stop()
	if weakRef.get_ref() != null :
		queue_free() 
 
func _on_Melee_Attack_body_entered(body):
	handle_collision(body) 
	
func _on_Shoot_body_entered(body):
	handle_collision(body)

func _on_AnimatedSprite_animation_finished():
	destroy()
