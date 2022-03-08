extends Node2D


signal glassesPicked()

onready var player = get_node("/root/Game/Player")
onready var itemSpawner = get_node("/root/Game/ItemSpawner")
onready var glasses = get_node("/root/Game/Glasses/Blur")


func _ready():
#	self.connect("glassesPicked", itemSpawner, "spawn_glasses")
	self.connect("glassesPicked", player, "glass_health_update")
#	self.connect("glassesPicked", glasses, "restore_glass")


func _on_Area2D_body_entered(body):
	if body == player:
		var nodePath = get_path()
		emit_signal("glassesPicked", nodePath)
