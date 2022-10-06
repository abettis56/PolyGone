extends Node2D

const RECOIL = 300

onready var timer = $Timer

func setup(body):
	body.gun.set_visible(true)

func execute(body):
	body.gun.look_at(get_global_mouse_position())
	body.gun.update_beam_sprite(body)
	if(Input.is_action_just_pressed("fire")):
		body.gun.fire(body)
		timer.start_charging(body)
	if(Input.is_action_just_released("fire")):
		if(timer.is_charged):
			body.gun.fire_beam(body)
			# handle Recoil
			var direction = Vector2.RIGHT
			direction = direction.rotated(body.gun.rotation)
			#direction = -1*direction
			body.velocity -= direction*RECOIL
			timer.release(body)
		else:
			timer._cancel_charging(body)

func break(body):
	body.gun.set_visible(false)
	timer._cancel_charging(body)
