extends Node2D

var economicIndicator = 50
var socialIndicator = 50

# Define a cena atual
var actualScene = "scene1"

# Cria um dicinário para guardar todos os valores de uma cena (a estrutura se repete várias vezes ao longo do código)
var scene1 = {
	"title": "O QUE É A CLT?",
	"lawExplanation": "CLT É A LEI QUE MANTÉM O DIREITO DOS TRABALHADORES",
	"question": "O que fazer para manter os direitos dos trabalhadores?",
	"answers": {
		"answer1": {
			"text": "CRIAR A CLT DOS TRABALHADORES",
			"indicators": {
				"social": 20,
				"economic": 20
			},
			"next": "scene2"
		},
		"answer2": {
			"text": "DEIXAR O PAÍS SEM LEI DOS TRABALHADORES",
			"indicators": {
				"social": -20,
				"economic": -10
			},
			"next": "scene2"
		},
		"answer3": {
			"text": "outro texto",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene2"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene2 = {
	"title": "Separação ou concentração dos poderes",
	"lawExplanation": "Enquanto presidente, você percebe que existem diversas funções a serem realizadas para o melhor desempenho da nação. ",
	"question": "Dessa forma, quais métodos seriam mais eficientes para administrar o país??",
	"answers": {
		"answer1": {
			"text": "Manter o poder  apenas em suas mãos",
			"indicators": {
				"social": -10,
				"economic": 5
			},
			"next": "scene3"
		},
		"answer2": {
			"text": "Separar os poderes e cada poder terá uma função estatal",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene3"
		},
		"answer3": {
			"text": "",
			"indicators": {
				"social": 0,
				"economic": 0
			},
			"next": "scene3"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene3 = {
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
			"next": "scene4"
		},
		"answer2": {
			"text": "Aumentar a burocracia para apresentação dos projetos de lei",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene4"
		},
		"answer3": {
			"text": "Manter a burocracia para apresentação dos projetos de lei",
			"indicators": {
				"social": 0,
				"economic": 0
			},
			"next": "scene4"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene4 = {
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
			"next": "scene5"
		},
		"answer2": {
			"text": "Ele será julgado pelo STF como forma de proteger sua função de Estado",
			"indicators": {
				"social": 5,
				"economic": 5
			},
			"next": "scene5"
		},
		"answer3": {
			"text": "Ele não deve ser julgado e devemos arquivar o caso",
			"indicators": {
				"social": 10,
				"economic": 10
			},
			"next": "scene5"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

func _ready():
	# Iniciar os indicadores (50%)
	$economic_indicator.text = String(50)
	$social_indicator.text = String(50)
	
	# Definir a cena atual
	actualScene = scene1
	
	# Atribui e Renderiza os elementos de texto com base na cena atual 
	$title.text = actualScene.title
	$law_explanation.text = actualScene.lawExplanation
	$question.text = actualScene.question
	$answer1_button.text = actualScene.answers.answer1.text
	$answer2_button.text = actualScene.answers.answer2.text 
	$answer3_button.text = actualScene.answers.answer3.text

# Função chamada quando o jogador escolher a opção 1
func _on_answer1_button_pressed():
	# Atualiza o valor dos indicadores com base na escolha da cena
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
	
	#se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Impeachment.tscn")
		
	$economic_indicator.text = String(economicIndicator)
	$social_indicator.text = String(socialIndicator)
	
	# Verifica qual cena é a próxima com base na resposta da cena atual
	if actualScene.answers.answer1.next == "scene2":
		actualScene = scene2
	elif actualScene.answers.answer1.next == "scene3":
		actualScene = scene3
	elif actualScene.answers.answer1.next == "scene4":
		actualScene = scene4
		
	
	
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
	$title.text = actualScene.title
	$law_explanation.text = actualScene.lawExplanation
	$question.text = actualScene.question
	$answer1_button.text = actualScene.answers.answer1.text
	$answer2_button.text = actualScene.answers.answer2.text 
	$answer3_button.text = actualScene.answers.answer3.text

# Função chamada quando o jogador escolher a opção 2
func _on_answer2_button_pressed():
	# Atualiza o valor dos indicadores com base na escolha da cena
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
		
	#se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Impeachment.tscn")
	
	$economic_indicator.text = String(economicIndicator)
	$social_indicator.text = String(socialIndicator)
	
	# Verifica qual cena é a próxima com base na resposta da cena atual
	if actualScene.answers.answer2.next == "scene2":
		actualScene = scene2
	elif actualScene.answers.answer2.next == "scene3":
		actualScene = scene3
	elif actualScene.answers.answer2.next == "scene4":
		actualScene = scene4
	
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
	$title.text = actualScene.title
	$law_explanation.text = actualScene.lawExplanation
	$question.text = actualScene.question
	$answer1_button.text = actualScene.answers.answer1.text
	$answer2_button.text = actualScene.answers.answer2.text 
	$answer3_button.text = actualScene.answers.answer3.text

# Função chamada quando o jogador escolher a opção 3
func _on_answer3_button_pressed():
	# Atualiza o valor dos indicadores com base na escolha da cena
	economicIndicator += actualScene.answers.answer3.indicators.economic
	socialIndicator += actualScene.answers.answer3.indicators.social
	if economicIndicator >= 100:
		economicIndicator = 100
	if socialIndicator >= 100:
		socialIndicator = 100
	if economicIndicator <= 0:
		economicIndicator = 0
	if socialIndicator <= 0:
		socialIndicator = 0
		
	#se algum dos indicadores é zerado, a cena de impeachment é chamada
	if socialIndicator == 0 or economicIndicator == 0:
		get_tree().change_scene("res://Impeachment.tscn")
	
	$economic_indicator.text = String(economicIndicator)
	$social_indicator.text = String(socialIndicator)
	
	# Verifica qual cena é a próxima com base na resposta da cena atual
	if actualScene.answers.answer3.next == "scene2":
		actualScene = scene2
	elif actualScene.answers.answer3.next == "scene3":
		actualScene = scene3
	elif actualScene.answers.answer3.next == "scene4":
		actualScene = scene4
	
	
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
	$title.text = actualScene.title
	$law_explanation.text = actualScene.lawExplanation
	$question.text = actualScene.question
	$answer1_button.text = actualScene.answers.answer1.text
	$answer2_button.text = actualScene.answers.answer2.text 
	$answer3_button.text = actualScene.answers.answer3.text
