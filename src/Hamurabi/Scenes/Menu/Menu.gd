extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Começar o jogo ao clicar no botão
func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Intro/Intro.tscn")

func _on_StartButton_button_down():
	$Click.play()

# Sair do jogo ao clicar no botão
func _on_SairButton_pressed():
	get_tree().change_scene("res://saida.tscn")

# Abrir tutorial quando clicar no botão
func _on_HowToPlayButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Howtoplay.tscn")

# Abrir cena de créditos quando clicar no botão
func _on_CreditsButton_pressed():
	get_tree().change_scene("res://créditos.tscn")


func _on_StartButtonn_down():
	pass # Replace with function body.


func _on_StartButton_down():
	pass # Replace with function body.


