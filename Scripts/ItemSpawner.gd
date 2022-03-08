extends Node2D


signal TimerSpawnPoint()
signal GlassesSpawnPoint()

onready var spawnPoints = get_children()


func _ready():
	spawn_timer()
	spawn_glasses()


func spawn_timer():
	yield(get_tree().create_timer(15), "timeout")
	randomize()
	
	var spawnNodes = spawnPoints[randi() % spawnPoints.size()]
	spawnPoints.erase(spawnNodes)								#para outros items isso pode causar que spawnem mais de um no mesmo ponto; retomar!
	
	if spawnPoints.empty():
		spawnPoints = get_children()
	
	emit_signal("TimerSpawnPoint", spawnNodes)


func spawn_glasses():
	yield(get_tree().create_timer(2), "timeout")
	randomize()

	var spawnNodes = spawnPoints[randi() % spawnPoints.size()]
	spawnPoints.erase(spawnNodes)								#para outros items isso pode causar que spawnem mais de um no mesmo ponto; retomar!

	if spawnPoints.empty():
		spawnPoints = get_children()

	emit_signal("GlassesSpawnPoint", spawnNodes)
