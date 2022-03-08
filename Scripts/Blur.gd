extends TextureRect


onready var blur = material.get_shader_param("blur")
onready var crackings = get_node("/root/Game/CanvasLayer/Crackings")
onready var sFx = get_node("/root/Game/Glasses/Crack")


func _on_Player_incrementBlur():
	sFx.play()
	if crackings.visible == false:
		crackings.visible = true
	else:
		crackings.frame += 1
		if crackings.frame >= 2:
			crackings.frame = 2
	
	blur += 1.0
	material.set_shader_param("blur", blur)


func _on_Player_NewGlasses():
	crackings.visible = false
	crackings.frame = 0
	blur = 0.0
	material.set_shader_param("blur", blur)
