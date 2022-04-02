extends Node2D

# Função chamada para reiniciar o jogo ao clicar no botão tentar novamente
func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
