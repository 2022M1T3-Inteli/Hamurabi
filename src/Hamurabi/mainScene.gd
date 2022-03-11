extends Node2D

var time = 0

func _ready():
	pass
	
func _process(delta):
	time += delta
	
	if time >= 4.5:
		_on_Timer_timeout()

#função chamada após o nó timer terminar de esperar 4.5 segundos(muda para a próxima cena) 
func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")
