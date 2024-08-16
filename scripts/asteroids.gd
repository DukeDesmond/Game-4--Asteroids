extends RigidBody2D
@onready var asteroids_Main = $"."
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
var rng = RandomNumberGenerator.new()
var life : int = 12
var thrust : float = 25
const Utils = preload("res://scripts/Utils/Utils.gd")
var size = Utils.AsteroidSize.BIG

signal on_asteroid_destroyed(AsteroidScale, asteroid_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	if size == Utils.AsteroidSize.MEDIUM:
		animated_sprite_2d.scale = (Vector2(3,3))
		collision_shape_2d.scale = (Vector2(3,3))
		thrust = thrust * 10
		life = 6
		
	elif size == Utils.AsteroidSize.SMALL:
		animated_sprite_2d.scale = (Vector2(2,2))
		collision_shape_2d.scale = (Vector2(2,2))
		thrust = thrust * 10
		life = 3
		
	rng.randomize()
	apply_central_impulse(Vector2(0, -1).rotated(rng.randi_range(0,2 * PI)) * thrust)

func _physics_process(delta):
	var screen_size = self.get_viewport_rect().size
	
	if self.global_position.y < 0:
		self.global_position.y = screen_size.y
	elif self.global_position.y > screen_size.y:
		self.global_position.y = 0
		
	if self.global_position.x < 0:
		self.global_position.x = screen_size.x
	elif self.global_position.x > screen_size.x:
		self.global_position.x = 0


func damage():
	#animation_player.play("hit_flash")
	if life != 0:
		life -= 1
		animation_player.play("hit_flash")
	elif life == 0:
		collision_shape_2d.set_deferred("disabled", true)
		animated_sprite_2d.play("explosion")
		

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "explosion":
		var new_asteroid_size = size + 1
		on_asteroid_destroyed.emit(global_position, new_asteroid_size)
		queue_free()
  

func _on_area_2d_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()
