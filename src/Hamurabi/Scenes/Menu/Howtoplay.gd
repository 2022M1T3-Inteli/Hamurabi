extends Node2D

var guide = ["Scene1", "Scene2", "Scene3", "Scene4", "Scene5", "Scene6", "Scene7", "Scene8", "Scene9"]
var index = 0
var texture = load("res://Assets/Menu/Howtoplay/Scene1.png")
var path 


func _ready():
	# AO INICIAR A CENA, ADICIONAMOS A LABEL "TextureRect" A PRIMEIRA IMAGEM DO TUTORIAL
	$TextureRect.texture = texture
#	# O BOTÃO 2 DEVE INICIAR DESATIVADO E SÓ SER ATIVADO NA ÚLTIMA CENA, POSSIBITANDO QUE O USUÁRIO SEJA REDIRECIONADO PARA O MENU INICIAL DO GAME 
#	$TextureButton2.visible = false
#	$TextureButton2.disabled = true
	
func _process(delta):
	# A CONDIÇÃO ABAIXO INDICA QUE QUANDO O USUÁRIO CHEGAR A ÚLTIMA TELA DO TUTORIAL, O BOTÃO DE PASSAGEM DE TELA SEJA SUBSTITUIDO PELO BOTÃO DE REDIRECIONAMENTO PARA O MENU INICIAL
	if index == 8: 
		$NextButton.visible = false
	else:
		$NextButton.visible = true
	if index == 0:
		$PreviousButton.visible = false
	else:
		$PreviousButton.visible = true
func _on_TextureButton2_pressed():
	#AO CLICAR NO BUTTON 2 (QUE APARECE NA ÚLTIMA TELA), O USUÁRIO SERÁ REDIRECIONADO PARA O MENU INICIAL
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
	
func _on_TextureButton2_button_down():
	#SOM DO BOTÃO
	$Song.play()

func _on_NextButton_pressed():
	# QUANDO O USUÁRIO CLICAR NO BOTÃO DE AVANÇAR, O INDICE IRÁ CRESCER 1 QUANTIDADE
	
	index += 1
	# A VARIAVEL REPRESENTA O CAMINHO DA TELA DA CENA DE ACORDO COM O INDICE DA ARRAY "CENAS"
	path = str("res://Assets/Menu/Howtoplay/", guide[index], ".png")
	# O CÓDIGO ABAIXO TRAZ A TELA PARA A LABEL 
	$TextureRect.texture = load(path)
	# SOM DO BOTÃO
	$Song.play()


func _on_PreviousButton_pressed():
	# QUANDO O USUÁRIO CLICAR NO BOTÃO DE AVANÇAR, O INDICE IRÁ CRESCER 1 QUANTIDADE
	index -= 1
	# A VARIAVEL REPRESENTA O CAMINHO DA TELA DA CENA DE ACORDO COM O INDICE DA ARRAY "CENAS"
	path = str("res://Assets/Menu/Howtoplay/", guide[index], ".png")
	# O CÓDIGO ABAIXO TRAZ A TELA PARA A LABEL 
	$TextureRect.texture = load(path)
	# SOM DO BOTÃO
	$Song.play()
