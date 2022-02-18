extends Node2D

#evento que atualiza os indicadores de aprovação(social e econômico) para 100%, caso o usuário escolha a primeira resposta
func _on_Button_pressed():
	$indicadorEconomico.text = "INDICADOR ECONÔMICO: 100%"
	$indicadorSocial.text = "INDICADOR SOCIAL: 100%"
	
#evento que atualiza os indicadores de aprovação(social e econômico) para 0%, caso o usuário escolha a segunda resposta
func _on_resposta2_pressed():
	$indicadorEconomico.text = "INDICADOR ECONÔMICO: 0%"
	$indicadorSocial.text = "INDICADOR SOCIAL: 0%"
#evento que atualiza os indicadores de aprovação(social e econômico) para 20%, caso o usuário escolha a terceira resposta	
func _on_resposta3_pressed():
	$indicadorEconomico.text = "INDICADOR ECONÔMICO: 20%"
	$indicadorSocial.text = "INDICADOR SOCIAL: 20%"
#evento que muda para a próxima cena caso o usuário aperte o botão continuar	
func _on_proximo_pressed():
	get_tree().change_scene("res://World3.tscn")
