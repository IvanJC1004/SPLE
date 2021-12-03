extends Node

#Node Variables
var Lobby = preload("res://Scenes/MainScenes/World/Lobby/Lobby.tscn").instance()

#Global Variables
var network = WebSocketClient.new()
var port
var ip
var token
var language = "es"
var username = ""

#__Principal Functions__

#Server Functions
func ConnectToServer():
	network.connect_to_url("ws://" + ip + ":" + str(port), PoolStringArray(), true)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_On_Connection_Failed")
	network.connect("connection_succeeded", self, "_On_Connection_Succeeded")

func _On_Connection_Failed():
	print("Failed to Connect")

func _On_Connection_Succeeded():
	print("Succesfully to Connected")

#Sending Functions

func FetchPlayerStats():
	rpc_id(1, "FetchPlayerStats")

func UpdateplayerStats(playerStats):
	rpc_id(1, "UpdateplayerStats", playerStats, username)

func UpdateQuiz(answers):
	rpc_id(1, "UpdateQuiz", answers, username)

#Receiving Functions
remote func FetchToken():
	rpc_id(1, "ReturnToken", username, token)

remote func ReturnTokenVerificationResults(result):
	if result == true:
		get_node("/root/MainMenu").queue_free()
		get_node("/root/Gateway").queue_free()
		get_tree().get_root().add_child(Lobby)
		print("Succesful Token Verification")
	else:
		print("Login Failed, Please Try Again")
		get_node("/root/MainMenu/LoginScreen").loginButton.disabled = false

remote func ReturnPlayerStats(stats):
	get_node("/root/Lobby/StatsScreen").LoadPlayerStats(stats)
