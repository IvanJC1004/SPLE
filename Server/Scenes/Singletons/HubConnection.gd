extends Node

#Global Variables
var network = WebSocketClient.new()
var gatewayApi = MultiplayerAPI.new()
var port
var ip

#Ready Variables
onready var server = get_node("/root/Server")

#Principal Functions
func _ready():
	ConnectToServer()

func _process(_delta):
	if get_custom_multiplayer() == null:
		return
	if not custom_multiplayer.has_network_peer():
		return;
	custom_multiplayer.poll();

#Server Functions
func ConnectToServer():
	ip = ServerData.serverData["gameServerHubServerIp"]
	port = ServerData.serverData["gameServerHubServerPort"]
	network.connect_to_url("ws://" + ip + ":" + str(port), PoolStringArray(), true)
	set_custom_multiplayer(gatewayApi)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)
	print("Hub Server Started")
	
	network.connect("connection_failed", self, "_On_Connection_Failed")
	network.connect("connection_succeeded", self, "_On_Connection_Succeeded")

func _On_Connection_Failed():
	print("Failed to Connect to Server Hub")

func _On_Connection_Succeeded():
	print("Succesfully Connected to Server Hub")
	rpc_id(1, "SendPort", server.port)

#Receiving Functions
remote func ReceiveLoginToken(token):
	print("Token Received")
	server.expectedTokens.append(token)
