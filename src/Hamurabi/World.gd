extends Node2D

#evento que muda para a próxima cena caso o usuário aperte o botão começar
func _on_Button_pressed():
	get_tree().change_scene("res://World2.tscn")
