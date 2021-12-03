extends Control

#Ready Variables
onready var ServersSelection = get_node("/root/MainMenu/ServersSelection")
onready var LoginScreen = get_node("/root/MainMenu/LoginScreen")
onready var ItemListServers = get_node("Background/VBoxContainer/ItemList")
onready var ConnectButton = get_node("Background/VBoxContainer/HBoxContainer/ConnectButton")

#Global Variables
var selectedServer
var itemSelected = false

#Signal Functions
func _on_ItemList_item_selected(index):
	selectedServer = Gateway.serverName[ItemListServers.get_item_text(index)]
	itemSelected = true
	ConnectButton.disabled = false

func _on_ConnectButton_pressed():
	if itemSelected == true:
		Server.ip = Gateway.serverList[int(selectedServer)][0]
		Server.port = Gateway.serverList[int(selectedServer)][1]
		print("ip",Server.ip)
		Gateway.serverId = int(selectedServer)
		Gateway.getServerList = false
		ServersSelection.queue_free()
		LoginScreen.show()

func _on_SearchButton_pressed():
	ItemListServers.clear()
	Gateway.ConnectToServer("default" , "default" , "default")
