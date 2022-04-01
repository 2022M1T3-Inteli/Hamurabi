extends Node2D

# Função chamada para alterar cena ao pressionar o botão
func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")

# Função chamada para se direcionar a um link ao clicar no botão
func _on_AlyssonButton_pressed():
	OS.shell_open("https://www.instagram.com/eualissoncordeiro/")
	
func _on_PedroButton_pressed():
	OS.shell_open("https://www.linkedin.com/in/pedro-silva-14343022a")

func _on_FelipeButton_pressed():
	OS.shell_open("https://www.linkedin.com/in/felipe-sampaio-64bb48212")

func _on_SaadiButton_pressed():
	OS.shell_open("https://www.linkedin.com/in/felipe-saadi/")

func _on_GiovannaButton_pressed():
	OS.shell_open("https://www.linkedin.com/in/giovana-lisb%C3%B4a-thom%C3%A9-012a881a8/")

func _on_KathlynButton_pressed():
	OS.shell_open("https://www.linkedin.com/in/kathlyn-diwan-0a0189232/")

func _on_IagoButton_pressed():
	OS.shell_open("www.linkedin.com/in/iago-tavares-b10244149")

func _on_InteliButton_pressed():
	OS.shell_open("https://www.inteli.edu.br/")
	
func _on_ConstituicaoButton_pressed():
	OS.shell_open("https://www.linkedin.com/company/projeto-constitui%C3%A7%C3%A3o-na-escola/")

func _on_ClosedCreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
