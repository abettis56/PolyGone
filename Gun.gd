extends Node2D

signal fire

const LASER_MAX_DISTANCE = 2000

onready var gun_pivot = $GunPivot
onready var bullet = preload("res://Bullet.tscn")
onready var bullet_set = $BulletSet
onready var laser_beam = $GunPivot/BeamCast
onready var laser_sprite = $GunPivot/BeamSprite
onready var damage_area = $GunPivot/DamageArea/CollisionShape2D
onready var animation_player_gun = $AnimationPlayerGun

func fire(body):
	if(bullet_set.get_children().size() < 3):
		var new_bullet = bullet.instance()
		new_bullet.set_rotation(self.rotation)
		var direction = get_global_mouse_position() - body.position
		new_bullet.set_position(direction.normalized() * 20 + body.position)
		new_bullet.setup(direction)
		bullet_set.add_child(new_bullet)
		animation_player_gun.stop()
		animation_player_gun.play("fire")
		emit_signal("fire")

func fire_beam(body):
	var distance = update_beam_sprite(body)
	laser_sprite.set_visible(true)
	$AnimationPlayer.play("fire_beam")
	damage_area.shape.extents.x = distance / 2
	damage_area.position.x = distance / 2
	$GunPivot/DamageArea.monitoring = true
	animation_player_gun.stop()
	animation_player_gun.play("fire")
	emit_signal("fire")
	
func update_beam_sprite(body):
	var distance = LASER_MAX_DISTANCE
	var collision = laser_beam.get_collider()
	if(collision != null):
		distance = gun_pivot.global_position.distance_to(laser_beam.get_collision_point())
	laser_sprite.region_rect.end.x = distance
	return distance

func _on_DamageArea_body_entered(body):
	if(body.is_in_group("Player")):
		return
	
	if(body.has_method("deal_damage")):
		body.deal_damage(5)

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "fire_beam"):
		laser_sprite.visible = false
		$GunPivot/DamageArea.monitoring = false
