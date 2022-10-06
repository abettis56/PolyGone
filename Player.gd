extends KinematicBody2D

const GRAVITY = 400
const SPEED = 40
const JUMP_SPEED = 250
const MAX_JUMP_SPEED = 2*JUMP_SPEED
const MAX_SPEED = 200
const FRICTION = 30

onready var jump_charge = 0
onready var velocity = Vector2.ZERO

onready var gun = $Gun
onready var bullet_spawn = $Gun/BulletSpawn.position
onready var animation_player = $AnimationPlayer

onready var ui = $UI

var components

var delta

func setup(_position, 
		_components):
	components = _components
	for component in components:
		if component != null and component.has_method("setup"):
			component.setup(self)
	self.set("position", _position)
	if(components[0] != null):
		ui.activate_chip("top")
	if(components[1] != null):
		ui.activate_chip("mid")
	if(components[2] != null):
		ui.activate_chip("bot")
	
func _physics_process(_delta):
	#if(Input.is_action_pressed("reset")):
	#	die()
	
	if($GameOver.visible):
		return
	delta = _delta
	for component in components:
		if(component != null):
			component.execute(self)
		
	#If in air, we can freely move left and right
	#NOTE: This is literally the code from RollComponent. Duplication bad, I'm in a hurry
	if(!is_on_floor()):
		#Check if we need to move back and forth, and then do so
		velocity.x += (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*SPEED

		
	#Move
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#Handle gravity
	velocity.y += GRAVITY * delta
	velocity.y = clamp(velocity.y, -MAX_JUMP_SPEED, MAX_JUMP_SPEED)
	
	#Handle friction
	if(is_on_floor()):
		if(velocity.x < FRICTION and velocity.x > -FRICTION):
			velocity.x = 0
		elif(velocity.x > 0):
			velocity.x -= FRICTION
		elif(velocity.x < 0):
			velocity.x += FRICTION
	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

	#Cleanup: Reset x to 0 in case RollComponent pops while it's active
	#velocity.x = 0
	
func die():
	components[0] = null
	components[1] = null
	components[2] = null
	velocity = Vector2.ZERO
	ui.break_all()
	$GameOver.set_visible(true)
	#get_tree().reload_current_scene()


func _on_Hurtbox_body_entered(area):
	die()


func _on_UI_time_over():
	for i in range(components.size()):
		if components[i] != null:
			components[i].break(self)
			components[i] = null
			break
	for component in components:
		if component != null:
			return
	die()
