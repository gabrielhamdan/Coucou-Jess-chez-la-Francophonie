extends Position2D


onready var letterScene = load("res://Scenes/LetterBox.tscn")
onready var childNode
export var spriteIndex = ""
var spawnPos


func _on_Spawners_spawnPoint(spawnNodes):
	spawnPos = spawnNodes
	spawn()


func spawn():
	var letterBlock = letterScene.instance()
	spawnPos.add_child(letterBlock)
	letterBlock.set_as_toplevel(true)
	letterBlock.position = spawnPos.global_position


func clear_children():
	childNode = get_child_count()
	if childNode != 0 or childNode == null or childNode >= 1:
		var clear = get_child(0)
		clear.queue_free()
