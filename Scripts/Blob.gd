extends Area2D


signal touch()

onready var player = get_node("/root/Game/Player")


func _ready():
	self.connect("touch", player, "hit")


func _on_Blob_body_entered(body):
	if player == body:
		emit_signal("touch")
