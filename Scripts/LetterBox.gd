extends Node2D

signal letter_value()

onready var game = get_node("/root/Game")
onready var player = get_node("/root/Game/Player")
onready var spawnPos = get_parent()
onready var spriteIndex

const ALPHABET = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j','k','l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v','x','y','w','z']


func _ready():
	self.connect("letter_value", game, "_on_letter_value")
	get_sprite_index()


func get_sprite_index():
	spriteIndex = spawnPos.spriteIndex
	generate_letter()


func generate_letter():
	$AnimatedSprite.frame = ALPHABET.find(spriteIndex, 0)


func _on_Area2D_body_entered(body):
	if body == player:
		emit_signal("letter_value", spriteIndex)
