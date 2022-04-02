extends Node2D

# Lista de nome de arquivos
var guide = ["Scene1", "Scene2", "Scene3", "Scene4", "Scene5", "Scene6", "Scene7", "Scene8", "Scene9"]
var index = 0
# Define a textura atual do guia
var texture = load("res://Assets/HowToPlay/Scene1.png")
# Cria a variavel path
var path 

func _ready():
	# AO INICIAR A CENA, ADICIONAMOS A LABEL "TextureRect" A PRIMEIRA IMAGEM DO TUTORIAL
	$Guide.texture = texture

func _on_TextureButton2_pressed():
	#AO CLICAR NO BUTTON 2 (QUE APARECE NA ÚLTIMA TELA), O USUÁRIO SERÁ REDIRECIONADO PARA O MENU INICIAL
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
	
func _on_TextureButton2_button_down():
	#SOM DO BOTÃO
	$Click.play()

func _on_NextButton_pressed():
	# Quando o usuário clicar no botão avançar, o indice ira aumentar em uma unidade
	index += 1
	
	# Chama a função para mostrar os botões
	showButtons()
	
	# Path será o caminho da imagem de acordo com o atual indice do novo guia a ser mostrado
	path = str("res://Assets/HowToPlay/", guide[index], ".png")
	# Define a textura do guia mostrado
	$Guide.texture = load(path)
	
	# Da play no audio do botão
	$Click.play()


func _on_PreviousButton_pressed():
	# Quando o usuário clicar no botão retroceder, o indice irar diminuir em uma unidade
	index -= 1
	
	# Chama a função para mostrar os botões
	showButtons()

	# Path será o caminho da imagem de acordo com o atual indice do novo guia a ser mostrado
	path = str("res://Assets/HowToPlay/", guide[index], ".png")
	# Define a textura do guia mostrado
	$Guide.texture = load(path)
	
	# Da play no audio do botão
	$Click.play()
	
# Função para mostrar ou escoder os botões de retroceder e avançar do guia
func showButtons():
	# Caso chegue na última guia do tutorial, esconde o botão de avançar
	if index == 8: 
		$NextButton.visible = false
	# Caso não, mostra o botão de avançar
	else:
		$NextButton.visible = true
	# Caso chegue no primeiro guia do tutorial, esconde o botão de retroceder
	if index == 0:
		$PreviousButton.visible = false
	# Caso não, mostra o botão de retroceder
	else:
		$PreviousButton.visible = true

# Função para voltar ao menu ao clicar no botão de fechar do guia
func _on_CloseGuideButton_pressed():
	$Click.play()
	Global.iniciable = true
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
