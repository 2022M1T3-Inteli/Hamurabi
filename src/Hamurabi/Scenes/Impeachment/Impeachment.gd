extends Node2D

# Função chamada ao clicar no botão de jogar novamente
func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
