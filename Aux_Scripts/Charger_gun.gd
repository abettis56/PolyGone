extends Timer

onready var is_charged = false
onready var signal_flag = true
var _body
	
func start_charging(body):
	_body = body
	start()
	body.gun.animation_player_gun.play("charging_fire")
	if(!is_connected("timeout", self, "on_Timer_timeout") and signal_flag):
		signal_flag = false
		connect("timeout", self, "_on_Timer_timeout")
	
func _cancel_charging(body):
	stop()
	body.gun.animation_player_gun.play("idle")
	is_charged = false
	if(is_connected("timeout", self, "on_Timer_timeout")):
		signal_flag = true
		disconnect("timeout", self, "on_Timer_timeout")
		
func release(body):
	if(is_charged):
		is_charged = false
		body.gun.animation_player_gun.play("fire")
	else:
		_cancel_charging(body)
	
func _on_Timer_timeout():
	is_charged = true
