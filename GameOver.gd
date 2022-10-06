extends Sprite

func _process(_delta):
	if(visible):
		if(Input.is_action_just_pressed("ui_select")):
			get_tree().reload_current_scene()
