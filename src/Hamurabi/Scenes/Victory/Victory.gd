extends Node2D

var time = 0

func _ready():
	$FadeOut/FadeAnimation.play("Fade")
	
func _process(delta):
	time += delta
	
	if time >= 0.5:
		$FadeOut.visible = false
		
# Função chamada para reiniciar o jogo ao clicar no botão tentar novamente
func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
