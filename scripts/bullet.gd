extends CharacterBody2D

var speed : int = 250


@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.play()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2(0, -1).rotated(rotation) * speed * speed * delta
	move_and_slide()
	
func _on_visible_notifier_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("damage"):
		body.damage()
		queue_free()
		
