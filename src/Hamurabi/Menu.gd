extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_SairButton_pressed():
	get_tree().change_scene("res://saida.tscn")


func _on_ComoJogarButton_pressed():
	get_tree().change_scene("res://opções.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://créditos.tscn")
