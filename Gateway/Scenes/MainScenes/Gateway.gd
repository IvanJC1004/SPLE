extends Node

#Global Variables
var network = WebSocketServer.new()
var gatewayApi = MultiplayerAPI.new()
var port

#Principal Functions
func _ready():
	StartServer()

func _process(_delta):
	if get_custom_multiplayer() == null:
		return
	if not custom_multiplayer.has_network_peer():
		return;
	custom_multiplayer.poll();

#Server Functions
func StartServer():
	port = ServerData.serverData["gatewayServerPort"]
	network.listen(port, PoolStringArray(), true)
	set_custom_multiplayer(gatewayApi)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)
	print("Gateway Server Started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(playerId):
	print("User " + str(playerId) + " Connected")

func _Peer_Disconnected(playerId):
	print("User " + str(playerId) + " Disconnected")

#Sending Functions
func ReturnLoginRequest(result, playerId, token):
	rpc_id(playerId, "ReturnLoginRequest", result, token)

func ReturnCreateAccountRequest(result, playerId, message):
	rpc_id(playerId, "ReturnCreateAccountRequest", result, message)
	#Message: 1 = Failed to Create / 2 = Existing Username / 3 = Successfully Created

func ReturnServerListRequest(serverList, playerId):
	rpc_id(playerId, "ReturnServerListRequest", serverList)

#Receiving Functions
remote func LoginRequest(username, password ,serverId):
	print("Login Request received")
	var playerId = custom_multiplayer.get_rpc_sender_id()
	Authenticate.AuthenticatePlayer(username, password, playerId, serverId)

remote func CreateAccountRequest(username, password):
	print("Login Request received")
	var playerId = custom_multiplayer.get_rpc_sender_id()
	var validRequest = true
	if username == "":
		validRequest = false
	elif password == "":
		validRequest = false
	elif password.length() <= 6:
		validRequest = false
	if validRequest == false:
		ReturnCreateAccountRequest(validRequest, playerId, 1)
	else:
		Authenticate.CreateAccount(username, password, playerId)

remote func ServerListRequest():
	print("Server List Request received")
	var playerId = custom_multiplayer.get_rpc_sender_id()
	Authenticate.ServerListRequest(playerId)

remote func ReceiveMessage():
	var playerId = custom_multiplayer.get_rpc_sender_id()
	network.disconnect_peer(playerId)
