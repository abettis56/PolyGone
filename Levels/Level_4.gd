extends Node2D

onready var player = preload("res://Player.tscn")
onready var move_component = preload("res://Components/RollComponent.tscn")
onready var jump_component = preload("res://Components/JumpComponent.tscn")
onready var gun_component = preload("res://Components/GunComponent.tscn")
onready var spawn_point = $SpawnPoint

onready var next_scene = preload("res://Levels/Level_5.tscn")

func _ready():
	add_child(player.instance())
	
	var move = move_component.instance()
	var jump = jump_component.instance()
	var gun = gun_component.instance()
	gun.setup($Player)
	$Player.add_child(move)
	$Player.ui.to_break = "mid"
	$Player.add_child(jump)
	$Player.add_child(gun)
	$Player.setup(spawn_point.position, [null, jump, gun])
	#jump_component, move_component])

func player_died():
	get_parent().reset_level()


func _on_Goal_body_entered(body):
	get_tree().change_scene_to(next_scene)
