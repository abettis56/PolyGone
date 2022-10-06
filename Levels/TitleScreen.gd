extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var next_scene = preload("res://Levels/Level_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/MusicPlayer".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_select")):
		get_tree().change_scene_to(next_scene)
