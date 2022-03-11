extends Node2D

# Inicia o timer
var timer = 0

func _ready():
	pass
	
func _process(delta):
	timer += delta
	
	# Verifica se passou 4.5 segundos.
	if timer >= 4.5:
		timerOut()

# Função chamada após o nó timer terminar de esperar 4.5 segundos e muda para a próxima cena. 
func timerOut():
	get_tree().change_scene("res://Menu.tscn")
