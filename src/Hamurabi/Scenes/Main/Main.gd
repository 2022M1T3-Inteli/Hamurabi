extends Node2D

# Array com os caminhos de todas as imagens usadas para animação da Renata
# Repetições de imagens para prolongar o tempo de aparição da imagem sem usar código
onready var renataAnimation = [
	load("res://Assets/Public/Renata Animation 3.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 2.png"),	
	load("res://Assets/Public/Renata Animation 1.png"),
	load("res://Assets/Public/Renata Animation 3.png"),
	load("res://Assets/Public/Renata Animation 1.png"),
]

# Array com os caminhos dos background usados nas cenas
onready var background = [
	load("res://Assets/Public/Background.png"),
	load("res://Assets/Public/Park Day.jpg"),
	load("res://Assets/Public/Park Night.jpg"),
] 
onready var gregorioBackground = [
	[
		load("res://Assets/Public/Gregorio First Scene.png"),
	],
	[
		load("res://Assets/Public/Gregorio Seated 1.png"),
		load("res://Assets/Public/Gregorio Seated 2.png"),
		load("res://Assets/Public/Gregorio Seated 3.png"),
	],
	[
		load("res://Assets/Public/Gregorio Second Part 1.png"),
		load("res://Assets/Public/Gregorio Second Part 2.png"),
		load("res://Assets/Public/Gregorio Second Part 3.png"),
	]
]

# Define o tempo de animação percorrido
var timeAnimation = 0
# Define a animação atual
var currentAnimation = 0
var gregorioCurrentAnimation = 0

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
var nextSceneIndex = 0
# Define o Texto atual
var actualText = 0

# Armazenar o número de caracteres do texto.
var charTextSize = 0 
# Define o caractere atual que será utilizado para percorrer o texto.
var charActualIndex = 0

# Define o tempo atual
var time = 0
# Define a variável que guardará o tempo decorrido para o fade
var fadeTime = 0
# Variavel que servirá para controlar se já é possível iniciar o dialogo
var startDialogue = false
# Variavel que servirá para controlar se já é possível ir para o próximo dialogo
var nextDialogueReady = false
# Variavel que servirá para controlar se já estamos na cena de consequencia
var consequenceScene = false
# Variavel que servirá para controlar se já finalizou todos os dialogos da cena
var endDialogue = false
# Variavel que servirá para controlar se o jogo está pausado ou não
var paused = false
# Variavel que servirá para controlar se o jogador perdeu o game ou não
var loseGameRun = false
var loseGameFade = false
var loseGame = false
var lastFade = false

#variável que define se o gregório precisa aparecer
var gregorioScene = true
var gregorioSceneRun = false
var proposalAccepted = false
var gregorioSceneIndex = 14

# Cria um array de dicionários para guardar todos os valores de uma cena
# Cada dicionário é uma cena
	# title é o titulo da cena em questão
	# text são todos os textos que serão utlizados no dialogo, são separados em array para permitir a lógica de reproduzir o próximo dialogo
	# answers é um dicionário com as respostas da cena
		# answer1 e answer 2 são dicionários com a primeira e a segunda resposta da cena, possuem a mesma estrutura
			# text é o texto que será mostrado na resposta
			# consequence é um dicionário com um array dos textos a serem exibiidos no dialogo após a resposta
			# indicators é um dicionário que contém os valores que a resposta irá mudar nos indicadores de congresso e do socialeconomico
			# next é uma referencia para a próxima cena que será criada após a resposta escolhida
	# background é o índice que iremos usar para reproduzir o background correto da cena
	# image no futuro seria usado para trocar os personagens com base na cena
var scenes = [
	{
		"title": "Separação ou concentração dos poderes",
		"text": [
			"Enquanto presidente, você percebe que existem diversas funções a serem realizadas para o melhor desempenho da nação.",
			"De acordo com o filósofo francês Montesquieu, quando os poderes estão concentrados em uma mesma pessoa, não existe garantia de liberdade para os governados.",
			"Sua primeira tarefa como presidente é criar um estado democrático para todos, como você alocaria os poderes para conseguir esse objetivo?"
		],
		"lawExplanation": "Para que um Estado seja verdadeiramente democrático, as funções de criar, executar e julgar leis não devem se concentrar nas mãos de uma única pessoa, pois isso pode levar ao abuso de poder. Nesse sentido, o Estado brasileiro é formado por três poderes: Executivo, Legislativo e Judiciário. Administrar o Estado, definir as leis e executar e cuidar dos conflitos são as funções desses poderes, respectivamente.",
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
		"lawExplanation": "Isso ocorre porque deputados e vereadores são eleitos pelo sistema proporcional, ao passo que o presidente da República, governadores, senadores e prefeitos são escolhidos pelo sistema majoritário. No primeiro, os votos computados são os de cada partido ou coligação No segundo, quem obtiver mais votos sagra-se vencedor.",
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
					"socialEconomic": 10
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
		"lawExplanation": "CLT ou Consolidação das Lei do Trabalho é uma série de leis que visam proteger o trabalhador, regular as relações de trabalho e criar o direito processual do trabalho.",
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
		"lawExplanation": "No Brasil atual, há uma série de processos, para que haja a avaliação de um projeto de lei vindo da iniciativa popular, em que cerca de 1% da população brasileira (1.5 milhão de pessoas) precisa assinar para apresentar um projeto, distribuida por ao menos 5 Estados, com ao menos 30% de eleitores em cada um deles. Já a PEC (Proposta de Emenda Constitucional) serve para alterar algumas partes do texto constitucional sem convocar uma nova assembleia constituinte, mas só pode ser proposta por um terço dos deputados ou senadores, pelo Presidente ou mais da metade das Assembleias Legislativas das Unidades Federativas.",
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
					"congress": -15,
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
		"lawExplanation": "Na prática, uma ação penal contra uma autoridade pública – como os parlamentares – é julgada por tribunais superiores, diferentemente de um cidadão comum, julgado pela justiça comum. A justificativa é proteger o exercício da função ou do mandato público.",
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
					"congress": -15,
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
		"lawExplanation": "O nível de governo municipal. No nível municipal, estão os prefeitos e os vereadores, mas não há Judiciário, pois os fóruns locais estão sob a estrutura do Judiciário estadual.",
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
		"lawExplanation": "Para que uma pessoa possa ser considerada asilada política, é fundamental que ela esteja sendo perseguida por motivos políticos em seu país de origem. Para receber o benefício, o solicitante de asilo não pode ter cometido crime comum ou estar em aguardo de julgamento relacionado a um crime comum.",
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
					"congress": -10,
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
		"lawExplanation": "É um fundo público destinado a financiar campanhas eleitorais, o fundo eleitoral foi criado em 2017, pela lei 13.487. O total de recursos desse fundo é definido pela LOA(Lei Orçamentária Anual), que é uma das principais fontes de receita para campanhas eleitorais. O dinheiro é distribuído aos partidos seguindo alguns critérios, por exemplo, os partidos que possuem representantes na câmara e no senado devem receber as maiores quantias. De acordo com a lei, 30% do valor recebido por cada partido deve ser destinado para mulheres. Além disso, a distribuição deve ser proporcional ao total de candidatos negros apresentados para a disputa eleitoral.",
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
					"congress": -15,
					"socialEconomic": -20
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
					"socialEconomic": 0
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
		"lawExplanation": "Cabe ao governo estadual reparar as estradas que ligam cidades dentro de um estado - O governo estadual recolhe o IPVA (Imposto sobre a Propriedade de Veículos Automotores).",
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
					"congress": -15,
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
					"congress": -5,
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
		"lawExplanation": "O congresso é formado pelo senado e pela câmara dos deputados. O número de deputados que representam os estados varia de acordo com o número da população de cada estado. O mínimo são oito políticos por estado e o máximo são setenta. Por outro lado, são permitidos apenas 3 senadores por estado. O mandato dos senadores é de oito anos, o dobro dos deputados, que é de 4 anos. Apesar de o congresso ser constituído por duas casas, as duas possuem poderes diferentes. É só a câmara que pode, por exemplo, iniciar um processo contra o presidente. E é só o senado que pode processar e julgar esse processo.",
		"answers": {
			"answer1": {
				"text": "Verificar cada caso",
				"consequence": {
					"text": [
						"Ao escolher fazer uma investigação, os membros do Congresso se sentem ameaçados, mas a população fica satisfeita por ter atendido seus pedidos.",
					],
				},
				"indicators": {
					"congress": -10,
					"socialEconomic": -5
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
		"lawExplanation": "A medida provisória, conhecida pela sigla MP, é um instrumento que o presidente pode utilizar para criar leis. A MP pode ser criada pelo presidente e somente em situações de extrema relevância e urgência. A partir da data de criação, a MP passa a valer como uma lei pelo período de 60 dias. Durante esse período de 60 dias o Congresso Nacional confere se a lei atende aos requisitos de relevância e urgência, caso positivo, ela se torna uma lei permanente.",
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
					"congress": -10,
					"socialEconomic": -10
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
					"socialEconomic": 0
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
		"lawExplanation": "Decretos são atos administrativos de competência dos chefes do Poder Executivo em cada nível(ou seja, presidente, em nível federal, governadores, em nível estadual, e prefeitos, em nível municipal). Diferentemente das medidas provisórias, os decretos podem ser criados por qualquer chefe do Poder Executivo - e não apenas pelo Presidente da República. Geralmente um decreto é utilizado para nomear pessoas a cargos públicos ou para regulamentar leis. Algumas leis dependem de decretos para que possam ser cumpridas de forma efetiva: por vezes a lei estabelece o que deve ser feito, mas somente o decreto determina a forma como deve ser feito. O decreto tem, portanto, a função de detalhar a lei, regulamentando ou executando o que está disposto no texto.",
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
					"congress": 0,
					"socialEconomic": -10
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
		"lawExplanation": "",
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
			"Espero que dessa vez você tome a decisão correta... Eu tenho uma proposta para você. E essa é a sua última chance.",
			"Deixe que eu tome as decisões a partir de agora, farei com que as coisas mudem para melhor."
		],
		"lawExplanation": "",
		"answers": {
			"answer1": {
				"text": "Aceitar trabalhar para o Gregorio",
				"consequence": {
					"text": [
						"Você será um grande ativo!",
						"Nos veremos novamente."
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
		{
			"title": "Processo de Impeachment",
			"text": [
				"Haha presidente, tenho observado sua gestão e percebi que não está tendo retorno positivo em suas escolhas. Isso não é só um aviso!", 
				"Presidente, você está sendo julgado por diversos crimes de responsabilidade, decorrentes de suas escolhas até o momento. Esses crimes podem levá-lo a uma situação de Impeachment.",
				"Abaixo estão listados alguns casos desses possíveis crimes, peço para que selecione um deles, por favor."
			],
			"lawExplanation": "",
			"answers": {
				"answer1": {
					"text": "Ser contra a união",
					"consequence": {
						"text": [
							"Presidente, suas escolhas até aqui abriram um pedido de Impeachment contra você, seus indicadores foram uma das maneiras para te alertar isso.",
							"Porém o processo de Impeachment é algo bem amplo e a escolha da cena anterior iniciou o processo.",
							"Após uma análise feita pelo Congresso, o procedimento de Impeachment foi efetivado e agora você terá que ficar inelegível por um período de 8 anos.",
							"Mas mesmo assim espero que tenha sido uma experiência engrandecedora e que tenha aprendido mais sobre política nessa jornada."
						],
					},
					"indicators": {
						"congress": 0,
						"socialEconomic": 0
					},
					"next": null
				},
				"answer2": {
					"text": "Cometer crime de responsabilidade",
					"consequence": {
						"text": [
							"Presidente, suas escolhas até aqui abriram um pedido de Impeachment contra você, seus indicadores foram uma das maneiras para te alertar isso.",
							"Porém o processo de Impeachment é algo bem amplo e a escolha da cena anterior iniciou o processo.",
							"Após uma análise feita pelo Congresso, o procedimento de Impeachment foi efetivado e agora você terá que ficar inelegível por um período de 8 anos.",
							"Mas mesmo assim espero que tenha sido uma experiência engrandecedora e que tenha aprendido mais sobre política nessa jornada."
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
# Função chamada para abrir o menu, quando o nó entra na árvore de cenas
func _ready():
	if Global.menuOpen:
		openMenu()

	fadeOut()
	
	# Iniciar os indicadores em 50%
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
	
	$LawExplanation/LawExplanationText.text = actualScene.lawExplanation

func _process(delta):
	# Guarda o tempo decorrido no jogo, usado tanto para as cenas quanto para as animações
	time += delta
	timeAnimation += delta
	fadeTime += delta
	
	# Verifica se já passou meio segundo, inicia o dialogo
	if gregorioSceneRun:
		if fadeTime >= 0.4 and fadeTime <= 0.5:
			$Background/Renata.visible = false
			$VBoxContainer/Dialogue/CharacterName.text = "Gregório"
	elif !loseGameRun and !loseGame:
		if fadeTime >= 0.4 and fadeTime <= 0.5:
			$Background/Renata.visible = true
			$VBoxContainer/Dialogue/CharacterName.text = "Renata - Conselheira"
	else:
		if fadeTime >= 0.4 and fadeTime <= 0.5 and loseGameFade and !loseGame:
			$VBoxContainer/Dialogue/CharacterName.text = "Gregório"
			$Background/Renata.visible = false
			$Background/Gregorio.visible = true
			
			loseGameFade = false
			
	if time >= 0.5:
		startDialogue = true
		if lastFade:
			get_tree().change_scene("res://Scenes/Impeachment/Impeachment.tscn")
	
	if fadeTime >= 0.8 and !loseGameFade:
		$FadeBetweenScenes.visible = false
		$FadeOut.visible = false
		fadeTime = 0
		
	# Verifica se o dialogo já foi iniciado
	if startDialogue:
		# Verifica se já não está no próximo dialogo, se o tempo passou 0.01 segundos, se caractere atual é menor que tamanho do texto e se o jogo não está pausado
		if !nextDialogueReady and time >= 0.01 and charActualIndex < charTextSize and !paused:
			# Adiciona o caractere atual do texto para a caixa de dialogo
			$VBoxContainer/Dialogue/DialogueLabel.text += actualScene.text[actualText][charActualIndex]
			# Passa para o próximo caractere do texto
			charActualIndex += 1
			# Verifica se já passou 0.03 segundos
			if time >= 0.03:
				# Roda o áudio do teclado e zera o tempo decorrido
				$Keyboard.play()
				time = 0
			
			# Verifica se já passou 0.15 segundos
			if timeAnimation >= 0.15:
				# Verifica se a animção atual ainda é menor que o número de animações do personagem
				if !gregorioSceneRun:
					if currentAnimation < len(renataAnimation):
						# Define a animação atual
						$Background/Renata.texture = renataAnimation[currentAnimation]
						# Define a próxima animação e zera o tempo decorrido
						currentAnimation += 1
						timeAnimation = 0
					else:
						# Define a animação atual como a primeira novamente e zera o tempo decorrido
						currentAnimation = 0
						timeAnimation = 0
				else:
					if actualText == 0:
						$Background.texture = gregorioBackground[0][0]
					elif actualText == 1:
						if gregorioCurrentAnimation >= len(gregorioBackground[1]):
							gregorioCurrentAnimation = 0
						$Background.texture = gregorioBackground[1][gregorioCurrentAnimation]
						gregorioCurrentAnimation += 1
						timeAnimation = 0
					elif actualText == 2:
						if gregorioCurrentAnimation >= len(gregorioBackground[2]):
							gregorioCurrentAnimation = 0
						$Background.texture = gregorioBackground[2][gregorioCurrentAnimation]
						gregorioCurrentAnimation += 1
						timeAnimation = 0
					else:
						gregorioCurrentAnimation = 0
					
	
		# Verifica se caractere atual já é o último do texto atual, caso sim quer dizer que já escreveu todo o texto
		if charActualIndex == charTextSize:
			if gregorioSceneRun:
				$Background.texture = gregorioBackground[actualText][0]
			# Define a animação inicial do personagem, muda a textura e zera o tempo decorrido
			currentAnimation = 0
			$Background/Renata.texture = renataAnimation[currentAnimation]
			timeAnimation = 0
			# Verifica se ainda não chegou no último texto
			if actualText != len(actualScene.text) - 1:
				# Deixa visível o botão de próximo dialogo
				$VBoxContainer/Dialogue/DialogueButton.visible = true
				# Define que já pode passar de dialogo
				nextDialogueReady = true
			else:
				# Verifica se ainda não está na cena de consquencia da resposta
				if !consequenceScene:
					if !gregorioSceneRun:
						$InfoButton.visible = true
					# Deixa visíveis os botões de escolha
					$Choice1.visible = true
					$Choice2.visible = true
				else:
					# Deixa visível o botão de próximo dialogo e permite pular para a próxima cena
					$VBoxContainer/Dialogue/DialogueButton.visible = true
					nextDialogueReady = true
					
	# Verifica se a seta direita foi apertada
	if !lastFade:
		if Input.is_action_just_pressed("ui_right"):
			# Chama a função do próximo dialogo e zera o tempo decorrido
			nextDialogue()
			time = 0
	# Verifica se a tecla ESC foi apertada
	if Input.is_action_just_pressed("ui_cancel"):
		# Chama a função para abrir o menu in-game
		openMenu()
	
func fadeIn():
	$FadeIn.visible = true
	$FadeIn/FadeAnimation.play("Fade")	
	
func fadeBetweenScenes():
	$FadeBetweenScenes.visible = true
	$FadeBetweenScenes/FadeAnimation.play("Fade")	

func fadeOut():
	$FadeOut.visible = true
	$FadeOut/FadeAnimation.play("Fade")
	
# Função que chama a primera escolha ao clicar no botão
func _on_choice1_pressed():
	# Atualiza os dias de mandatos restantes e diminui o número de cenas restantes para o fim do jogo
	daysMandact -= sceneTime
	scenesLeft -= 1
	# Atualiza o valor dos indicadores com base na escolha da cena
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
	
	# Aplica o valor das variáveis nas labels apresentadas na tela
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
		
	# Aplica o valor das variáveis nas labels apresentadas na tela
	$CongressBar.value = congressIndicator
	$SocialEconomicBar.value = socialEconomicIndicator
	$CongressBar/CongressValue.text = String(congressIndicator) + "%"
	$SocialEconomicBar/SocialEconomicValue.text = String(socialEconomicIndicator) + "%"
	$MandateTime/MandateTimeValue.text = String(daysMandact) + " dias"
	$Click.play()

	# Verifica qual cena é a próxima com base na resposta da cena atual
	showExplication(actualScene.answers.answer2)
	
# Função que chama a função de troca de dialogo quando clicar no dialogo
func _on_Dialogue_pressed():
	nextDialogue()
	
# Função para chamar o próximo diálogo com a animação da personagem Renata
func nextDialogue():
	currentAnimation = 0
	$Background/Renata.texture = renataAnimation[currentAnimation]
	time = 0
	$VBoxContainer/Dialogue/DialogueButton.visible = false
	
	if !lastFade:
		# Verifica se ainda não chegou no último texto, caso sim preenche todo o texto e exibe o botão para pular de cena.
		if !nextDialogueReady:
			if gregorioSceneRun:
				$Background.texture = gregorioBackground[actualText][0]
				$VBoxContainer/Dialogue/CharacterName.text = "Gregório"
	#		fadeTime = 5
			$VBoxContainer/Dialogue/DialogueLabel.text = actualScene.text[actualText]
			nextDialogueReady = true
			if actualText != len(actualScene.text) - 1:
				$VBoxContainer/Dialogue/DialogueButton.visible = true
			else:
				if !consequenceScene:
					if !gregorioSceneRun and !loseGameRun:
						$InfoButton.visible = true
					$Choice1.visible = true
					$Choice2.visible = true
				else:
					$VBoxContainer/Dialogue/DialogueButton.visible = true
		# Caso não, verifica se ainda não é a última cena, se sim tira o botão de dialogo pois há mais cenas.
		else:
			if loseGameRun:
				$Background/Renata.visible = true
				$Background/Gregorio.visible = false
				$VBoxContainer/Dialogue/CharacterName.text = "Renata - Conselheira"
			if actualText < len(actualScene.text) - 1:
				$VBoxContainer/Dialogue/DialogueLabel.text = ""
				# Define o próximo texto do Array.
				actualText += 1
				charTextSize = len(actualScene.text[actualText])
				charActualIndex = 0
				time = 0
				nextDialogueReady = false
			# Caso tenha chegado no final, mostra os botões de escolha.
			else:
				if loseGameRun:
					loseGame = true
				if consequenceScene:
					nextScene()
				else:
					if !gregorioSceneRun:
						$InfoButton.visible = true
					$Choice1.visible = true
					$Choice2.visible = true
	
# Função para chamar o diálogo de explicação de cena e aplicar a estrutura de cada cena
func showExplication(answer):
		consequenceScene = true
		$VBoxContainer/Dialogue/DialogueLabel.text = ""
		time = 0
		startDialogue = false
		if !gregorioSceneRun:
			nextSceneIndex = answer.next
		actualScene = answer.consequence
		nextDialogueReady = false
		if !gregorioSceneRun:
			$InfoButton.visible = false
		$Choice1.visible = false
		$Choice2.visible = false
		charActualIndex = 0
		actualText = 0
		charTextSize = len (actualScene.text[actualText])

# Função utilizada para trocar de cena
func nextScene():
	if congressIndicator == 0 or socialEconomicIndicator == 0:
		actualText = 0
		charTextSize = len (scenes[-1].text[actualText])
		loseGameRun = true
	# Se algum dos indicadores forem menor ou igual a 20, o personagem Gregório irá aparecer
	elif congressIndicator <= 20 and gregorioScene or socialEconomicIndicator <= 20 and gregorioScene:
		gregorioSceneRun = true
		gregorioScene = false
		actualScene = scenes[-2]
	# Caso os indicadores sejam mais que 20%, continua na cena da Renata até chegar na cena final e aparecer a cena de vitória 
	else:
		gregorioSceneRun = false
	currentAnimation = 0
	if !loseGameRun and !gregorioSceneRun:
		actualScene = nextSceneIndex
		actualScene = scenes[nextSceneIndex - 1]
		$Background.texture = background[actualScene.background]
		
	consequenceScene = false
	time = 0
	startDialogue = false
	if !lastFade:
		fadeBetweenScenes()
	fadeTime = 0
	if scenesLeft == 0 and !loseGameRun:
		get_tree().change_scene("res://Scenes/Victory/Victory.tscn")
	else:
		if !lastFade:
			if !loseGame:
				$VBoxContainer/Dialogue/DialogueLabel.text = ""
			time = 0
			startDialogue = false
			nextDialogueReady = false
			# Se o usuário perder o jogo, a última cena é chamada com a aparição do personagem Gregório
			if loseGameRun:
				actualScene = scenes[-1]
				loseGameFade = true
			# Cena de Impeachemnt é chamada, após a aparição do personagem Gregório
			if loseGame:
				time = 0
				lastFade = true
				fadeIn()
			$Choice1/Text.text = actualScene.answers.answer1.text
			$Choice2/Text.text = actualScene.answers.answer2.text 
			$LawExplanation/LawExplanationText.text = actualScene.lawExplanation
			charActualIndex = 0
			actualText = 0
			charTextSize = len (actualScene.text[actualText])

# Função para chamar a função de abrir o menu in-game
func _on_ConfigurationButton_pressed():
	# Chama a função
	openMenu()

# Função para chamar a função de fechar o menu in-game ao clicar no botão
func _on_CloseMenuButton_pressed():
	# Chama a função
	closeMenu()

# Função que abre o menu quando chamada
func openMenu():
	# Deixa visivel a máscara que bloqueia o clique na tela
	$PauseMask.visible = true
	# Deixa visivel o menu in-game
	$MenuInGame.visible = true
	# Deixa visível o botão de fechar o menu in-game
	$CloseMenuButton.visible = true
	# Roda o som de clique
	$Click.play()
	# Coloca o jogo em pause
	paused = true

# Função que fecha o menu quando chamada
func closeMenu():
	# Deixa invisível a máscara que bloqueia o clique na tela
	$PauseMask.visible = false
	# Deixa invisível o menu in-game
	$MenuInGame.visible = false
	# Deixa invisível o botão de fechar o menu in-game
	$CloseMenuButton.visible = false
	# Roda o som de clique
	$Click.play()
	# Tira o jogo do pause
	paused = false

	
# Função que chama a função de troca de dialogo ao clicar no botão do diálogo
func _on_DialogueButton_pressed():
	nextDialogue()

# Função de options ainda não implementada
func _on_OptionsButton_pressed():
	pass # Replace with function body.

# Função chamada ao clicar no botão para voltar ao menu
func _on_BackToMenuButton_pressed():
	Global.menuOpen = false
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")

# Função chamada para aparecer a explicação da lei do botão de informações na caixa de diálogo
func _on_InfoButton_pressed():
	$LawExplanation.visible = true
	$CloseLawExplanationButton.visible = true
	$PauseMask.visible = true
	paused = true

# Função chamada para fechar a explicação de lei do botão de informação
func _on_CloseLawExplanationButton_pressed():
	$LawExplanation.visible = false
	$CloseLawExplanationButton.visible = false
	$PauseMask.visible = false
	paused = false
