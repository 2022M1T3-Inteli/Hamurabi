extends Node2D

onready var renataAnimation = [
	load("res://Assets/Public/Renata Animation 3.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 2.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 1.png"),
]

onready var background = [
	load("res://Assets/Public/Background.png"),
	load("res://Assets/Public/Park Day.jpg"),
	load("res://Assets/Public/Park Night.jpg"),
] 

var timeAnimation = 0
var currentAnimation = 0

# Variáveis dos indicadores que variam de acordo com as escolhas 
var congressIndicator = 50
var socialEconomicIndicator = 50

# Variáveis do tempo decorrido do mandato
var numScenes = 13
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
var paused = false
var loseGame = false

#variável que define se o gregório precisa aparecer
var gregorioScene = true
var gregorioSceneRun = false
var proposalAccepted = false
var gregorioSceneIndex = 14

# Cria um array de dicionários para guardar todos os valores de uma cena
var scenes = [
	{
		"title": "Separação ou concentração dos poderes",
		"text": [
			"Enquanto presidente, você percebe que existem diversas funções a serem realizadas para o melhor desempenho da nação.",
			"De acordo com o filósofo francês Montesquieu, quando os poderes estão concentrados em uma mesma pessoa, não existe garantia de liberdade para os governados.",
			"Sua primeira tarefa como presidente é criar um estado democrático para todos, como você alocaria os poderes para conseguir esse objetivo?"
		],
		"answers": {
			"answer1": {
				"text": "Manter o poder de decisões políticas apenas em suas mãos",
				"consequence": {
					"text": [
						"Ao concentrar o poder apenas em suas mãos, você não está agindo democraticamente. O povo vai às ruas protestando e tem o apoio do Congresso.",
						"Percebendo o que fez, você decide voltar à estrutura de Três Poderes."
					],
				},
				"indicators": {
					"congress": -20,
					"socialEconomic": -20
				},
				"next": 2
			},
			"answer2": {
				"text": "Separar os poderes e cada poder terá uma função estatal",
				"consequence": {
					"text": [
						"Ao separar os poderes, você evitou a centralização de poder e fez com que a organização do país se tornasse mais democrática, deixando outros políticos e a população com poder de escolha.",
					],
				},
				"indicators": {
					"congress": 10,
					"socialEconomic": 10
				},
				"next": 2
			},
		},
		"background": 0,
		"image": "President.png", 
	},
	{
		"title": "Quociente Eleitoral",
		"text": [
			"Em um Municipio do Rio Grande do Sul, um candidato a vereador foi o mais votado da eleição superando todos os adversários, porem não foi eleito.",
			"Muitas pessoas que votaram nele estão fazendo publicações nas redes sociais afirmando que as urnas estão fraudadas.",
			"Precisamos de um posicionamento seu à respeito do caso, pois ele está tomando grandes proporções nas redes sociais.",
			"Presidente, sua equipe sabia como as eleições funcionavam e já escreveram isso na nova constituição.",
			"Você quer ocupar seu tempo explicando para o povo porque isso acontece e que é de acordo com a constituição ou prefere que os próprios cidadãos corram atrás de respostas?",
		],
		"answers": {
			"answer1": {
				"text": "Explicar porque é de acordo com a lei",
				"consequence": {
					"text": [
						"Você designou uma equipe para explicar para a população sobre o Quociente Eleitoral. Como resultado, a maioria do povo se acalmou e deixou o restante dos políticos em paz quanto a isso.",
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": -15
				},
				"next": 3
			},
			"answer2": {
				"text": "Não perder tempo dando explicações ",
				"consequence": {
					"text": [
						"A população não fica contente, pois não recebeu satisfação dos políticos.",
						"Algumas pessoas foram às ruas pedindo impeachment, mas sua escolha não se enquadra como crime de responsabilidade.",
						"O Congresso, por sua vez, não se sentiu afetado por sua decisão."
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": -15
				},
				"next": 3
			},
		},
		"background": 0,
		"image": "President.png", 
	},
	{
		"title": "O que é a CLT?",
		"text": [
			"Presidente, ainda não construímos a parte da Constituição que garante direitos aos trabalhadores! Estamos recebendo denúncias de jornadas de trabalhos muito extensas e outros abusos.",
			"Você prefere recriar a CLT ou atender as reclamações que chegaram aos nossos escritórios individualmente?",
		],
		"answers": {
			"answer1": {
				"text": "Criar leis trabalhistas universais",
				"consequence": {
					"text": [
						"Ao recriar a Consolidação, trabalhadores agora se sentem mais seguros para sua jornada de trabalho, o que baixou a taxa de desemprego e melhorou a economia.",
						"O Congresso, por sua vez, ficou satisfeito com sua escolha e aprovou essa legislação."
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": 10
				},
				"next": 4
			},
			"answer2": {
				"text": "Atender apenas a essas reclamações individuais e nada mais",
				"consequence": {
					"text": [
						"A maior parte da população continua sofrendo abusos, pois você lidou apenas com uma pequena parcela das reclamações.",
						"O povo vai às ruas pedindo mais segurança no trabalho e, vendo isso, o Congresso toma frente e cria algumas leis trabalhistas, mas não tão eficazes como antes."
					],
				},
				"indicators": {
					"congress": -5,
					"socialEconomic": -15
				},
				"next": 4
			},
		},
		"background": 0,
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
				"text": "Criar uma PEC referente à compra de votos",
				"consequence": {
					"text": [
						"Ao atender ao pedido criando uma PEC, seu apoio popular aumentou. O Congresso, por sua vez, não teve trabalho a mais, pois a aprovação da PEC foi para o Plenário.",
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 10
				},
				"next": 5
			},
			"answer2": {
				"text": "Sugerir que a população crie um abaixo assinado para criar uma lei",
				"consequence": {
					"text": [
						"A população conseguiu assinaturas suficientes para transformar a petição pública em lei.",
						"O Congresso votou a favor para não perder o apoio popular, mas alguns políticos não pareciam tão animados com a aprovação."
					],
				},
				"indicators": {
					"congress": -5,
					"socialEconomic": 10
				},
				"next": 5
			},
		},
		"background": 1,
		"image": "President.png"
	},
	{
		"title": "Foro privilegiado",
		"text": [
			"Presidente, estamos com um grave problema: um deputado federal está sendo acusado de receber propina para votar projetos de leis por interesses pessoais.",
			"Ele alega que deve ser julgado pelo Supremo Tribunal Federal, para que não haja perseguição por estar em uma função pública.",
			"Após ouvir suas declarações, qual seria a medida tomada pelo senhor?"
		],
		"answers": {
			"answer1": {
				"text": "Ele deve ser julgado pela justiça comum",
				"consequence": {
					"text": [
						"Ao escolher que o deputado seja julgado pela justiça comum, a população apoiou sua decisão.",
						"O Congresso, por sua vez, queria que o deputado fosse julgado pelo STF, o que não os deixou satisfeitos com sua decisão.",
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 10
				},
				"next": 6
			},
			"answer2": {
				"text": "Ele será julgado pelo STF como forma de proteger sua função de Estado",
				"consequence": {
					"text": [
						"Ao escolher que o deputado seja julgado pelo STF, a população não ficou satisfeita com sua decisão, pois queria ele fora política",
						"Já o Congresso, por jogos políticos, ficou satisfeito com sua decisão."
					],
				},
				"indicators": {
					"congress": 5,
					"socialEconomic": -15
				},
				"next": 6
			},
		},
		"background": 1,
		"image": "President.png"
	},
	{
		"title": "Nível do Governo Municipal",
		"text": [
			"Presidente, a população está reclamando sobre o lixo deixado nas ruas e a falta de transporte público fornecido.",
			"De quem você, como presidente, deve cobrar resultados?",
		],
		"answers": {
			"answer1": {
				"text": "Cobrar das prefeituras de cada cidade",
				"consequence": {
					"text": [
						"Ao cobrar dos governos municipais, você responsabilizou as pessoas corretas para resolverem a situação. Os problemas de lixo e transporte foram resolvidos com agilidade.",
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 10
				},
				"next": 7
			},
			"answer2": {
				"text": "Cobrar os governadores estaduais ",
				"consequence": {
					"text": [
						"Ao cobrar governos estaduais, você estava exigindo resultados de pessoas que não tinham essa responsabilidade.",
						"Os problemas de lixo e transporte foram resolvidos, pois foram endereçados aos governos municipais, mas demorou mais do que deveria."
					],
				},
				"indicators": {
					"congress": -15,
					"socialEconomic": 5
				},
				"next": 7
			},
		},
		"background": 1,
		"image": "President.png"
	},
	{
		"title": "Asilo Político",
		"text": [
			"Um ex funcionário do Governo da Angola está sendo perseguido pelo governo de seu país por fazer criticas ao atual governo.",
			"Sua equipe analisou o caso e o angolano não cometeu crime algum e possui a ficha limpa em seu país de origem.",
			"Qual seria a sua conduta? Aceitar ou recusar ele?",
		],
		"answers": {
			"answer1": {
				"text": "Aceitar asilo",
				"consequence": {
					"text": [
						"Sua decisão foi muito elogiada nas redes sociais, já que o evento gerou proporções internacionais e estava sendo acompanhado por pessoas do mundo todo.",
						"Isso também fez com que alguns países enviassem cartas parabenizando a sua atitude."
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 5
				},
				"next": 8
			},
			"answer2": {
				"text": "Recusar asilo",
				"consequence": {
					"text": [
						"O assunto ganhou notoriedade nas redes sociais e a populção não apoiou da sua decisão de recusar o exilado, afetando assim a sua popularidade.",
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": -15
				},
				"next": 8
			},
		},
		"background": 2,
		"image": "President.png"
	},
	{
		"title": "Fundo eleitoral",
		"text": [
			"Você como presidente pretende fazer uma campanha de reeleição a presidencia do pais e precisa de recursos.",
			"Uma empresa multinacional decide auxilia-lo financeiramente no processo de candidatura.",
			"Qual seria a sua conduta?"
		],
		"answers": {
			"answer1": {
				"text": "Aceitar a doação de recursos",
				"consequence": {
					"text": [
						"Ao aceitar a verba da iniciativa privada, você cometeu uma ilegalidade.",
						"A população foi às ruas pedindo impeachment, mas isso não se enquadrou como crime de responsabilidade, sendo assim o processo de impeachment não foi iniciado.",
						"O Congresso, por sua vez, não conseguiu fazer a vontade pedida pelo povo, o que diminuiu a aprovação popular."
						
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 5
				},
				"next": 9
			},
			"answer2": {
				"text": "Recusar a doação de recursos",
				"consequence": {
					"text": [
						"Ao recusar a doação de recursos, você evitou cometer um crime. Isso passou despercebido pela população, mas seu governo perdeu o apoio da empresa que queria fornecer verba para sua candidatura",
						"o que afetou o Congresso negativamente, pois vários políticos tinham acordos firmados com essa empresa."
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 10
				},
				"next": 9
			},
		},
		"background": 2,
		"image": "President.png"
	},
	{
		"title": "Nível de governo estadual",
		"text": [
			"Presidente, estamos pagando muitos impostos em cima de nossos veículos e as rodovias que ligam nossas cidades estão horríveis.", 
			"Estamos gastando muito dinheiro em pneus por causa de todos os buracos das estradas! Se você é presidente do povo, faça algo para melhorar isso.",	
			"De quem você, como presidente, deve cobrar resultados?"
		],
		"answers": {
			"answer1": {
				"text": "Cobrar resultado de vereadores municipais",
				"consequence": {
					"text": [
						"Ao cobrar resultado da esfera municipal, você estava exigindo resultados de pessoas que não tinham essa responsabilidade.",
						" Os problemas nas rodovias foram resolvidos, pois foram endereçados aos governos estaduais, mas demorou mais do que deveria."
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 5
				},
				"next": 10
			},
			"answer2": {
				"text": "Cobrar resultado de prefeitos municipais",
				"consequence": {
					"text": [
						"A cobrança de resultado do governo estadual foi um acerto em cheio. Os políticos se movimentaram mais para consertar os problemas que a população estava reclamando.",
						"O Congresso, por ser formado por políticos da esfera estadual, não ficou tão contente com isso, mesmo você tendo tomado a decisão correta."
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": 10
				},
				"next": 10
			},
		},
		"background": 2,
		"image": "President.png"
	},
	{
		"title": "Congresso Nacional",
		"text": [
			"Presidente, a população acredita que alguns dos parlamentares que fazem parte do Congresso Nacional não merecem estar nessa posição.",
			"A única forma de alterar isso é através de uma reforma nos atuais mecanismos políticos.",
			"Você prefere verificar caso a caso e tomar as medidas necessárias para remover os ocupantes do cargo, caso não cumpram os requisitos necessários?"
		],
		"answers": {
			"answer1": {
				"text": "Verificar cada caso",
				"consequence": {
					"text": [
						"Ao escolher fazer uma investigação, os membros do Congresso se sentem ameaçados, mas a população fica satisfeita por ter atendido seus pedidos.",
					],
				},
				"indicators": {
					"congress": -15,
					"socialEconomic": 10
				},
				"next": 11
			},
			"answer2": {
				"text": "Ignorar o pedido",
				"consequence": {
					"text": [
						"Ao escolher não inciar uma investigação, a população fica descontente, mas o Congresso fica satisfeito ao não ser alvo de investigações.",
					],
				},
				"indicators": {
					"congress": 10,
					"socialEconomic": -15
				},
				"next": 11
			},
		},
		"background": 0,
		"image": "President.png"
	},
	{
		"title": "Medida Provisória",
		"text": [
			"Presidente, uma parcela da população acredita que não é necessário a obrigatoriedade do título de eleitor para poder votar,",
			"apenas um documento de identificação como RG ou CPF, visto que muitos adolescentes menores de idade não possuem esse documento.",
			"A população acredita que é necessária uma medida provisória para poder permitir que os adolescentes votem sem o título de eleitor, assim tornando o processo mais democrático.",
			"Deseja criar uma MP, ou seja, Medida Provisória, para que adolescentes que não possuem título de eleitor possam votar apenas utilizando RG ou CPF ou  deseja manter o antigo sistema de votação?"
		],
		"answers": {
			"answer1": {
				"text": "Criar MP",
				"consequence": {
					"text": [
						"A MP foi criada e ficou em regimento por 60 dias, mas como não haviam eleições nesse período, de pouco adiantou",
						"A população reconheceu seu esforço, mas não achou uma maneira eficaz. O Congresso, por sua vez, vetou que a MP se tornasse um lei vigente.",
					],
				},
				"indicators": {
					"congress": -15,
					"socialEconomic": 5
				},
				"next": 12
			},
			"answer2": {
				"text": "Manter as leis como estão",
				"consequence": {
					"text": [
						"A troca de ministros no meio do governo gera instabilidade social, pois o novo ministro contratado não tem tanta simpatia para com o povo.",
						"O Congresso, por sua vez, fica neutro a sua decisão."
					],
				},
				"indicators": {
					"congress": 10,
					"socialEconomic": -10
				},
				"next": 12
			},
		},
		
		"background": 0,
		"image": "President.png"
	},
	{
		"title": "Decretos",
		"text": [
			"Presidente, recentemente muitos ministros têm abandonado seus respectivos cargos, alegando que não possuem autonomia o suficiente para tomar suas próprias decisões.",
			"Esse foi o caso do ministro da educação, que abandonou a posição na última semana. Você encontrou a substituta perfeita para o cargo e fez uma proposta.",
			"Ela disse que aceita a proposta mas com uma condição: ter total liberdade para fazer sempre o que é melhor para a população sem interferência externa.",
			"Deseja contratá-la imediatamente e permitir autonomia, agindo sempre de acordo com o que for melhor para a educação do país",
			"ou deseja procurar outra pessoa para o cargo que obedeça sempre à ordens superiores?"
		],
		"answers": {
			"answer1": {
				"text": "Contratá-la imediatamente",
				"consequence": {
					"text": [
						"A população achou muito coerente a contratação da nova ministra, pois acredita que ela tem as melhores intenções em mente.",
						"O Congresso, por sua vez, não foi tão apoiador de tanta liberdade para escolhas políticas.",
					],
				},
				"indicators": {
					"congress": -5,
					"socialEconomic": 10
				},
				"next": 13
			},
			"answer2": {
				"text": "Não contratar",
				"consequence": {
					"text": [
						"A pequena parcela da população que queria o direito a voto sem título ficou descontente. O Congresso, por sua vez, concordou com a decisão de não alterar a estrutura de votação.",
					],
				},
				"indicators": {
					"congress": -15,
					"socialEconomic": 0
				},
				"next": 13
			},
		},
		
		"background": 0,
		"image": "President.png"
	},
	{
		"title": "",
		"text": [],
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
				"next": 14
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
				"next": 14
			},
		},
		
		"background": 0,
		"image": "President.png"
	},
	{
		"title": "Proposta do Gregorio",
		"text": [
			"Sabemos que as coisas estão indo de mau a pior. Faça o que deveria ter feito desde o início...",
			"Eu tenho uma proposta para você.",
			"Deixe que eu tome as decisões a partir de agora, farei com que as coisas mudem para melhor."
		],
		"answers": {
			"answer1": {
				"text": "Aceitar trabalhar para o Gregorio",
				"consequence": {
					"text": [
						"Você será um grande ativo!",
						"Se veremos novamente."
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": -10
				},
				"next": null
			},
			"answer2": {
				"text": "Recusar proposta de Gregorio",
				"consequence": {
					"text": [
						"Então você se entrega tão fácil...",
						"Vamos ver até onde você irá chegar."
					],
				},
				"indicators": {
					"congress": 0,
					"socialEconomic": 0
				},
				"next": null
			},
		},
	},
#	{
#		"title": "Gregorio Proposta",
#		"text": [
#			"Você está perdendo poder, seus indicadores estão baixos e caso você os zere, será iniciado um processo de Impeachmeant contra você. E é isso o que nós, sua oposição, queremos!",
#		],
#		"characterName": "Gregório - Jogador opositor",
#	},
		{
			"title": "Processo de Impeachment",
			"text": [
				"Haha presidente, tenho observado sua gestão e percebi que não está tendo retorno positivo em suas escolhas. Isso não é só um aviso!", 
				"Presidente, você está sendo julgado por diversos crimes de responsabilidade, decorrentes de suas escolhas até o momento. Esses crimes podem levá-lo a uma situação de Impeachment.",
				"Abaixo estão listados alguns casos desses possíveis crimes, peço para que selecione um deles, por favor."
			],
			"answers": {
				"answer1": {
					"text": "Ser contra a existência da União",
					"consequence": {
						"text": [
							"Presidente, suas escolhas até aqui abriram um pedido de Impeachment contra você, seus indicadores foram uma das maneiras para te alertar isso, porém o processo de Impeachment é algo bem amplo e a escolha da cena anterior iniciou o processo.",
							"Após uma análise feita pelo Congresso, o procedimento de Impeachment foi efetivado e agora você terá que ficar inelegível por um período de 8 anos, mas mesmo assim espero que tenha sido uma experiência engrandecedora e que tenha aprendido mais sobre política nessa jornada."
						],
					},
					"indicators": {
						"congress": 0,
						"socialEconomic": 0
					},
					"next": null
				},
				"answer2": {
					"consequence": {
						"text": [
							"Ser contra a segurança",
						],
					},
				"indicators": {
					"congress": 0,
					"socialEconomic": 0
				},
				"next": null
			},
			"background": 0,
			"image": "President.png"
			},
		}
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
	timeAnimation += delta
	if time >= 0.5:
		startDialogue = true
	if startDialogue:
		if !nextDialogue and time >= 0.01 and charActualIndex < charTextSize and !paused:
			$VBoxContainer/Dialogue/DialogueLabel.text += actualScene.text[actualText][charActualIndex]
			charActualIndex += 1
			if time >= 0.03:
				$Keyboard.play()
				time = 0
			
			if timeAnimation >= 0.15:
				if currentAnimation < len(renataAnimation):
					$Background/Renata.texture = renataAnimation[currentAnimation]
					currentAnimation += 1
					timeAnimation = 0
				else:
					currentAnimation = 0
					timeAnimation = 0
		if charActualIndex == charTextSize:
			currentAnimation = 0
			$Background/Renata.texture = renataAnimation[currentAnimation]
			timeAnimation = 0
			if actualText != len(actualScene.text) - 1:
				$VBoxContainer/Dialogue/DialogueButton.visible = true
				# Define que já pode passar de dialogo
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
	if Input.is_action_just_pressed("ui_cancel"):
		openMenu()
	
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
#	if  congressIndicator == 0 or socialEconomicIndicator == 0:
#		loseGame = true
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
#		actualScene = scenes[-1]
		
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
#		loseGame = true
		get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
#		actualScene = scenes[-1]
	
	$CongressBar.value = congressIndicator
	$SocialEconomicBar.value = socialEconomicIndicator
	$CongressBar/CongressValue.text = String(congressIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(socialEconomicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()

	# Verifica qual cena é a próxima com base na resposta da cena atual
	showExplication(actualScene.answers.answer2)
	
func _on_Dialogue_pressed():
	nextDialogue()

func nextDialogue():
	currentAnimation = 0
	$Background/Renata.texture = renataAnimation[currentAnimation]
	time = 0
	$VBoxContainer/Dialogue/DialogueButton.visible = false
	# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
	if !nextDialogue:
		$VBoxContainer/Dialogue/DialogueLabel.text = actualScene.text[actualText]
		nextDialogue = true
		if actualText != len(actualScene.text) - 1:
			$VBoxContainer/Dialogue/DialogueButton.visible = true
		else:
			if !consequenceScene:
				$Choice1.visible = true
				$Choice2.visible = true
			else:
				$VBoxContainer/Dialogue/DialogueButton.visible = true
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
			if loseGame:
				nextScene()
			if consequenceScene:
				nextScene()
			else:
				$Choice1.visible = true
				$Choice2.visible = true
	
func showExplication(answer):
	if gregorioSceneRun and !loseGame:
		actualScene = nextScene
		nextScene()
	else:
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

#func gregorioScene():
	
func nextScene():
	currentAnimation = 0
	# Se algum dos indicadores forem menor ou igual a 20, o personagem Gregório irá aparecer
#	if congressIndicator <= 20 and gregorioScene or socialEconomicIndicator <= 20 and gregorioScene:
#		gregorioSceneRun = true
#		gregorioScene = false
#		$Background/Renata.visible = false
#		$Background/Gregorio.visible = true
#	else:
#		gregorioSceneRun = false
#		$Background/Renata.visible = true
#		$Background/Gregorio.visible = false

	if gregorioSceneRun and !loseGame:
		actualScene = scenes[gregorioSceneIndex - 1]
	else:	
		if !loseGame:
			actualScene = nextScene
			actualScene = scenes[nextScene - 1]
			$Background.texture = background[actualScene.background]
		else: 
			get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
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
	openMenu()

func _on_CloseMenuButton_pressed():
	closeMenu()

func openMenu():
	$PauseMask.visible = true
	$MenuInGameBg.visible = true
	$MenuInGame.visible = true
	$CloseMenuButton.visible = true
	$Click.play()
	paused = true

func closeMenu():
	$PauseMask.visible = false
	$MenuInGameBg.visible = false
	$MenuInGame.visible = false
	$CloseMenuButton.visible = false
	$Click.play()
	paused = false
	
func _on_DialogueButton_pressed():
	nextDialogue()

func _on_OptionsButton_pressed():
	pass # Replace with function body.

func _on_ExitButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
