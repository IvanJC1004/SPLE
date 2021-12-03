extends Node

#Global Variables
var network = WebSocketServer.new()
var port

#Principal Functions
func _ready():
	StartServer()

#Server Functions
func StartServer():
	port = ServerData.serverData["authenticationServerPort"]
	network.listen(port, PoolStringArray(), true)
	get_tree().set_network_peer(network)
	print("Authentication Server Started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(gatewayId):
	print("Gateway " + str(gatewayId) + " Connected")

func _Peer_Disconnected(gatewayId):
	print("Gateway " + str(gatewayId) + " Disconnected")

#Receiving Functions
remote func AuthenticatePlayer(username, password, playerId, serverId):
	print("Authentication Request Received")
	var gatewayId = get_tree().get_rpc_sender_id()
	var result
	var token
	print("Starting Authentication")
	result =ScPlayer.FetchPlayerData(username, password, serverId)
	token = result[1]
	result = result[0]
	print("Authentication Result Send to Gateway Server")	
	rpc_id(gatewayId, "AuthenticationResults", result, playerId, token)

remote func CreateAccount(username, password, playerId):
	var gatewayId = get_tree().get_rpc_sender_id()
	var result
	var message
	#Message: 1 = Failed to Create / 2 = Existing Username / 3 = Successfully Created
	if PlayerData.playerData.has(username):
		result = false
		message = 2
	else:
		result = true
		message = 3
		var salt = ScPlayer.GenerateSalt()
		var hashedPassword = ScPlayer.GenerateHashedPassword(password, salt)
		PlayerData.playerData[username] = {"password" : hashedPassword, "salt" : salt}
		PlayerData.SavePlayerData()
	rpc_id(gatewayId, "CreateAccountResults", result, playerId, message)

remote func ServerListRequest(playerId):
	print("Server List Request Received")
	var gatewayId = get_tree().get_rpc_sender_id()
	rpc_id(gatewayId, "ServerListResults", Servers.serverList, playerId)
