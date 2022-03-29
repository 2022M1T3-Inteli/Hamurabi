extends Node2D

# Variáveis dos indicadores que variam de acordo com as escolhas 
var economicIndicator = 50
var socialIndicator = 50

# Variáveis do tempo decorrido do mandato
var numScenes = 10
var scenesLeft = numScenes - 1
var sceneTime = 1460/numScenes
var daysMandact = 1460 

# Define a cena atual
var actualScene = 0
# Define o Texto atual
var actualText = 0

# Armazenar o número de caracteres do texto.
var charTextSize = 0 
# Define o caractere atual que será utilizado para percorrer o texto.
var charActualIndex = 0

var time = 0
var startDialogue = false
var nextDialogue = false
var endDialogue = false

# Cria um array de dicionários para guardar todos os valores de uma cena
var scenes = [
	{
		"title": "Separação ou concentração dos poderes",
		"text": [
			"Presidente, existem diversas funções a serem realizadas para o melhor desempenho da nação.",
			"Dessa forma, quais métodos seriam mais eficientes para administrar o país??"
		],
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
		"text": [
			"CLT é a lei que mantém o direito dos trabalhadores.",
			"O que fazer para manter os direitos dos trabalhadores?",
		],
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
		"text": [
			"Presidente, uma parte da população gostaria de propor um projeto de lei em relação aos casos recentes sobre compra de votos",
			"Mas, existem diversas dificuldades em relação à criação de um projeto de lei vindo da população. Qual a atitude o senhor(a) diante essa situação?",
		],
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
		"text": [
			"Presidente, estamos com um grave problema: um deputado federal está sendo acusado de receber propina para votar projetos de leis por interesse",
			"Ele alega que deve ser julgado pelo Supremo Tribunal Federal, para que não haja perseguição por estar em uma função pública. Após ouvir suas declarações, qual seria a medida tomada pelo senhor?",
		],
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
		"text": [
			"A medida provisória (abreviadamente MP) é um ato unipessoal do Presidente da República e possui força imediata de lei. Isso significa que o Presidente decide, por sua própria vontade, criar uma lei.",
			"Como presidente você tem o poder de criar novas leis através da Medida Provisória(MP).",
			"O seu vice-presidente acredita que você está fazendo um ótimo trabalho e sugere que você elimine todos os outros partidos políticos através de uma MP, assim liderando o país sozinho.",
			"Qual será a sua decisão?",
		],
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
				"text": "Aceitar a proposta",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 6
			},
			"answer3": {
				"text": "",
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
		"text": [
			"Presidente, a população está reclamando sobre o lixo deixado nas ruas e a falta de transporte público desde que os políticos desapareceram",
			"De quem você, como presidente, deve cobrar resultados?",
		],
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
		"text": [
			"Um ex funcionário do Governo da Angola está sendo perseguido pelo governo de seu país por fazer criticas ao atual governo",
			"Qual seria a sua conduta? Aceitar ou recusar ele?",
		],
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
				"text": "Recusar Asilo",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": 8
			},
			"answer3": {
				"text": "",
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
		"text": [
			"Você como presidente pretende fazer uma campanha de reeleição a presidencia do pais e precisa de recursos. Uma empresa multinacional decide auxilia-lo financeiramente no processo de candidatura de forma legal",
			"Qual seria a sua conduta?",
		],
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
		"text": [
			"Presidente, estamos pagando muitos impostos em cima de nossos veículos e as rodovias que ligam nossas cidades estão horríveis.", 
			"Estamos gastando muito dinheiro em peneus por causa de todos os buracos das estradas! Se você é presidente do povo, faça algo para melhorar isso",
			"De quem você, como presidente, deve cobrar resultados?",	
		],
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
		"text": [],
		"question": "",
		"answers": {
			"answer1": {
				"text": "",
				"indicators": {
					"social": 5,
					"economic": 5
				},
				"next": null
			},
			"answer2": {
				"text": "",
				"indicators": {
					"social": -10,
					"economic": -10
				},
				"next": null
			},
			"answer3": {
				"text": "",
				"indicators": {
					"social": 0,
					"economic": 0
				},
				"next": null
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
	
	charTextSize = len(actualScene.text[actualText]) # Armazenar o número de caracteres do texto.
	# Define o caractere atual que será utilizado para percorrer o texto.
	
	# Atribui e Renderiza os elementos de texto com base na cena atual 
#	$title.text = actualScene.title
#	$law_explanation.text = actualScene.lawExplanation
	$Choice1/Text.text = actualScene.answers.answer1.text
#	$choice2/text.text = actualScene.answers.answer2.text 
	$Choice2/Text.text = actualScene.answers.answer3.text

func _process(delta):
	time += delta
	if time >= 0.5:
		startDialogue = true
	if startDialogue:
		if !nextDialogue and time >= 0.01 and charActualIndex < charTextSize:
			$VBoxContainer/Dialogue/DialogueLabel.text += actualScene.text[actualText][charActualIndex]
			charActualIndex += 1
			$Keyboard.play()
		if charActualIndex == charTextSize:
			if actualText != len(actualScene.text) - 1:
				$VBoxContainer/Dialogue/DialogueButton.visible = true
				# Define que já pode passar de dialogo.
				nextDialogue = true
			else:
				$Choice1.visible = true
				$Choice2.visible = true

	if Input.is_key_pressed(KEY_SPACE) and time >= 0.01:
		time = 0
		nextDialogue()

func _on_choice1_pressed():
	# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= sceneTime
	scenesLeft -= 1
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
	
	# Se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
		
	$CongressBar.value = socialIndicator
	$SocialEconomicBar.value = economicIndicator
	$CongressBar/CongressValue.text = String(socialIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(economicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()

	nextScene()

func _on_choice2_pressed():
		# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= sceneTime
	scenesLeft -= 1
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
	nextScene()


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

func nextDialogue():
	$VBoxContainer/Dialogue/DialogueButton.visible = false
	# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
	if !nextDialogue:
		$VBoxContainer/Dialogue/DialogueLabel.text = actualScene.text[actualText]
		nextDialogue = true
		if actualText != len(actualScene.text) - 1:
			$VBoxContainer/Dialogue/DialogueButton.visible = true
		else:
			$Choice1.visible = true
			$Choice2.visible = true
	# Caso não, verifica se ainda não é a última cena, se sim tira o botão de dialogo pois há mais cenas.
	else:
		if actualText < len(actualScene.text) - 1:
			$VBoxContainer/Dialogue/DialogueLabel.text = ""
			# Define o próximo texto do Array.
			actualText += 1
			charTextSize = len(actualScene.text[actualText])
			charActualIndex = 0
			time = 0
			nextDialogue = false
		
		# Caso tenha chegado no final, mostra os botões de escolha.
		else:
			$Choice1.visible = true
			$Choice2.visible = true

func _on_Dialogue_pressed():
	nextDialogue()
	
func nextScene():
	if scenesLeft == 0:
		get_tree().change_scene("res://Scenes/Victory/Victory.tscn")
	else: 
		$VBoxContainer/Dialogue/DialogueLabel.text = ""
		time = 2
		startDialogue = false
		nextDialogue = false
		var nextSceneIndex = actualScene.answers.answer1.next
		actualScene = scenes[nextSceneIndex - 1]
		$Choice1/Text.text = actualScene.answers.answer1.text
		$Choice2/Text.text = actualScene.answers.answer2.text 
		$Choice1.visible = false
		$Choice2.visible = false
		charActualIndex = 0
		actualText = 0
		charTextSize = len (actualScene.text[actualText])
