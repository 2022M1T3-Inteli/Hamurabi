extends Node2D

var time = 0
var text = "O presidente do nosso país fugiu com todas as leis e deixou a sociedade em caos. \nAgora é sua missão reconstruir nossa constituição e colocar em ordem novamente o nosso país. \nCada decisão que você tomar irá definir o futuro do nosso país. \nE lembre-se, coloque sempre o interesse coletivo acima de tudo em cada decisão que tomar. \nTopa o desafio?"
var charTextSize = len(text) # Armazenar o número de caracteres do texto.
var charActualIndex = 0
var start = false
# evento que muda para a próxima cena caso o usuário aperte o botão começar
func _on_button_pressed():
	get_tree().change_scene("res://World2.tscn")

func _process(delta):
	# Incrementa o tempo passado no jogo utilizando o valor de delta.
	time += delta
	
	if time >= 0.5:
		start = true
	
	if start:
		# Verifica se passou 0.01 seg e se o contador ainda é menor o tamanho do texto.
		if time >= 0.01 and charActualIndex < charTextSize:
			# Adiciona ao texto do label o próximo caractere do texto.
			$label.text += text[charActualIndex]
			
			# Aumenta o contador e reinicia o tempo decorrido.
			charActualIndex += 1
			time = 0
