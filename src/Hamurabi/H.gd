extends KinematicBody2D

# Declara as variáveis do objeto
var velocity = Vector2()
var gravity = 600
var time = 0

func _physics_process(delta):
	# Armazena o tempo decorrido
	time += delta
	
	# Verifica se já se passou 1 segundo. Caso sim, aumenta a velocidade com base na gravidade pelo tempo decorrido.
	if time > 1.0:
		velocity.y += gravity * delta
		
		# Movimenta o objeto
		velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
