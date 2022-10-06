extends Sprite

onready var next_scene = preload("res://Levels/ToastScene.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene_to(next_scene)
