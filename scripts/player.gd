extends RigidBody2D

@onready var player = $"."
@onready var main_ship = $mainShip
@onready var weapons = $mainShip/weapons
@onready var engine = $mainShip/engine
@onready var engine_effect = $mainShip/engine/engineEffect
@onready var animation_player = $AnimationPlayer
@onready var muzzle1 :Marker2D = $mainShip/weapons/Muzzle1
@onready var muzzle2 :Marker2D = $mainShip/weapons/Muzzle2
@onready var reload_timer = $reloadTimer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var collision_shape_2d = $CollisionShape2D


var reload : bool = false
var muzzle1Position
var muzzle2Position
var velocity = Vector2.ZERO
var speed= 500.0
var bullet = preload("res://scenes/bullet.tscn")
var life: int = 4
var thrust : float = 100
var torque = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	muzzle1Position = muzzle1.position
	muzzle2Position = muzzle2.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _physics_process(delta):
	#var player_facing_direction = Vector2(cos(player.rotation), sin(player.rotation))
	#var direction_to_mouse = player.global_position.direction_to(get_global_mouse_position())
	#var angle = player_facing_direction.angle_to(direction_to_mouse)
	#print(rad_to_deg(angle))
	
	look_at((get_global_mouse_position()))
	
	# Handle shooting.
	if (Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_click_left")) and reload == false:
		playerShoot()
		apply_central_impulse(Vector2(-1, 0).rotated(rotation) * thrust * delta * 5)
		reload = true
		reload_timer.start(0.15)
		


	#If you want to run the game on keyboard, use these fuctions
	#Doesn't work together with look_at()
	#var direction = Input.get_axis("ui_left", "ui_right")
	
	#if direction == 1:
	#	player.rotate(direction * angular_speed * delta)
	#	apply_torque(torque * direction * 100)
	#elif direction == -1:
	#	player.rotate(direction * angular_speed * delta)
	#	apply_torque(torque * direction * 100)
		
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("Mouse_click_right"):
		apply_central_impulse(Vector2(1, 0).rotated(rotation) * thrust * delta)
		if engine_effect.animation == "stationary":
			engine_effect.play("flight")
	else:
		engine_effect.play("stationary")




func playerShoot ():
	var bulletInstance1 = bullet.instantiate() as Node2D
	var bulletInstance2 = bullet.instantiate() as Node2D
	bulletInstance1.global_position = muzzle1.global_position
	bulletInstance1.global_rotation = muzzle1.global_rotation
	bulletInstance2.global_position = muzzle2.global_position
	bulletInstance2.global_rotation = muzzle2.global_rotation
	get_parent().add_child(bulletInstance1)
	get_parent().add_child(bulletInstance2)
	
func _on_reload_timer_timeout():
	reload = false
	
		
func player_damage():
	if animation_player.assigned_animation == "immunity_frames":
		pass
		
	elif life == 4:
		life -= 1
		main_ship.play("damage1")
		audio_stream_player_2d.play()
		animation_player.play("immunity_frames")
		
	elif life == 3:
		life -= 1
		main_ship.play("damage2")
		audio_stream_player_2d.play()
		animation_player.play("immunity_frames")
		
	elif life == 2:
		life -= 1
		main_ship.play("damage3")
		audio_stream_player_2d.play()
		animation_player.play("immunity_frames")
		
	else:
		weapons.visible = false
		engine.visible = false
		engine_effect.visible = false
		speed = 0
		audio_stream_player_2d.stream = load("res://assets/Enprimer Spaceship SFX/wave/explosion/explosion12.wav")
		audio_stream_player_2d.play()
		main_ship.play("death")
		collision_shape_2d.set_deferred("disabled", true)
		



func _on_animation_player_animation_finished(anim_name):
	animation_player.play('RESET')
