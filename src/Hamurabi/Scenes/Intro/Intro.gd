extends Node2D

# Cria a variável que armazerá o tempo decorrido.
var time = 0

# Cria a variável que irá armazenar os textos da cena em forma de Array.
var text = [
	"O presidente do nosso país fugiu com todas as leis e deixou a sociedade em caos.",
	"Agora é sua missão reconstruir nossa constituição e colocar em ordem novamente o nosso país.",
	"Cada decisão que você tomar irá definir o futuro do nosso país.",
	"E lembre-se, coloque sempre o interesse coletivo acima de tudo em cada decisão que tomar.",
	"Topa o desafio?"
]


# Define o texto atual da cena com base no Array.
var actualText = 0
# Define o número de caracteres do texto atual.
var charTextSize = len(text[actualText]) # Armazenar o número de caracteres do texto.
# Define o caractere atual que será utilizado para percorrer o texto.
var charActualIndex = 0

# Define as variaveis que armazenarão os estados do dialogo e da cena.
var start = false
var next = false
var end = false

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
		# Verifica se chegou no último caractere do texto, caso sim deixa visível o botão que indica que pode passar para o próximo dialogo.
		if charActualIndex == charTextSize and actualText != len(text) - 1:
			$VBoxContainer/dialogue/dialogue_button.visible = true
			# Define que já pode passar de dialogo.
			next = true
		
		# Se chegar no último texto do dialogo e não for final da cena, exibe as escolhas.
		if actualText == len(text) - 1 and !end:
			$choice1.visible = true
			$choice2.visible = true

# Função chamada para pular a cena (dialogo).
func next_scene():
	# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
	if !next and actualText != len(text) - 1:
		$VBoxContainer/dialogue/label.text = text[actualText]
		next = true
		$VBoxContainer/dialogue/dialogue_button.visible = true
	# Caso não, verifica se ainda não é a última cena, se sim tira o botão de dialogo pois há mais cenas.
	else:
		if !end:
			$VBoxContainer/dialogue/dialogue_button.visible = false
		# Caso seja a última cena, passa para a próxima.
		else:
			get_tree().change_scene("res://Scenes/Main/Main.tscn")
		# Verifica se ainda não chegou no último texto do dialogo, caso não zera o texto do label para começar o novo texto.
		if actualText < len(text) - 1:
			$VBoxContainer/dialogue/label.text = ""
			# Define o próximo texto do Array.
			actualText += 1
			charTextSize = len(text[actualText])
			charActualIndex = 0
			time = 0
			next = false
		
		# Caso tenha chegado no final, mostra os botões de escolha.
		else:
			$choice1.visible = true
			$choice2.visible = true
			
# Quando apertar em qualquer parte do dialogo ele avança no dialogo.
func _on_dialogue_pressed():
	next_scene()
	
# Quando apertar no botão ele avança no dialogo.
func _on_dialogue_button_pressed():
	next_scene()

# Botão para escolher a primeira resposta.
func _on_choice1_pressed():
	text.append("Ótimo!")
	next = true
	$choice1.visible = false
	$choice2.visible = false
	end = true
	$VBoxContainer/dialogue/dialogue_button.visible = true
	next_scene()

# Botão para escolher a segunda resposta
func _on_choice2_pressed():
	text.append("Perfeito!")
	next = true
	$choice1.visible = false
	$choice2.visible = false
	end = true
	$VBoxContainer/dialogue/dialogue_button.visible = true
	next_scene()
	
