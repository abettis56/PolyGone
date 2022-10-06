extends Node

onready var timer = $ChargeClock
onready var is_timer_running = false

#SProioOIOIONG
func execute(body):
	if(body.is_on_floor()):
		if(Input.is_action_just_pressed("ui_select")):
			#Check if we need to move back and forth, and then do so
			body.velocity.y = -body.JUMP_SPEED
			timer.stop()
			is_timer_running = false

		#Charge behavior
		if(Input.is_action_just_pressed("ui_down")):
			timer.start_charging(body)
		if(Input.is_action_just_pressed("ui_select")):
			if(timer.is_charged):
				body.velocity.y = -body.JUMP_SPEED*1.5
			timer.release(body)
		if(Input.is_action_just_released("ui_down")):
			timer.release(body)
		#if(Input.is_action_just_pressed("ui_down")):
		#	timer.start()
		#	is_timer_running = true
		#if(is_timer_running and Input.is_action_pressed("ui_down")):
		#	body.jump_charge = (timer.wait_time - timer.time_left) / (timer.wait_time*2)
		#	print(body.jump_charge)
		#elif(Input.is_action_just_released("ui_down")):
		#	body.jump_charge = 0
		#	timer.stop()
		#	is_timer_running = false
	else:
		timer._cancel_charging(body)

func break(body):
	timer._cancel_charging(body)
