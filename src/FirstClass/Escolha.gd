extends Node2D

#variável da progress bar de economia 
var marcadorEconomia:int = 0
#variável da progress bar social
var marcadorSocial:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#inicializando o game com marcadores exemplo
	marcadorEconomia = 50
	$LabelEconomia.text = str(marcadorEconomia) + "%"
	marcadorSocial = 50
	$LabelSocial.text = str(marcadorSocial) + "%"
	
	#desabilita o botão prosseguir no início
	$ButtonProsseguir.hide()
	
	#mmuda a label de consequencia
	$LabelConsequencia.text = "Escolha!"
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#consequência escolha 1
func _on_ButtonEscolha1_pressed():
	
	#explica ao usuário o que aconteceu
	$LabelConsequencia.text = "Sua economia cresceu 30%!"
	
	#só incrementa o marcador se esiver menor que 100
	if marcadorEconomia < 100:
		marcadorEconomia = marcadorEconomia + 30
		$LabelEconomia.text = str(marcadorEconomia) + "%"
		
	#marcador não pode passar de 100
	if marcadorEconomia > 100:
		marcadorEconomia = 100
		$LabelEconomia.text = str(marcadorEconomia) + "%"
	
	#liberar o botão de prosseguir
	$ButtonProsseguir.show()
	$ButtonEscolha1.hide()
	$ButtonEscolha2.hide()
	
	$LabelExplicacaoDecisao.hide()
	$SpriteBalaoFala.hide()
	
	#pass # levar a cena escolha 2

#consequência escolha 2
func _on_ButtonEscolha2_pressed():
	#explica ao usuário o que aconteceu
	$LabelConsequencia.text = "Sua sociedade ficou 50% descontente!"
	
	marcadorSocial = marcadorSocial - 50
	$LabelSocial.text = str(marcadorSocial) + "%"
	
	#liberar o botão de prosseguir
	$ButtonProsseguir.show()
	$ButtonEscolha1.hide()
	$ButtonEscolha2.hide()
	
	$LabelExplicacaoDecisao.hide()
	$SpriteBalaoFala.hide()
	
	pass # Replace with function body.

func _on_ButtonProsseguir_pressed():
	
	#mmuda a label de consequencia
	$LabelConsequencia.text = "Escolha!"
	
	#se o jogador zerar algum marcador, chama a cena de impeachment
	if marcadorEconomia == 0 or marcadorSocial == 0:
		$LabelConsequencia.text = "Um de seus marcadores chegou a zero! Perdeste"
		$ButtonProsseguir.hide()
		$LabelExplicacaoDecisao.hide()
		
		#tentativa de passar para outra scene
		get_tree().change_scene("res://Impeachment.tscn")
		
		#chama cena de impeachment
	else:
		$LabelConsequencia.text = "Escolha sabiamente!"
		#desbloquear os botões de escolha 
		$ButtonEscolha1.show()
		$ButtonEscolha2.show()
		$ButtonProsseguir.hide()
		
		$LabelExplicacaoDecisao.show()
		$SpriteBalaoFala.show()
	
	
		#passa para outra cena
		#lembrar de levar as variáveis junto
		
	
	
	pass # Replace with function body.

