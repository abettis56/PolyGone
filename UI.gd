extends Control

onready var to_break = "top"

signal time_over

func activate_chip(position):
	match(position):
		"bot":
			_activate($ChipSet/ControlBot2,
					$SlotSet/ControlBot/AnimationPlayer,
					"bot")
		"mid":
			_activate($ChipSet/ControlMid2,
					$SlotSet/ControlMid/AnimationPlayer,
					"mid")
		"top":
			_activate($ChipSet/ControlTop2,
					$SlotSet/ControlTop/AnimationPlayer,
					"top")
			
func _activate(chip, animator, pos):
	chip.visible = true
	if pos == to_break:
		animator.play("red")
	else:
		animator.play("green")
		
func _break(chip, animator):
	chip.visible = false
	animator.play("dead")
	
func break_all():
	_break($ChipSet/ControlTop2,
			$SlotSet/ControlTop/AnimationPlayer)

	_break($ChipSet/ControlMid2,
			$SlotSet/ControlMid/AnimationPlayer)

	_break($ChipSet/ControlBot2,
			$SlotSet/ControlBot/AnimationPlayer)
			
	$Timer/AnimationPlayer.stop()

func next_to_break():
	match(to_break):
		"top":
			_break($ChipSet/ControlTop2,
					$SlotSet/ControlTop/AnimationPlayer)
			to_break = "mid"
			activate_chip(to_break)
		"mid":
			_break($ChipSet/ControlMid2,
					$SlotSet/ControlMid/AnimationPlayer)
			to_break = "bot"
			activate_chip(to_break)
		"bot":
			_break($ChipSet/ControlBot2,
					$SlotSet/ControlBot/AnimationPlayer)
			to_break = "top"
			activate_chip(to_break)

func _on_AnimationPlayer_animation_finished(anim_name):
	print("CALLED FUNC")
	$Timer/AnimationPlayer.play("timer")
	next_to_break()
	emit_signal("time_over")
