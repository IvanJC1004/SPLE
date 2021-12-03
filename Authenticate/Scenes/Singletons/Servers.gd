extends Node

#Global Variables
var network = WebSocketServer.new()
var gatewayApi = MultiplayerAPI.new()
var port
var serverList = {}

#Principal Functions
func _ready():
	StartServer()

func _process(_delta):
	if not custom_multiplayer.has_network_peer():
		return;
	custom_multiplayer.poll();

#Server Functions
func StartServer():
	port = ServerData.serverData["gameServerHubServerPort"]
	network.listen(port, PoolStringArray(), true)
	set_custom_multiplayer(gatewayApi)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)
	print("GameServerHub Started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(serverId):
	print("Server " + str(serverId) + " Connected")
	#serverList[serverId] = [network.get_peer_address(serverId), network.get_peer_port(serverId)]
	serverList[serverId] = ["186.168.81.20", network.get_peer_port(serverId)]
	print(serverList)

func _Peer_Disconnected(serverId):
	print("Server " + str(serverId) + " Disconnected")
	serverList.erase(serverId)
	print(serverList)

#Sending Functions
func DistributeLoginToken(token, serverId):
	var serverPeerId = serverId
	rpc_id(serverPeerId, "ReceiveLoginToken", token)

#Receiving Functions
remote func SendPort(_port):
	var serverId = custom_multiplayer.get_rpc_sender_id()
	serverList[serverId][1] = str(int(_port)+1)
	print(serverList)
