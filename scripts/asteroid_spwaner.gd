extends Node2D

@export var GameManager : Node
var asteroids = preload("res://scenes/asteroids.tscn")
const Utils = preload("res://scripts/Utils/Utils.gd")
@onready var asteroid_spawn_path = $AsteroidPath/AsteroidSpawnPath

@export var count : int = 3
var win : int = count

func _ready():
	for i in range(count):
		var random_spawn_position = get_random_position_from_screen_react()
		spawn_asteroid(random_spawn_position, Utils.AsteroidSize.BIG)
		
		
func get_random_position_from_screen_react() -> Vector2:
	asteroid_spawn_path.progress = randi_range(0,2569)
	var screen_position = asteroid_spawn_path.global_position
	return screen_position
	

func spawn_asteroid(spawn_position: Vector2, size: Utils.AsteroidSize = Utils.AsteroidSize.BIG ):
	var asteroidsInstance = asteroids.instantiate()
	asteroidsInstance.global_position = spawn_position
	get_tree().root.add_child.call_deferred(asteroidsInstance)
	asteroidsInstance.on_asteroid_destroyed.connect(asteroid_destroyed)
	asteroidsInstance.size = size


func asteroid_destroyed(position : Vector2, size: Utils.AsteroidSize):
	if (size <= 2):
		GameManager.add_point(size + 1)
		for i in range(2):
			spawn_asteroid(position, size)
	else:
		win -= 1
