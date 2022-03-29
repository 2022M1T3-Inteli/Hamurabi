extends Node2D

var time = 0
var text = [
	"O presidente do nosso país fugiu com todas as leis e deixou a sociedade em caos.",
	"Agora é sua missão reconstruir nossa constituição e colocar em ordem novamente o nosso país.",
	"Cada decisão que você tomar irá definir o futuro do nosso país.",
	"E lembre-se, coloque sempre o interesse coletivo acima de tudo em cada decisão que tomar.",
	"Topa o desafio?"
]
var actualText = 0
var charTextSize = len(text[actualText]) # Armazenar o número de caracteres do texto.
var charActualIndex = 0
var start = false
var next = false
var end = false

var scene1 = {
	"title": "Separação ou concentração dos poderes",
	"lawExplanation": "Enquanto presidente, você percebe que existem diversas funções a serem realizadas para o melhor desempenho da nação.",
	"question": "Dessa forma, quais métodos seriam mais eficientes para administrar o país?",
	"answers": {
		"answer1": {
			"text": "Manter o poder  apenas em suas mãos",
			"indicators": {
				"social": -10,
				"economic": 5
			},
			"next": "scene2"
		},
		"answer2": {
			"text": "",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene2"
		},
		"answer3": {
			"text": "Separar os poderes e cada poder terá uma função estatal",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene2"
		}
	},
}

# evento que muda para a próxima cena caso o usuário aperte o botão começar
func _on_button_pressed():
	get_tree().change_scene("res://World2.tscn")

func _on_button_button_down():
	$Click.play()

func _process(delta):
	# Incrementa o tempo passado no jogo utilizando o valor de delta.
	time += delta
	
	if time >= 0.5:
		start = true
	
	if start:
		# Verifica se passou 0.01 seg e se o contador ainda é menor o tamanho do texto.
		if !next and time >= 0.01 and charActualIndex < charTextSize:
			# Adiciona ao texto do label o próximo caractere do texto.
			$VBoxContainer/dialogue/label.text += text[actualText][charActualIndex]
			$Typing_song.play()
			
			# Aumenta o contador e reinicia o tempo decorrido.
			charActualIndex += 1
			time = 0
		if charActualIndex == charTextSize and actualText != len(text) - 1:
			$VBoxContainer/dialogue/dialogue_button.visible = true
			next = true
		if actualText == len(text) - 1 and !end:
			$choice1.visible = true
			$choice2.visible = true

func next_scene():
	if !next and actualText != len(text) - 1:
		$VBoxContainer/dialogue/label.text = text[actualText]
		next = true
		$VBoxContainer/dialogue/dialogue_button.visible = true
	else:
		if !end:
			$VBoxContainer/dialogue/dialogue_button.visible = false
		else:
			get_tree().change_scene("res://World2.tscn")
		if actualText < len(text) - 1:
			$VBoxContainer/dialogue/label.text = ""
			actualText += 1
			charTextSize = len(text[actualText])
			charActualIndex = 0
			time = 0
			next = false
		else:
			$choice1.visible = true
			$choice2.visible = true

func _on_dialogue_pressed():
	next_scene()
	
func _on_dialogue_button_pressed():
	next_scene()


func _on_choice1_pressed():
	text.append("Ótimo!")
	next = true
	$choice1.visible = false
	$choice2.visible = false
	end = true
	$VBoxContainer/dialogue/dialogue_button.visible = true
	next_scene()

func _on_choice2_pressed():
	text.append("Perfeito!")
	next = true
	$choice1.visible = false
	$choice2.visible = false
	end = true
	$VBoxContainer/dialogue/dialogue_button.visible = true
	next_scene()
	
