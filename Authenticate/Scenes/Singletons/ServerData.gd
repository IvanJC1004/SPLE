extends Node

#Global Variables
var serverData

#Principal Functions
func _ready():
	var playerDataFile = File.new()
	playerDataFile.open("res://Data/ServerData.json", File.READ)
	var playerData_json = JSON.parse(playerDataFile.get_as_text())
	playerDataFile.close()
	serverData = playerData_json.result
	print(serverData)
