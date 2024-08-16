extends Node
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var status = false
var highscore : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.play()

func save_highscore(score):
	if score > highscore:
		highscore = score
	else:
		pass
		
func get_highscore() -> int:
	return highscore
	
