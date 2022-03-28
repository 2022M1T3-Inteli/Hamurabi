extends Node2D

# Variáveis dos indicadores que variam de acordo com as escolhas 
var economicIndicator = 50
var socialIndicator = 50

# Variáveis do tempo decorrido do mandato
var qtd_cenas = 9
var tempo_cena = 1460/qtd_cenas
var daysMandact = 1460 

# Define a cena atual
var actualScene = 0

# Cria um array de dicionários para guardar todos os valores de uma cena
var scenes = [
	{
		"title": "Separação ou concentração dos poderes",
		"lawExplanation": "Presidente, existem diversas funções a serem realizadas para o melhor desempenho da nação.",
		"question": "Dessa forma, quais métodos seriam mais eficientes para administrar o país??",
		"answers": {
			"answer1": {
				"text": "Manter o poder apenas em suas mãos",
				"indicators": {
					"social": -10,
					"economic": 5
				},
				"next": 2
			},
			"answer2": {
				"text": "",
				"indicators": {
					"social": 5,
					"economic": -5
				},
				"next": 2
			},
			"answer3": {
				"text": "Separar os poderes e cada poder terá uma função estatal",
				"indicators": {
					"social": 5,
					"economic": -5
				},
				"next": 2
			}
		},
		"background": "background.jpg",
		"image": "President.png", 
	},
	{
		"title": "O que é a CLT?",
		"lawExplanation": "CLT é a lei que mantém o direito dos trabalhadores.",
		"question": "O que fazer para manter os direitos dos trabalhadores?",
		"answers": {
			"answer1": {
				"text": "Criar Lei CLT",
				"indicators": {
					"social": 5,
					"economic": 5
				},
				"next": 3
			},
			"answer2": {
				"text": "Deixar o país sem lei dos trabalhadores",
				"indicators": {
					"social": -5,
					"economic": -5
				},
				"next": 3
			},
			"answer3": {
				"text": "Criar outra lei",
				"indicators": {
					"social": 5,
					"economic": -5
				},
				"next": 3
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Criação de Projetos de Lei pela população",
		"lawExplanation": "Presidente, uma parte da população gostaria de propor um projeto de lei em relação aos casos recentes sobre compra de votos",
		"question": "Mas, existem diversas dificuldades em relação à criação de um projeto de lei vindo da população. Qual a atitude o senhor(a) diante essa situação?",
		"answers": {
			"answer1": {
				"text": "Reduzir a burocracia para apresentação dos projetos de lei",
				"indicators": {
					"social": -10,
					"economic": 5
				},
				"next": 4
			},
			"answer2": {
				"text": "Aumentar a burocracia para apresentação dos projetos de lei",
				"indicators": {
					"social": 5,
					"economic": -5
				},
				"next": 4
			},
			"answer3": {
				"text": "Manter a burocracia para apresentação dos projetos de lei",
				"indicators": {
					"social": 0,
					"economic": 0
				},
				"next": 4
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Foro privilegiado",
		"lawExplanation": "Presidente, estamos com um grave problema: um deputado federal está sendo acusado de receber propina para votar projetos de leis por interesse",
		"question": "Ele alega que deve ser julgado pelo Supremo Tribunal Federal, para que não haja perseguição por estar em uma função pública. Após ouvir suas declarações, qual seria a medida tomada pelo senhor?",
		"answers": {
			"answer1": {
				"text": "Ele deve ser julgado pela justiça comum",
				"indicators": {
					"social": 5,
					"economic": -5
				},
				"next": 5
			},
			"answer2": {
				"text": "Ele será julgado pelo STF como forma de proteger sua função de Estado",
				"indicators": {
					"social": -5,
					"economic": 5
				},
				"next": 5
			},
			"answer3": {
				"text": "Ele não deve ser julgado e devemos arquivar o caso",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 5
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Medida Provisória",
		"lawExplanation": "A medida provisória (abreviadamente MP) é um ato unipessoal do Presidente da República e possui força imediata de lei. Isso significa que o Presidente decide, por sua própria vontade, criar uma lei.",
		"question": "Como presidente você tem o poder de criar novas leis através da Medida Provisória(MP). O seu vice-presidente acredita que você está fazendo um ótimo trabalho e sugere que você elimine todos os outros partidos políticos através de uma MP, assim liderando o país sozinho. Qual será a sua decisão?",
		"answers": {
			"answer1": {
				"text": "Não aceitar a proposta e manter a estrutura política como está.",
				"indicators": {
					"social": 5,
					"economic": 5
				},
				"next": 6
			},
			"answer2": {
				"text": "",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 6
			},
			"answer3": {
				"text": "Aceitar a proposta",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 6
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Nível de governo municipal",
		"lawExplanation": "Presidente, a população está reclamando sobre o lixo deixado nas ruas e a falta de transporte público desde que os políticos desapareceram",
		"question": "De quem você, como presidente, deve cobrar resultados?",
		"answers": {
			"answer1": {
				"text": "Cobrar dos prefeitos de cada cidade",
				"indicators": {
					"social": 15,
					"economic": 0
				},
				"next": 7
			},
			"answer2": {
				"text": "Cobrar os governadores estaduais",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 7
			},
			"answer3": {
				"text": "Cobrar deputados estaduais",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 7
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Asilo Político",
		"lawExplanation": "Um ex funcionário do Governo da Angola está sendo perseguido pelo governo de seu país por fazer criticas ao atual governo",
		"question": "Qual seria a sua conduta? Aceitar ou recusar ele?",
		"answers": {
			"answer1": {
				"text": "Aceitar Asilo",
				"indicators": {
					"social": 10,
					"economic": -5
				},
				"next": 8
			},
			"answer2": {
				"text": "",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 8
			},
			"answer3": {
				"text": "Recusar Asilo",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 8
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Fundo eleitoral",
		"lawExplanation": "Você como presidente pretende fazer uma campanha de reeleição a presidencia do pais e precisa de recursos. Uma empresa multinacional decide auxilia-lo financeiramente no processo de candidatura de forma legal",
		"question": "Qual seria a sua conduta?",
		"answers": {
			"answer1": {
				"text": "Aceitar a doação de recursos",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 9
			},
			"answer2": {
				"text": "Recusar a doação de recursos",
				"indicators": {
					"social": 0,
					"economic": 0
				},
				"next": 9
			},
			"answer3": {
				"text": "Aceitar a doação e declarar para as autoridades os valores recebidos",
				"indicators": {
					"social": -30,
					"economic": 0
				},
				"next": 9
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "Nível de governo estadual",
		"lawExplanation": "Presidente, estamos pagando muitos impostos em cima de nossos veículos e as rodovias que ligam nossas cidades estão horríveis. Estamos gastando muito dinheiro em peneus por causa de todos os buracos das estradas! Se você é presidente do povo, faça algo para melhorar isso",
		"question": "De quem você, como presidente, deve cobrar resultados?",
		"answers": {
			"answer1": {
				"text": "Cobrar resultado de vereadores municipais",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 10
			},
			"answer2": {
				"text": "Cobrar resultado de prefeitos municipais",
				"indicators": {
					"social": -10,
					"economic": 0
				},
				"next": 10
			},
			"answer3": {
				"text": "Cobrar resultado de governadores estaduais",
				"indicators": {
					"social": 15,
					"economic": -30
				},
				"next": 10
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
	{
		"title": "",
		"lawExplanation": "",
		"question": "",
		"answers": {
			"answer1": {
				"text": "",
				"indicators": {
					"social": 5,
					"economic": 5
				},
				"next": 11
			},
			"answer2": {
				"text": "",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 11
			},
			"answer3": {
				"text": "",
				"indicators": {
					"social": 0,
					"economic": 0
				},
				"next": 11
			}
		},
		"background": "background.jpg",
		"image": "President.png"
	},
]

func _ready():
	# Iniciar os indicadores (50%)
	$CongressBar.value = 50
	$CongressBar/CongressValue.text = String(50) + "%"
	$SocialEconomicBar.value = 50
	$SocialEconomicBar/SocialEconomicValue.text = String(50) + "%"
	$MandateTime/MandateTimeValue.text = String(1460) + " dias"
	
	# Definir a cena atual
	actualScene = scenes[actualScene]
	
	# Atribui e Renderiza os elementos de texto com base na cena atual 
#	$title.text = actualScene.title
#	$law_explanation.text = actualScene.lawExplanation
	$VBoxContainer/dialogue/label.text = actualScene.question
	$choice1/text.text = actualScene.answers.answer1.text
#	$choice2/text.text = actualScene.answers.answer2.text 
	$choice2/text.text = actualScene.answers.answer3.text

func _on_choice1_pressed():
		# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= tempo_cena 
	economicIndicator += actualScene.answers.answer1.indicators.economic 
	socialIndicator += actualScene.answers.answer1.indicators.social
	if economicIndicator >= 100:
		economicIndicator = 100
	if socialIndicator >= 100:
		socialIndicator = 100
	if economicIndicator <= 0:
		economicIndicator = 0
	if socialIndicator <= 0:
		socialIndicator = 0
	if daysMandact <= 0:
		daysMandact = 0
	
	# Se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
		
	$CongressBar.value = socialIndicator
	$SocialEconomicBar.value = economicIndicator
	$CongressBar/CongressValue.text = String(socialIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(economicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()
	
	# Verifica qual cena é a próxima com base na resposta da cena atual
	var next = actualScene.answers.answer1.next
	actualScene = scenes[next-1]
	if actualScene.answers.answer1.next == len(scenes):
		get_tree().change_scene("res://Scenes/Victory/Victory.tscn")
	
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
#	$title.text = actualScene.title
#	$law_explanation.text = actualScene.lawExplanation
	$VBoxContainer/dialogue/label.text = actualScene.question
	$choice1/text.text = actualScene.answers.answer1.text
	$choice2/text.text = actualScene.answers.answer2.text 
#	$answer3_button.text = actualScene.answers.answer3.text


func _on_choice2_pressed():
		# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= tempo_cena 
	economicIndicator += actualScene.answers.answer2.indicators.economic 
	socialIndicator += actualScene.answers.answer2.indicators.social
	if economicIndicator >= 100:
		economicIndicator = 100
	if socialIndicator >= 100:
		socialIndicator = 100
	if economicIndicator <= 0:
		economicIndicator = 0
	if socialIndicator <= 0:
		socialIndicator = 0
	if socialIndicator <= 0:
		socialIndicator = 0
		
	# Se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
	
	$CongressBar.value = socialIndicator
	$SocialEconomicBar.value = economicIndicator
	$CongressBar/CongressValue.text = String(socialIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(economicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()
	
	# Verifica qual cena é a próxima com base na resposta da cena atual
	var next = actualScene.answers.answer1.next
	actualScene = scenes[next-1]
	if actualScene.answers.answer1.next == len(scenes):
		get_tree().change_scene("res://Scenes/Victory/Victory.tscn")
		
#	if actualScene.answers.answer2.text == "":
#		$answer2_button.visible = false
#	else:
#		$answer2_button.visible = true
		
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
#	$title.text = actualScene.title
#	$law_explanation.text = actualScene.lawExplanation
	$VBoxContainer/dialogue/label.text = actualScene.question
	$choice1/text.text = actualScene.answers.answer1.text
	$choice2/text.text = actualScene.answers.answer2.text 
#	$answer3_button.text = actualScene.answers.answer3.text


func _on_ConfigurationButton_pressed():
	$PauseMask.visible = true
	$MenuInGameBg.visible = true
	$MenuInGame.visible = true
	$CloseMenuButton.visible = true
	$Click.play()

func _on_CloseMenuButton_pressed():
	$PauseMask.visible = false
	$MenuInGameBg.visible = false
	$MenuInGame.visible = false
	$CloseMenuButton.visible = false
	$Click.play()
	
func _on_dialogue_pressed():
	pass # Replace with function body.

