extends Node
@onready var scores = $Score
@onready var waves = $Wave
@onready var highscores = $Highscore
@onready var restart = $Restart
@onready var start = $Start


var score = 0
var wave = 1
var highscore = 0

func _ready():
	highscores.text =""
	restart.hide()
	if Global.status == false:
		Engine.time_scale = 0
	else:
		start.hide()
	
func add_point(multiplier : int = 1):
	score += 100 * multiplier
	scores.text = "Score: " + str(score)
	
func add_wave():
	wave += 1
	waves.text = "Wave: " + str(wave)

func add_highscore():
	highscore += score
	Global.save_highscore(highscore)
	highscores.text = "High Score: " + str(Global.get_highscore())
	restart.show()


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_start_pressed():
	Global.status = true
	Engine.time_scale = 1
	start.hide()
