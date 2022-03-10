extends Node2D

#variáveis dos indicadores que variam de acordo com as escolhas 
var economicIndicator = 50
var socialIndicator = 50

# Define a cena atual
var actualScene = "scene1"

# Cria um dicionário para guardar todos os valores de uma cena (a estrutura se repete várias vezes ao longo do código)


var scene1 = {
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
			"text": "",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene3"
		},
		"answer3": {
			"text": "Separar os poderes e cada poder terá uma função estatal",
			"indicators": {
				"social": 5,
				"economic": -5
			},
			"next": "scene2"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene2 = {
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
			"next": "scene3"
		},
		"answer2": {
			"text": "Deixar o país sem lei dos trabalhadores",
			"indicators": {
				"social": -5,
				"economic": -5
			},
			"next": "scene3"
		},
		"answer3": {
			"text": "Criar outra lei",
			"indicators": {
				"social": 5,
				"economic": -5
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
			"next": "scene5"
		},
		"answer2": {
			"text": "Ele será julgado pelo STF como forma de proteger sua função de Estado",
			"indicators": {
				"social": -5,
				"economic": 5
			},
			"next": "scene5"
		},
		"answer3": {
			"text": "Ele não deve ser julgado e devemos arquivar o caso",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene5"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene5 = {
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
			"next": "scene6"
		},
		"answer2": {
			"text": "",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene6"
		},
		"answer3": {
			"text": "Aceitar a proposta",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene6"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene6 = {
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
			"next": "scene7"
		},
		"answer2": {
			"text": "Cobrar os governadores estaduais",
			"indicators": {
				"social": -10,
				"economic": 0
			},
			"next": "scene7"
		},
		"answer3": {
			"text": "Cobrar deputados estaduais",
			"indicators": {
				"social": -10,
				"economic": 0
			},
			"next": "scene7"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene7 = {
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
			"next": "scene8"
		},
		"answer2": {
			"text": "",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene8"
		},
		"answer3": {
			"text": "Recusar Asilo",
			"indicators": {
				"social": -10,
				"economic": 0
			},
			"next": "scene8"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene8 = {
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
			"next": "scene9"
		},
		"answer2": {
			"text": "Recusar a doação de recursos",
			"indicators": {
				"social": 0,
				"economic": 0
			},
			"next": "scene9"
		},
		"answer3": {
			"text": "Aceitar a doação e declarar para as autoridades os valores recebidos",
			"indicators": {
				"social": -10,
				"economic": 0
			},
			"next": "scene9"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene9 = {
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
			"next": "scene10"
		},
		"answer2": {
			"text": "Cobrar resultado de prefeitos municipais",
			"indicators": {
				"social": -10,
				"economic": 0
			},
			"next": "scene10"
		},
		"answer3": {
			"text": "Cobrar resultado de governadores estaduais",
			"indicators": {
				"social": 15,
				"economic": 0
			},
			"next": "scene10"
		}
	},
	"background": "background.jpg",
	"image": "President.png"
}

var scene10 = {
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
			"next": "scene6"
		},
		"answer2": {
			"text": "",
			"indicators": {
				"social": -10,
				"economic": -10
			},
			"next": "scene6"
		},
		"answer3": {
			"text": "",
			"indicators": {
				"social": 0,
				"economic": 0
			},
			"next": "scene6"
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
	elif actualScene.answers.answer1.next == "scene5":
		actualScene = scene5
	elif actualScene.answers.answer1.next == "scene6":
		actualScene = scene6
	elif actualScene.answers.answer1.next == "scene7":
		actualScene = scene7
	elif actualScene.answers.answer1.next == "scene8":
		actualScene = scene8
	elif actualScene.answers.answer1.next == "scene9":
		actualScene = scene9
	
	if actualScene.answers.answer2.text == "":
		$answer2_button.visible = false
	else:
		$answer2_button.visible = true
	
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
	elif actualScene.answers.answer2.next == "scene5":
		actualScene = scene5
	elif actualScene.answers.answer2.next == "scene6":
		actualScene = scene6
	elif actualScene.answers.answer2.next == "scene7":
		actualScene = scene7
	elif actualScene.answers.answer2.next == "scene8":
		actualScene = scene8
	elif actualScene.answers.answer2.next == "scene9":
		actualScene = scene9
		
	if actualScene.answers.answer2.text == "":
		$answer2_button.visible = false
	else:
		$answer2_button.visible = true
		
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
	elif actualScene.answers.answer3.next == "scene5":
		actualScene = scene5
	elif actualScene.answers.answer3.next == "scene6":
		actualScene = scene6
	elif actualScene.answers.answer3.next == "scene7":
		actualScene = scene7
	elif actualScene.answers.answer3.next == "scene8":
		actualScene = scene8
	elif actualScene.answers.answer3.next == "scene9":
		actualScene = scene9
	
	if actualScene.answers.answer2.text == "":
		$answer2_button.visible = false
	else:
		$answer2_button.visible = true
	
	# Define e renderiza os novos elementos de texto de acordo com a nova cena definida
	$title.text = actualScene.title
	$law_explanation.text = actualScene.lawExplanation
	$question.text = actualScene.question
	$answer1_button.text = actualScene.answers.answer1.text
	$answer2_button.text = actualScene.answers.answer2.text 
	$answer3_button.text = actualScene.answers.answer3.text


func _on_Button_pressed():
	get_tree().change_scene("res://Menu.tscn")
