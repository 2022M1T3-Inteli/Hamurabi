extends Node2D

# Variáveis dos indicadores que variam de acordo com as escolhas 
var congressIndicator = 50
var socialEconomicIndicator = 50

# Variáveis do tempo decorrido do mandato
var numScenes = 10
var scenesLeft = numScenes - 1
var sceneTime = 1460/numScenes
var daysMandact = 1460 

# Define a cena atual
var actualScene = 0
var nextScene = 0
# Define o Texto atual
var actualText = 0

# Armazenar o número de caracteres do texto.
var charTextSize = 0 
# Define o caractere atual que será utilizado para percorrer o texto.
var charActualIndex = 0

var time = 0
var startDialogue = false
var nextDialogue = false
var consequenceScene = false
var endDialogue = false

#variável que define se o gregório precisa aparecer
var gregorioScene = true

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
				"consequence": {
					"text": [
						"Manter o poder foi uma escolha não muito boa.",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 5
				},
				"next": 2
			},
			"answer2": {
				"text": "Separar os poderes e cada poder terá uma função estatal",
				"consequence": {
					"text": [
						"Que excelente escolha!",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": -5
				},
				"next": 2
			},
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
				"consequence": {
					"text": [
						"Você criou a lei da CLT, muito bem feito!",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": 5
				},
				"next": 3
			},
			"answer2": {
				"text": "Deixar o país sem lei dos trabalhadores",
				"consequence": {
					"text": [
						"Não gostaram muito do que fizemos, querem que a gente mude essa situação o quanto antes.",
					],
				},
				"indicators": {
					"congress": -5,
					"socialEconomic": -5
				},
				"next": 3
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 5
				},
				"next": 4
			},
			"answer2": {
				"text": "Aumentar a burocracia para apresentação dos projetos de lei",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": -5
				},
				"next": 4
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": -5
				},
				"next": 5
			},
			"answer2": {
				"text": "Ele será julgado pelo STF como forma de proteger sua função de Estado",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -5,
					"socialEconomic": 5
				},
				"next": 5
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": 5
				},
				"next": 6
			},
			"answer2": {
				"text": "Aceitar a proposta",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": -10
				},
				"next": 6
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 15,
					"socialEconomic": 0
				},
				"next": 7
			},
			"answer2": {
				"text": "Cobrar os governadores estaduais",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 0
				},
				"next": 7
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 10,
					"socialEconomic": -5
				},
				"next": 8
			},
			"answer2": {
				"text": "Recusar Asilo",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": -10
				},
				"next": 8
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 0
				},
				"next": 9
			},
			"answer2": {
				"text": "Recusar a doação de recursos",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 0
				},
				"next": 9
			},
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
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 0
				},
				"next": 10
			},
			"answer2": {
				"text": "Cobrar resultado de prefeitos municipais",
				"consequence": {
					"text": [
						"Você...",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 0
				},
				"next": 10
			},
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
				"consequence": {
					"text": [
						"",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": 5
				},
				"next": null
			},
			"answer2": {
				"text": "",
				"consequence": [
					"",
				],
				"indicators": {
					"congress": -10,
					"socialEconomic": -10
				},
				"next": null
			},
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
	
	# Armazenar o número de caracteres do texto
	charTextSize = len(actualScene.text[actualText])

	# Define os textos das respostas com base na cena inicial
	$Choice1/Text.text = actualScene.answers.answer1.text
	$Choice2/Text.text = actualScene.answers.answer2.text 

func _process(delta):
	time += delta
	if time >= 0.5:
		startDialogue = true
	if startDialogue:
		if !nextDialogue and time >= 0.01 and charActualIndex < charTextSize:
			$VBoxContainer/Dialogue/DialogueLabel.text += actualScene.text[actualText][charActualIndex]
			charActualIndex += 1
			if time >= 0.03:
				$Keyboard.play()
				time = 0
		if charActualIndex == charTextSize:
			if actualText != len(actualScene.text) - 1:
				$VBoxContainer/Dialogue/DialogueButton.visible = true
				# Define que já pode passar de dialogo.
				nextDialogue = true
			else:
				if !consequenceScene:
					$Choice1.visible = true
					$Choice2.visible = true
				else:
					$VBoxContainer/Dialogue/DialogueButton.visible = true
					nextDialogue = true
	if Input.is_action_just_pressed("ui_right"):
		time = 0
		nextDialogue()

func _on_choice1_pressed():
	# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= sceneTime
	scenesLeft -= 1
	socialEconomicIndicator += actualScene.answers.answer1.indicators.socialEconomic 
	congressIndicator += actualScene.answers.answer1.indicators.congress
	if socialEconomicIndicator >= 100:
		socialEconomicIndicator = 100
	if congressIndicator >= 100:
		congressIndicator = 100
	if socialEconomicIndicator <= 0:
		socialEconomicIndicator = 0
	if congressIndicator <= 0:
		congressIndicator = 0
	
	# Se algum dos indicadores é zerado, a cena de impeachment é chamada
	if  congressIndicator == 0 or socialEconomicIndicator == 0:
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
		
	$CongressBar.value = congressIndicator
	$SocialEconomicBar.value = socialEconomicIndicator
	$CongressBar/CongressValue.text = String(congressIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(socialEconomicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()

	showExplication(actualScene.answers.answer1)

func _on_choice2_pressed():
		# Atualiza o valor dos indicadores com base na escolha da cena
	daysMandact -= sceneTime
	scenesLeft -= 1
	socialEconomicIndicator += actualScene.answers.answer2.indicators.socialEconomic 
	congressIndicator += actualScene.answers.answer2.indicators.congress
	if socialEconomicIndicator >= 100:
		socialEconomicIndicator = 100
	if congressIndicator >= 100:
		congressIndicator = 100
	if socialEconomicIndicator <= 0:
		socialEconomicIndicator = 0
	if congressIndicator <= 0:
		congressIndicator = 0
	if congressIndicator <= 0:
		congressIndicator = 0
		
	# Se algum dos indicadores é zerado, a cena de impeachment é chamada
	if congressIndicator == 0 or socialEconomicIndicator == 0:
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
	
	$CongressBar.value = congressIndicator
	$SocialEconomicBar.value = socialEconomicIndicator
	$CongressBar/CongressValue.text = String(congressIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(socialEconomicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()

	# Verifica qual cena é a próxima com base na resposta da cena atual
	showExplication(actualScene.answers.answer2)
	
	
func _on_Dialogue_pressed():
	print("Chamou o botão")
	nextDialogue()

func nextDialogue():
	print("Chamou o próximo dialogo")
	$VBoxContainer/Dialogue/DialogueButton.visible = false
	# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
	if !nextDialogue:
		print("entrou")
		$VBoxContainer/Dialogue/DialogueLabel.text = actualScene.text[actualText]
		nextDialogue = true
		if actualText != len(actualScene.text) - 1:
			$VBoxContainer/Dialogue/DialogueButton.visible = true
#		else:
#			$Choice1.visible = true
#			$Choice2.visible = true
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
			if consequenceScene:
				nextScene()
			else:
				$Choice1.visible = true
				$Choice2.visible = true
	
func showExplication(answer):
	consequenceScene = true
	$VBoxContainer/Dialogue/DialogueLabel.text = ""
	time = 0
	startDialogue = false
	nextScene = answer.next
	actualScene = answer.consequence
	nextDialogue = false
	$Choice1.visible = false
	$Choice2.visible = false
	charActualIndex = 0
	actualText = 0
	charTextSize = len (actualScene.text[actualText])

func nextScene():
	# Se algum dos indicadores forem menor ou igual a 20, o personagem Gregório irá aparecer
	if (congressIndicator <= 45 or socialEconomicIndicator <= 45) and gregorioScene:
		$Background/Renata.visible = false
		$Choice1.visible = false
		$Choice2.visible = false
		$Background/Gregorio.visible = true
		#$continue.visible = true
		$VBoxContainer/Dialogue/CharacterName.text = "Gregório - Jogador opositor"
		$VBoxContainer/Dialogue/DialogueLabel.text = "Muito cuidado com as suas próximas decisões, seus indicadores estão baixos e caso você os zere, será iniciado um processo de Impeachmeant contra você. E é isso o que nós, sua oposição, queremos!"
		gregorioScene = false
	else:
		actualScene = scenes[nextScene - 1]
		consequenceScene = false
		time = 0
		startDialogue = false
		if scenesLeft == 0:
			get_tree().change_scene("res://Scenes/Victory/Victory.tscn")
		else: 
			$VBoxContainer/Dialogue/DialogueLabel.text = ""
			time = 0
			startDialogue = false
			nextDialogue = false
	#		var nextSceneIndex = actualScene.answers.answer1.next
	#		actualScene = scenes[nextSceneIndex - 1]
			$Choice1/Text.text = actualScene.answers.answer1.text
			$Choice2/Text.text = actualScene.answers.answer2.text 
	#		$Choice1.visible = false
	#		$Choice2.visible = false
			charActualIndex = 0
			actualText = 0
			charTextSize = len (actualScene.text[actualText])

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
