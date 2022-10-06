extends KinematicBody2D

const SPEED = 100
onready var velocity = 1
onready var health = 3

func _physics_process(delta):
	if(health <= 0):
		die()
	
	var collide = move_and_collide(Vector2(SPEED*velocity*delta, 0))
	if(collide != null):
		velocity = -1*velocity

func deal_damage(damage):
	health -= damage
	$hitsound.play()
	
func die():
	$diesound.play()
	call_deferred("queue_free")
