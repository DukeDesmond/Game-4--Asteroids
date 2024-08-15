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


var reload : bool = false
var muzzle1Position
var muzzle2Position
var velocity = Vector2.ZERO
var speed= 400.0
var bullet = preload("res://scenes/bullet.tscn")
var life: int = 4
var angular_speed: float = 5.0

var thrust : float = 100
var torque = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	
	muzzle1Position = muzzle1.position
	muzzle2Position = muzzle2.position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# Handle shooting.
	if Input.is_action_pressed("ui_accept") and reload == false:
		playerShoot()
		reload = true
		reload_timer.start(0.15)

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == 1:
		#player.rotate(direction * angular_speed * delta)
		apply_torque(torque * direction)
	elif direction == -1:
		#player.rotate(direction * angular_speed * delta)
		apply_torque(torque * direction)
		
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(0, -1).rotated(rotation) * thrust * delta)

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
	

