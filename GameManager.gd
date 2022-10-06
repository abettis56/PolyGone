extends Node2D

onready var test_level_res = preload("res://TestLevel.tscn")
var current_level_res
var current_level

func _ready():
	current_level_res = test_level_res
	var test_level = current_level_res.instance()
	add_child(test_level)
	
func change_levels(level_res):
	current_level_res = level_res
	var new_level = current_level_res.instance()
	var old_level = current_level
	if(old_level != null):
		old_level.call_deferred("queue_free")
	add_child(new_level)
