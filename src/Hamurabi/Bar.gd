extends KinematicBody2D

var velocity = Vector2()
var speed = 2
var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	time += delta
	if position.x < 637:
		position.x += speed * 5
		move_and_slide(velocity, Vector2.RIGHT)
	else:
		speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
