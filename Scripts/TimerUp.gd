extends Node2D

signal timerPicked()

onready var player = get_node("/root/Game/Player")
onready var itemSpawner = get_node("/root/Game/ItemSpawner")
onready var game = get_node("/root/Game")


func _ready():
	self.connect("timerPicked", itemSpawner, "spawn_timer")
	self.connect("timerPicked", game, "timer_update")


func _on_Area2D_body_entered(body):
	if body == player:
		emit_signal("timerPicked")
		get_node("/root/Game/SFX/ItemUp").play()
		queue_free()
