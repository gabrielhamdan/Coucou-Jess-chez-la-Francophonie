extends Node2D


signal spawnPoint()

onready var game = get_parent()
onready var spawnPoints = get_children()
#var nodeName
const ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j','k','l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v','x','y','w','z']
var letter


func _ready():
	game.connect("spawn", self, "spawn_letters")


func spawn_letters():
	randomize()
#	var spawned = []
#	var repeated
	
	get_tree().call_group("spawnPos", "clear_children")
	yield(get_tree().create_timer(1), "timeout")
	
	for i in ALPHABET.size():
		letter = ALPHABET[i]
		
		var spawnNodes = spawnPoints[randi() % spawnPoints.size()]
#		spawned.append(spawnNodes)
		spawnPoints.erase(spawnNodes)
		spawnNodes.spriteIndex = letter
		
		if spawnPoints.empty():
			spawnPoints = get_children()
#			for points in spawnPoints.size():
#				repeated = spawnPoints[points]
#				if spawned.has(repeated):
#					spawnPoints.erase(repeated)
#				else:
#					spawnPoints = get_children()
		
		emit_signal("spawnPoint", spawnNodes)
	
#	spawned = []
