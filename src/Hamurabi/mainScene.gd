extends Node2D


func _ready():
	pass

#função chamada após o nó timer terminar de esperar 8 segundos(muda para a próxima cena) 
func _on_Timer_timeout():
	get_tree().change_scene("res://World.tscn")
