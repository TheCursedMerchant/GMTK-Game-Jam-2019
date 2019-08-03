extends Node

# Parent Class to all states 
# All methods should be overriden 

onready var manager = get_parent()
onready var target = get_parent().get_parent()

export var saved = false

func get_name():
	return 'Default'
	
func enter():
	return  
	
func update(delta): 
	return 
	
func exit():
	return 
