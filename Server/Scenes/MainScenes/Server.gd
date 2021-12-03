extends Node

#Global Variables
var network = WebSocketServer.new()
var port
var expectedTokens = []

#Principal Functions
func _ready():
	StartServer()

#Server Functions
func StartServer():
	port = ServerData.serverData["serverPort"]
	network.listen(port, PoolStringArray(), true)
	get_tree().set_network_peer(network)
	print("Server Started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(playerId):
	print("User " + str(playerId)+ " Connected")
	ScPlayerVerification.Start(playerId)

func _Peer_Disconnected(playerId):
	print("User " + str(playerId)+ " Disconnected")
	get_node("/root/Server/Players/" + str(playerId)).queue_free()

#Time Functions
func _on_TokenExpiration_timeout():
	var currentTime = OS.get_unix_time()
	var tokenTime
	if expectedTokens == []:
		pass
	else:
		for tokenPosition in range(expectedTokens.size() -1,-1, -1):
			tokenTime = int(expectedTokens[tokenPosition].right(64))
			if currentTime - tokenTime >= 30:
				expectedTokens.remove(tokenPosition)

func _on_VerificationExpiration_timeout():
	ScPlayerVerification._on_VerificationExpiration_timeout_SC()

#Sending Functions
func FetchToken(playerId):
	rpc_id(playerId, "FetchToken")

func ReturnTokenVerificationResults(playerId, result):
	rpc_id(playerId, "ReturnTokenVerificationResults", result)

#Receiving Functions

remote func ReturnToken(username, token):
	var playerId = get_tree().get_rpc_sender_id()
	ScPlayerVerification.Verify(playerId, username, token)

remote func FetchPlayerStats():
	var playerId = get_tree().get_rpc_sender_id()
	var playerStats = get_node("/root/Server/Players/" +str(playerId)).playerStats
	rpc_id(playerId, "ReturnPlayerStats", playerStats)
	print("Sending " + str(playerStats) + " to Player")

remote func UpdateplayerStats(playerStats, username):
	var playerId = get_tree().get_rpc_sender_id()
	print("UpdateSats", username)
	ServerData.UpdatePlayerSats(playerStats, username)
	var playerContainer = get_node("/root/Server/Players/" + str(playerId))
	playerContainer.playerStats = ServerData.playerStats[username]

remote func UpdateQuiz(answers, username):
	var playerId = get_tree().get_rpc_sender_id()
	print("UpdateQuiz", username)
	ServerData.UpdateQuiz(answers, username)
