extends RigidBody2D
@onready var asteroids_Main = $"."

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d_collision = $Area2D/area2dCollision
@onready var animation_player = $AnimationPlayer
var rng = RandomNumberGenerator.new()
var life : int = 10
var thrust : float = 20
var asteroids = preload("res://scenes/asteroids.tscn")
var asteroidsInstance1
var asteroidsInstance2
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	apply_central_impulse(Vector2(0, -1).rotated(rng.randi_range(0,2 * PI)) * thrust)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	pass # Replace with function body.

func damage():
	#animation_player.play("hit_flash")
	if life != 0:
		life -= 1
	elif life == 0:
		life -= 1
		area_2d_collision.disabled = true
		collision_shape_2d.disabled = true
		#direction =  Vector2(0,0)
	#	get_tree().call_group("score", "add_score500")
	#	audio_stream_player_2d.play()
		animated_sprite_2d.play("explosion")
		

func _on_animated_sprite_2d_animation_finished():
		if animated_sprite_2d.animation == "explosion":
			queue_free()
		#	asteroidsInstance1 = asteroids.instantiate() as RigidBody2D
		#	asteroidsInstance2 = asteroids.instantiate() as RigidBody2D
		#	asteroidsInstance1.global_position = muzzle1.global_position
		#	asteroidsInstance2.global_position = muzzle2.global_position

		#	get_parent().add_child(bulletInstance1)
		# 	get_parent().add_child(bulletInstance2)
  
