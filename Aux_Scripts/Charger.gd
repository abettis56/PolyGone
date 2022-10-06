extends Timer

onready var is_charged = false
var _body
	
func start_charging(body):
	_body = body
	start()
	body.animation_player.play("charging_jump")
	connect("timeout", self, "_on_Timer_timeout")
	
func _cancel_charging(body):
	stop()
	body.animation_player.play("idle")
	is_charged = false
	if(is_connected("timeout", self, "on_Timer_timeout")):
		disconnect("timeout", self, "on_Timer_timeout")
		
func release(body):
	if(is_charged):
		is_charged = false
		body.animation_player.play_backwards("charging_jump")
		yield(body.animation_player, "animation_finished")
		body.animation_player.play("idle")
	else:
		_cancel_charging(body)
	
func _on_Timer_timeout():
	is_charged = true
	_body.animation_player.play("charged_jump")
