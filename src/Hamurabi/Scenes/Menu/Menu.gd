extends Control
var iniciable = Global.iniciable
var time = 0.5
var tutorialArrowShow = false


func _ready():
	# Verifica se pode iniciar o jogo
	if Global.iniciable:
		# Habilita o botão de iniciar
		$VBoxContainer/StartButton.disabled = false
		$VBoxContainer/StartButton.modulate = "#ffffff"
		
func _process(delta):
	# Armazena o tempo decorrido
	time += delta
	# Verifica se não inicia o processo 
	if !iniciable:
		# Condição utilizada para conferir se o "como jogar" foi pressionado e manter a seta piscando a cada 0.5 segundos
		if time >= 0.5:
			if tutorialArrowShow:
				$TutorialArrow.visible = false
				tutorialArrowShow = false
				time = 0
			else:
				$TutorialArrow.visible = true
				tutorialArrowShow = true
				time = 0
	else:
		$TutorialArrow.visible = false
# Começar o jogo ao clicar no botão
func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Intro/Intro.tscn")

# Abrir tutorial quando clicar no botão
func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://Scenes/HowToPlay/HowToPlay.tscn")

# Abrir cena de créditos quando clicar no botão
func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits/Credits.tscn")

# Função ativada ao pressionar o botão "Iniciar"
func _on_StartButton_button_down():
	$Click.play()
	
# Função ativada ao pressionar o botão "Como jogar"
func _on_HowToPlayButton_button_down():
	$Click.play()

# Função ativada ao pressionar o botão "Créditos"
func _on_CreditsButton_button_down():
	$Click.play()
