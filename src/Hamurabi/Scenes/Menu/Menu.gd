extends Control
var iniciable = Global.iniciable
var time = 0.5
var tutorialArrowShow = false
var startGame = false
var howToPlay = false
var credits = false


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
		$StartExplanation.visible = false
	
	if time >= 0.12:
		if startGame:
			get_tree().change_scene("res://Scenes/Intro/Intro.tscn")
		elif howToPlay:
			get_tree().change_scene("res://Scenes/HowToPlay/HowToPlay.tscn")
		elif credits:
			get_tree().change_scene("res://Scenes/Credits/Credits.tscn")
			
		
# Começar o jogo ao clicar no botão
func _on_StartButton_pressed():
	$FadeIn.visible = true
	$FadeIn/FadeAnimation.play("Fade")
	time = 0
	startGame = true

# Abrir tutorial quando clicar no botão
func _on_HowToPlayButton_pressed():
	time = 0
	howToPlay = true

# Abrir cena de créditos quando clicar no botão
func _on_CreditsButton_pressed():
	time = 0
	credits = true

# Função ativada ao pressionar o botão "Iniciar"
func _on_StartButton_button_down():
	$Click.play()
	
# Função ativada ao pressionar o botão "Como jogar"
func _on_HowToPlayButton_button_down():
	$Click.play()

# Função ativada ao pressionar o botão "Créditos"
func _on_CreditsButton_button_down():
	$Click.play()
