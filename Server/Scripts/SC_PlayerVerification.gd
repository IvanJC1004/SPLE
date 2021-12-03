extends Node

#Ready Variables
onready var mainInterface = get_node("/root/Server")
onready var playerContainerScene = preload("res://Scenes/Instances/PlayerContainer.tscn")

#Global Variables
var awaitingVerification = {}

#Principal Functions
func Start(playerId):
	awaitingVerification[playerId] = {"TimeStamp": OS.get_unix_time()}
	mainInterface.FetchToken(playerId)

#Token Functions
func Verify(playerId, username, token):
	print("Verifying")
	var tokenVerification = false
	while OS.get_unix_time() - int(token.right(64)) <=30:
		if mainInterface.expectedTokens.has(token):
			tokenVerification=true
			print("Successful Verification")
			createPlayerContainer(playerId, username)
			awaitingVerification.erase(playerId)
			break
		else:
			yield(get_tree().create_timer(2), "timeout")
	mainInterface.ReturnTokenVerificationResults(playerId, tokenVerification)
	if tokenVerification == false:
		print("Failed Verification")
		awaitingVerification.erase(playerId)
		mainInterface.network.disconnect_peer(playerId)

func _on_VerificationExpiration_timeout_SC():
	var currentTime = OS.get_unix_time()
	var startTime
	if awaitingVerification == {}:
		pass
	else:
		for key in awaitingVerification.keys():
			startTime = awaitingVerification[key].TimeStamp
			if currentTime - startTime >= 10:
				awaitingVerification.erase(key)
				var connectedPeers = Array(get_tree().get_network_connectedPeers())
				if connectedPeers.has(key):
					mainInterface.ReturnTokenVerificationResults(key, false)
					mainInterface.network.disconnect_peer(key)

#Container Functions
func createPlayerContainer(playerId, username):
	var newPlayerContainer = playerContainerScene.instance()
	newPlayerContainer.name = str(playerId)
	get_node("/root/Server/Players/").add_child(newPlayerContainer, true)
	var playerContainer = get_node("/root/Server/Players/" + str(playerId))
	FillPlayerContainer(playerContainer, username)

func FillPlayerContainer(playerContainer, username):
	if username in ServerData.playerStats:
		playerContainer.playerStats = ServerData.playerStats[username]
	else:
		ServerData.WritingPlayerSats(username)
		ServerData.WritingQuiz(username)
		playerContainer.playerStats = ServerData.playerStats[username]
