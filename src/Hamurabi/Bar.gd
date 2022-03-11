extends KinematicBody2D

# Declara as variáveis do objeto
var velocity = Vector2()
var speed = 2
var aceleration = 5

func _process(delta):
	# Verifica se o objeto ainda não chegou no seu destino. Caso não, move o objeto com base na velocidade pela aceleração.
	if position.x < 637:
		position.x += speed * aceleration
		
		# Movimenta o objeto.
		move_and_slide(velocity, Vector2.RIGHT)
	
	# Caso já tenha chegado ao seu destino, para o objeto.
	else:
		speed = 0
