extends KinematicBody2D


signal incrementBlur()
signal NewGlasses()

const MOVE_SPEED = 200
const JUMP_FORCE = 800
const GRAVITY = 50
const MAX_FALL_SPEED = 500

onready var game = get_node("/root/Game")
onready var itemSpawner = get_node("/root/Game/ItemSpawner")
var y_velo = 0
var canMove = true
var glassHealth = GLASS_MAX_HEALTH

const GLASS_MAX_HEALTH = 4


func _ready():
	set_as_toplevel(true)
	game.connect("gameOver", self, "game_over")
	self.connect("NewGlasses", itemSpawner, "spawn_glasses")


func _physics_process(delta):
	var move_dir = 0
	if canMove == true:
		if Input.is_action_pressed("move_left"):
			$Sprite.flip_h = true
			move_dir -= 1
			if is_on_wall():
				move_dir = 0
		if Input.is_action_pressed("move_right"):
			$Sprite.flip_h = false
			move_dir += 1
			if is_on_wall():
				move_dir = 0
		move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0,-1))
		
		var onGround = is_on_floor()
		y_velo += GRAVITY
		if onGround and Input.is_action_just_pressed("jump"):
			y_velo = -JUMP_FORCE
			$JumpSound.play()
		if onGround and y_velo >= 5:
			y_velo = 5
		if y_velo > MAX_FALL_SPEED:
			y_velo = MAX_FALL_SPEED
		if is_on_ceiling():
			y_velo = MAX_FALL_SPEED / 4
	
		if onGround and Input.is_action_pressed("down") and Input.is_action_just_pressed("jump"):
			y_velo = JUMP_FORCE
			position.y += 2
			y_velo = MAX_FALL_SPEED


func _input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func hit():
		glassHealth -= 1
		if glassHealth <= 0:
			glassHealth = 0
		else:
			emit_signal("incrementBlur")


func glass_blur():
	glassHealth -= 1
	if glassHealth <= 0:
		glassHealth = 0
	else:
		emit_signal("incrementBlur")


func glass_health_update(value):
	var nodePath
	nodePath = value
	if glassHealth < GLASS_MAX_HEALTH:
		glassHealth = GLASS_MAX_HEALTH
		get_node("/root/Game/SFX/ItemUp").play()
		get_node(str(nodePath)).queue_free()
		emit_signal("NewGlasses")


func game_over():
	canMove = false
