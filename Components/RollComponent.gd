extends Node

#Wheels on the cube go round and round....

func execute(body):
	if(body.is_on_floor()):
		#Check if we need to move back and forth, and then do so
		body.velocity.x += (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*body.SPEED

func break(body):
	pass
