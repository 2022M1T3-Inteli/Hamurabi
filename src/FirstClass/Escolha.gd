extends Node2D

#variável da progress bar de economia 
var marcadorEconomia = 0
#variável da progress bar social
var marcadorSocial = 0


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
	
	
	pass # Replace with function body.

func _on_ButtonProsseguir_pressed():
	
	#mmuda a label de consequencia
	$LabelConsequencia.text = "Escolha!"
	
	#se o jogador zerar algum marcador, chama a cena de impeachment
	if marcadorEconomia == 0 or marcadorSocial == 0:
		$LabelConsequencia.text = "perdeu"
		$ButtonProsseguir.hide()
		
		#chama cena de impeachment
	else:
		$LabelConsequencia.text = "prosseguir"
		#desbloquear os botões de escolha 
		$ButtonEscolha1.show()
		$ButtonEscolha2.show()
		$ButtonProsseguir.hide()
	
	
		#passa para outra cena
		#lembrar de levar as variáveis junto
		
	
	
	pass # Replace with function body.

