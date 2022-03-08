extends Node2D


signal spawn()
signal gameOver()

var words = ['francais', 'coucou', 'jess', 'cours']
var word
var currentWord = []
var wordInput = []
var guess = ""
var wordReveal = ""
var timer = 60.0


func _ready():
	get_new_word()
	$CanvasLayer/Input.text = ""
	$CanvasLayer/Display.text = ""
	$CanvasLayer/Win.text = ""


func _process(delta):
	timer -= delta
	check_time()
	$CanvasLayer/TimerCount.value = timer
#	$CanvasLayer/TimerCount/Label.text = str(int(timer))
	$CanvasLayer/Input.text = wordReveal


func check_time():
	if timer <= 10:
		$SFX/Background.pitch_scale += 0.001
		$CanvasLayer/TimerCount.set_under_texture(load("res://Graphics/timerDangerTexture.png"))
	else:
		$SFX/Background.pitch_scale = 1
		$CanvasLayer/TimerCount.set_under_texture(load("res://Graphics/timerFullTexture.png"))
		
	
	if timer <= 0:
		timer = 0
		$SFX/Background.stop()
		$SFX/GameOver.play()
		$CanvasLayer/Win.text = "O TEMPO ESGOTOU!"
		game_over()


func timer_update():
	timer += 15.0
	if timer >= 60.0:
		timer = 61.0


func get_new_word():
	if words.empty():
		$SFX/Background.stop()
		$SFX/Win.play()
		$CanvasLayer/Win.text = "VOCÊ VENCEU!!!"
		game_over()
	else:
		emit_signal("spawn")
		
		currentWord = []
		wordInput = []
		
		randomize()
		words.shuffle()
		
		word = words.pop_front()
		
		for letters in word:
			currentWord.append(letters)
			wordInput.append("_")
		
		$CanvasLayer/Palavra.text = "A palavra é " + word


func _on_letter_value(spriteIndex):
	guess = spriteIndex
	check_word()


func check_word():
	var letter
	var guessedWord = ""
	
	if not guess in word:
		$SFX/WrongLetter.play()
		$CanvasLayer/Display.text = "A palavra não contém esta letra!"
		timer -= 5.0
	elif guess in wordInput:
		$CanvasLayer/Display.text = "A palavra já contém esta letra!"
	elif guess in word:
		$SFX/CorrectLetter.play()
		for i in currentWord.size():
			letter = currentWord[i]
			if guess == letter:
				wordInput[i] = guess
			guessedWord += str(wordInput[i])
			
		if guessedWord == word:
			wordReveal = ""
#			yield(get_tree().create_timer(1), "timeout")
			
			get_new_word()
		else:
			wordReveal = ""
			wordReveal = guessedWord.to_upper()
	


func game_over():
	emit_signal("gameOver")
#	$CanvasLayer/TimerCount/Label.visible = false
	timer = 99
	yield(get_tree().create_timer(3), "timeout")
	get_tree().quit()
