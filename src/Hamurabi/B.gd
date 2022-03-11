extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var gravity = 2300
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	time += delta
	if time > 3.10:
		velocity.y += gravity * delta
		velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
