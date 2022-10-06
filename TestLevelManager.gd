extends Node2D

onready var player = preload("res://Player.tscn")
onready var move_component = preload("res://Components/RollComponent.tscn")
onready var jump_component = preload("res://Components/JumpComponent.tscn")
onready var gun_component = preload("res://Components/GunComponent.tscn")
onready var spawn_point = $SpawnPoint

func _ready():
	add_child(player.instance())
	
	var move = move_component.instance()
	var jump = jump_component.instance()
	var gun = gun_component.instance()
	gun.setup($Player)
	$Player.add_child(move)
	$Player.add_child(jump)
	$Player.add_child(gun)
	$Player.setup(spawn_point.position, [move, jump, gun])
	#jump_component, move_component])

func player_died():
	get_parent().reset_level()
