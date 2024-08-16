extends Node
@onready var scores = $Scor
@onready var waves = $Wave

var score = 0
var wave = 1

func add_point(multiplier : int = 1):
	score += 100 * multiplier
	scores.text = "Score: " + str(score)
func add_wave():
	wave += 1
	waves.text = "Wave: " + str(wave)
	
