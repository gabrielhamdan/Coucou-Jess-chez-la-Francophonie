extends Position2D


onready var timerScene = load("res://Scenes/TimerUp.tscn")
onready var glassesScene = load("res://Scenes/GlassesUp.tscn")
var spawnPos


func _on_ItemSpawner_TimerSpawnPoint(spawnNodes):
	spawnPos = spawnNodes
	spawn_timer()

func spawn_timer():
	var timer = timerScene.instance()
	spawnPos.add_child(timer)
	timer.set_as_toplevel(true)
	timer.position = spawnPos.global_position


func _on_ItemSpawner_GlassesSpawnPoint(spawnNodes):
	spawnPos = spawnNodes
	spawn_glasses()


func spawn_glasses():
	var glasses = glassesScene.instance()
	spawnPos.add_child(glasses)
	glasses.set_as_toplevel(true)
	glasses.position = spawnPos.global_position
