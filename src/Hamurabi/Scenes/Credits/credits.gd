extends Node2D

# Função chamada para alterar cena ao pressionar o botão
func _on_Button_pressed():
	$Click.play()
	get_tree().change_scene("res://Menu.tscn")

# Função chamada para se direcionar ao linkedin do Alysson ao clicar no botão
func _on_AlyssonButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/alysson-cordeiro-0684a8236/")
	
# Função chamada para se direcionar ao linkedin do Pedro ao clicar no botão
func _on_PedroButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/pedro-silva-14343022a")

# Função chamada para se direcionar ao linkedin do Felipe ao clicar no botão
func _on_FelipeButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/felipe-sampaio-64bb48212")
	
# Função chamada para se direcionar ao linkedin do Saadi ao clicar no botão
func _on_SaadiButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/felipe-saadi/")
	
# Função chamada para se direcionar ao linkedin da Giovana ao clicar no botão
func _on_GiovanaButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/giovana-lisb%C3%B4a-thom%C3%A9-012a881a8/")
	
# Função chamada para se direcionar ao linkedin da Kathlyn ao clicar no botão
func _on_KathlynButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/in/kathlyn-diwan-0a0189232/")

# Função chamada para se direcionar ao linkedin do Iago ao clicar no botão	
func _on_IagoButton_pressed():
	$Click.play()
	OS.shell_open("www.linkedin.com/in/iago-tavares-b10244149")
	
# Função chamada para se direcionar ao Site do Inteli ao clicar no botão
func _on_InteliButton_pressed():
	$Click.play()
	OS.shell_open("https://www.inteli.edu.br/")
	
# Função chamada para se direcionar ao linkedin do Constituição nas Escolas ao clicar no botão
func _on_ConstituicaoButton_pressed():
	$Click.play()
	OS.shell_open("https://www.linkedin.com/company/projeto-constitui%C3%A7%C3%A3o-na-escola/")
	
# Volta para o menu ao clicar no botão de sair
func _on_ClosedCreditsButton_pressed():
	$Click.play()
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
