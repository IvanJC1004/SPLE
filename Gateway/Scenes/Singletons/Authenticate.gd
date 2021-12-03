extends Node

#Gateway Node
onready var gateway = get_node("/root/Gateway")

#Global Variables
var network = WebSocketClient.new()
var port
var ip

#Principal Functions
func _ready():
	ConnectToServer()

#Server Functions
func ConnectToServer():
	ip = ServerData.serverData["authenticationClientIp"]
	port = ServerData.serverData["authenticationClientPort"]
	network.connect_to_url("ws://" + ip + ":" + str(port), PoolStringArray(), true)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_On_Connection_Failed")
	network.connect("connection_succeeded", self, "_On_Connection_Succeeded")

func _On_Connection_Failed():
	print("Failed to Connect")

func _On_Connection_Succeeded():
	print("Succesfully to Connected")

#Sending Functions
func AuthenticatePlayer(username, password, playerId, serverId):
	print("Sending Out Authentication Request")
	rpc_id(1,"AuthenticatePlayer", username, password, playerId, serverId)

func CreateAccount(username, password, playerId):
	print("Sending Out Create Account Request")
	rpc_id(1, "CreateAccount", username, password, playerId)

func ServerListRequest(playerId):
	rpc_id(1, "ServerListRequest", playerId)

#Receiving Functions
remote func AuthenticationResults(result, playerId, token):
	print("Results Received and Replying to Player Login Request")
	gateway.ReturnLoginRequest(result, playerId, token)

remote func CreateAccountResults(result, playerId, message):
	print("Results Received and Replying to Player Create Account Request")
	gateway.ReturnCreateAccountRequest(result, playerId, message)

remote func ServerListResults(serverList, playerId):
	print("Results Received and Replying to Server List Request")
	gateway.ReturnServerListRequest(serverList, playerId)
