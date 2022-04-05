extends Node2D

# Cria a variável que armazerá o tempo decorrido.
var time = 0
var paused = false

onready var renataAnimation = [
	load("res://Assets/Public/Renata Animation 3.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 2.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 1.png"),
]

var timeAnimation = 0
var currentAnimation = 0

# Cria a variável que irá armazenar os textos da cena em forma de Array.
var text = [
	"O presidente do nosso país fugiu com todas as leis e deixou a sociedade em caos.",
	"Agora é sua missão reconstruir nossa constituição e colocar em ordem novamente o nosso país.",
	"Cada decisão que você tomar irá definir o futuro do nosso país.",
	"E lembre-se, coloque sempre o interesse coletivo acima de tudo em cada decisão que tomar.",
	"Topa o desafio?"
]


# Define o texto atual da cena com base no Array.
var actualText = 0
# Define o número de caracteres do texto atual.
var charTextSize = len(text[actualText]) # Armazenar o número de caracteres do texto.
# Define o caractere atual que será utilizado para percorrer o texto.
var charActualIndex = 0

# Define as variaveis que armazenarão os estados do dialogo e da cena.
var start = false
var next = false
var end = false

func _process(delta):
	# Incrementa o tempo passado no jogo utilizando o valor de delta.
	time += delta
	timeAnimation += delta
	
	if time >= 0.5:
		start = true
	
	if start:
		# Verifica se passou 0.01 seg e se o contador ainda é menor o tamanho do texto.
		if !next and time >= 0.01 and charActualIndex < charTextSize and !paused:
			# Adiciona ao texto do label o próximo caractere do texto.
			$VBoxContainer/Dialogue/DialogueLabel.text += text[actualText][charActualIndex]
			$Typing_song.play()
			if timeAnimation >= 0.15:
				if currentAnimation < len(renataAnimation):
					$Background/Renata.texture = renataAnimation[currentAnimation]
					currentAnimation += 1
					timeAnimation = 0
				else:
					currentAnimation = 0
					timeAnimation = 0
			# Aumenta o contador e reinicia o tempo decorrido.
			charActualIndex += 1
			time = 0
		# Verifica se chegou no último caractere do texto, caso sim deixa visível o botão que indica que pode passar para o próximo dialogo.
		if charActualIndex == charTextSize and actualText != len(text) - 1:
			currentAnimation = 0
			$Background/Renata.texture = renataAnimation[currentAnimation]
			timeAnimation = 0 
			$VBoxContainer/Dialogue/DialogueButton.visible = true
			# Define que já pode passar de dialogo.
			next = true
		
		# Se chegar no último texto do dialogo e não for final da cena, exibe as escolhas.
		if actualText == len(text) - 1 and !end:
			$Choice1.visible = true
			$Choice2.visible = true
			currentAnimation = 0
			$Background/Renata.texture = renataAnimation[currentAnimation]
			timeAnimation = 0 
		
		if Input.is_action_just_pressed("ui_cancel"):
			openMenu()
		
		if end:
			if time >= 1.5:
				get_tree().change_scene("res://Scenes/Main/Main.tscn")

# Função chamada para pular a cena (dialogo).
func next_scene():
	currentAnimation = 0
	$Background/Renata.texture = renataAnimation[currentAnimation]
	$VBoxContainer/Dialogue/DialogueButton.visible = false
	# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
	if !next and !end:
		$VBoxContainer/Dialogue/DialogueLabel.text = text[actualText]
		next = true
		if actualText != len(text) - 1:
			$VBoxContainer/Dialogue/DialogueButton.visible = true
		else:
			$Choice1.visible = true
			$Choice2.visible = true
	# Caso não, verifica se ainda não é a última cena, se sim tira o botão de dialogo pois há mais cenas.
	else:
		if actualText < len(text) - 1:
			$VBoxContainer/Dialogue/DialogueLabel.text = ""
			# Define o próximo texto do Array.
			actualText += 1
			charTextSize = len(text[actualText])
			charActualIndex = 0
			time = 0
			next = false
		
		# Caso tenha chegado no final, mostra os botões de escolha.
#		else:
#			$Choice1.visible = true
#			$Choice2.visible = true
			
# Quando apertar em qualquer parte do dialogo ele avança no dialogo.
func _on_Dialogue_pressed():
	next_scene()

# Quando apertar no botão ele avança no dialogo.
func _on_DialogueButton_pressed():
	next_scene()

# Botão para escolher a primeira resposta.
func _on_choice1_pressed():
	text.append("Perfeito!")
	next = true
	$Choice1.visible = false
	$Choice2.visible = false
	end = true
	next_scene()

# Botão para escolher a segunda resposta
func _on_choice2_pressed():
	text.append("Perfeito!")
	next = true
	$Choice1.visible = false
	$Choice2.visible = false
	end = true
	next_scene()

func _on_ConfigurationButton_pressed():
	openMenu()

func _on_CloseMenuButton_pressed():
	closeMenu()
	
func openMenu():
	$PauseMask.visible = true
	$MenuInGame.visible = true
	$CloseMenuButton.visible = true
	$Click.play()
	paused = true
	Global.menuOpen = true

func closeMenu():
	$PauseMask.visible = false
	$MenuInGame.visible = false
	$CloseMenuButton.visible = false
	$Click.play()
	paused = false
	Global.menuOpen = false
	
func _on_BackToMenuButton_pressed():
	Global.menuOpen = false
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
