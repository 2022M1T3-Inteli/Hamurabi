extends Control
var iniciable = Global.iniciable
var time = 0.5
var tutorialArrowShow = false

func _ready():
	if Global.iniciable:
		$VBoxContainer/StartButton.disabled = false
		$VBoxContainer/StartButton.modulate = "#ffffff"
		
func _process(delta):
	time += delta
	if !iniciable:
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

func _on_StartButton_button_down():
	$Click.play()
