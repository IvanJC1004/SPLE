extends Node

#Ready Variables
onready var ServersSelection = get_node("/root/MainMenu/ServersSelection")
onready var WarningWindow = get_node("/root/MainMenu/LoginScreen/Warnings")
onready var Warnings = get_node("/root/MainMenu/LoginScreen/Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text")

#Global Variables
var network = WebSocketClient.new()
var gatewayApi = MultiplayerAPI.new()
var port = 8086
var ip = "186.168.81.20"
var username
var password
var newAccount = false
var getServerList = true
var serverList = {}
var serverId
var serverName = {}
var conection = false

# Principal Functions
func _process(_delta):
	if conection == true:
		if get_custom_multiplayer() == null:
			return
		if not custom_multiplayer.has_network_peer():
			return;
		custom_multiplayer.poll();

#Server Functions
func ConnectToServer(_username, _password, _newAccount):
	conection = true
	network = WebSocketClient.new()
	gatewayApi = MultiplayerAPI.new()
	username = _username
	password = _password
	newAccount = _newAccount
	network.connect_to_url("ws://" + ip + ":" + str(port), PoolStringArray(), true)
	set_custom_multiplayer(gatewayApi)
	custom_multiplayer.set_root_node(self)
	custom_multiplayer.set_network_peer(network)
	print("Gateway Client Started")
	
	network.connect("connection_failed", self, "_On_Connection_Failed")
	network.connect("connection_succeeded", self, "_On_Connection_Succeeded")

func _On_Connection_Failed():
	if getServerList == true:
		Warnings.text = tr("SERVERLISTERROR")
		WarningWindow.show()
	else:
		Warnings.text = tr("LOGINSERVERERROR")
		WarningWindow.show()
		get_node("/root/MainMenu/LoginScreen").loginButton.disabled = false
		get_node("/root/MainMenu/LoginScreen").createAccountButton.disabled = false
		get_node("/root/MainMenu/LoginScreen").createButton.disabled = false
		get_node("/root/MainMenu/LoginScreen").cancelButton.disabled = false

func _On_Connection_Succeeded():
	if getServerList == true:
		print("Succesfully Connected to Server List")
		ServerListRequest()
	else:
		print("Succesfully Connected to Login Server")
		if newAccount == true:
			RequestCreateAccount()
		else:
			RequestLogin()

#Server List Functions
func addServersFromServerList(_serverList):
	var numberOfServers = 0
	for server in _serverList:
		numberOfServers += 1
		serverName["Server : " + str(numberOfServers)] = server
		print(serverName)
		ServersSelection.ItemListServers.add_item("Server : " + str(numberOfServers),null,true)

#Sending Functions
func RequestLogin():
	print("Connecting to Gateway to Request Login")
	rpc_id(1,"LoginRequest", username, password.sha256_text(), serverId)
	Server.username = username
	username = ""
	password = ""

func RequestCreateAccount():
	print("Requesting New Account")
	rpc_id(1,"CreateAccountRequest", username, password.sha256_text())
	Server.username = username
	username= ""
	password= ""

func ServerListRequest():
	rpc_id(1, "ServerListRequest")

#Receiving Functions
remote func ReturnLoginRequest(results, token):
	print("Results Received")
	if results == true:
		Server.token = token
		Server.ConnectToServer()
	else:
		Warnings.text = tr("IDPASSWORDERROR")
		WarningWindow.show()
		get_node("/root/MainMenu/LoginScreen").loginButton.disabled = false
	rpc_id(1, "ReceiveMessage")
	network.disconnect("connection_failed", self, "_On_Connection_Failed")
	network.disconnect("connection_succeeded", self, "_On_Connection_Succeeded")

remote func ReturnCreateAccountRequest(results, message):
	print("results received")
	if results == true:
		Warnings.text = tr("CREATEACCOUNT1")
		WarningWindow.show()
		print("Account Created, Please Proceed with Logging In")
		get_node("/root/MainMenu/LoginScreen")._on_Cancel_pressed()
	else:
		if message == 1:
			Warnings.text = tr("CREATEACCOUNT2")
			WarningWindow.show()
			print("Couldn't Create Account, Please Try Again")
		elif message ==2:
			Warnings.text = tr("CREATEACCOUNT3")
			WarningWindow.show()
			print("The Username Already Exist, Please Use a Different Username")
	get_node("/root/MainMenu/LoginScreen").createButton.disabled = false
	get_node("/root/MainMenu/LoginScreen").cancelButton.disabled = false
	rpc_id(1, "ReceiveMessage")
	network.disconnect("connection_failed", self, "_On_Connection_Failed")
	network.disconnect("connection_succeeded", self, "_On_Connection_Succeeded")

remote func  ReturnServerListRequest(_serverList):
	print("results received")
	serverList = _serverList
	addServersFromServerList(serverList)
	rpc_id(1, "ReceiveMessage")
	network.disconnect("connection_failed", self, "_On_Connection_Failed")
	network.disconnect("connection_succeeded", self, "_On_Connection_Succeeded")
