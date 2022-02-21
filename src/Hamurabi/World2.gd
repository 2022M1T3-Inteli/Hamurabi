extends Node2D

var socialIndicator = 50
var economicIndicator = 50

var actualScene = "scene1"
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
	"title": "O QUE É UM DECRETO?",
	"lawExplanation": "MECANISMO QUE PERMITE QUE DECISÕES SEJAM TOMADAS ATRAVÉS DE UM SÓ DOS PODERES",
	"question": "O que é um decreto?",
	"answers": {
		"answer1": {
			"text": "Um novo livro de leis",
			"indicators": {
				"social": -50,
				"economic": -60
			},
			"next": "scene3"
		},
		"answer2": {
			"text": "Um mandato de prisão para o presidente",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene3"
		},
		"answer3": {
			"text": "Um mecanismo que permite um dos poderes à tomar decisões",
			"indicators": {
				"social": 100,
				"economic": 90
			},
			"next": "scene3"
		}
	}
}

var scene3 = {
	"title": "O QUE É UM?",
	"lawExplanation": "MECANISMO QUE VÉS DE UM SÓ DOS PODERES",
	"question": "O que é um decreto?",
	"answers": {
		"answer1": {
			"text": "Um novo leis",
			"indicators": {
				"social": -50,
				"economic": -60
			},
			"next": "scene4"
		},
		"answer2": {
			"text": "Um mandato presidente",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene4"
		},
		"answer3": {
			"text": "Um mar de decisões",
			"indicators": {
				"social": 100,
				"economic": 90
			},
			"next": "scene4"
		}
	}
}

var scene4 = {
	"title": "O QUE É UM PRESIDENTE?",
	"lawExplanation": "PRESIDENTE",
	"question": "O que é um presidente",
	"answers": {
		"answer1": {
			"text": "slslslslslls",
			"indicators": {
				"social": -50,
				"economic": -60
			},
			"next": "scene5"
		},
		"answer2": {
			"text": "kkkkkkkkkkkkkkkkkkkkkk",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene5"
		},
		"answer3": {
			"text": "wpwppwpwpwpwppwpwpwppw",
			"indicators": {
				"social": 100,
				"economic": 90
			},
			"next": "scene5"
		}
	}
}

var scene5 = {
	"title": "A lei do consumidor",
	"lawExplanation": "Consumo é...",
	"question": "O que é um presidente",
	"answers": {
		"answer1": {
			"text": "Criar lei do consumidor",
			"indicators": {
				"social": 5,
				"economic": -10
			},
			"next": "scene6"
		},
		"answer2": {
			"text": "kkkkkkkkkkkkkkkkkkkkkk",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene6"
		},
		"answer3": {
			"text": "wpwppwpwpwpwppwpwpwppw",
			"indicators": {
				"social": 100,
				"economic": 90
			},
			"next": "scene6"
		}
	}
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
