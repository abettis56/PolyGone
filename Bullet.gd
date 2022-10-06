extends Area2D

const SPEED = 300
var _direction

func setup(direction):
	_direction = direction

func _physics_process(delta):
	if(_direction != null):
		set_position(position + (_direction.normalized()*SPEED*delta))

func _on_Bullet_body_entered(body):
	if(body.is_in_group("Player")):
		return
	elif(body.is_in_group("Immune")):
		_direction = -1*_direction
		$Sprite.set_flip_h(true)
		return
	
	if(body.has_method("deal_damage")):
		body.deal_damage(1)
	
	call_deferred("queue_free")
