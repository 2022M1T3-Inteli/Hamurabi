extends Node2D

# evento que atualiza os indicadores de aprovação(social e econômico) para 100%, caso o usuário escolha a primeira resposta
func _on_answer1_button_pressed():
	$economic_indicator.text = "INDICADOR ECONÔMICO: 100%"
	$social_indicator.text = "INDICADOR SOCIAL: 100%"
	
# evento que atualiza os indicadores de aprovação(social e econômico) para 20%, caso o usuário escolha a segunda resposta	
func _on_answer2_button_pressed():
	$economic_indicator.text = "INDICADOR ECONÔMICO: 20%"
	$social_indicator.text = "INDICADOR SOCIAL: 20%"
	
# evento que atualiza os indicadores de aprovação(social e econômico) para 0%, caso o usuário escolha a terceira resposta	
func _on_answer3_button_pressed():
	$economic_indicator.text = "INDICADOR ECONÔMICO: 0%"
	$social_indicator.text = "INDICADOR SOCIAL: 0%"
