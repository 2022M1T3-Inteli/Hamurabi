extends Node2D

# Inicia o timer
var timer = 0

func _ready():
	$OpenSong.play()
	
# Função que inícia um processo a cada intervalo de tempo decorrido.
func _process(delta):
	timer += delta
	
	# Verifica se passou 5 segundos.
	if timer >= 5:
		timerOut()

# Função chamada após o nó timer terminar de esperar 5 segundos e muda para a próxima cena. 
func timerOut():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
