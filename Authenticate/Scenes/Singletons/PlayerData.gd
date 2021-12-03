extends Node

#Global Variables
var playerData

#Principal Functions
func _ready():
	var playerDataFile = File.new()
	playerDataFile.open("res://Data/PlayerData.json", File.READ)
	var playerData_json = JSON.parse(playerDataFile.get_as_text())
	playerDataFile.close()
	playerData = playerData_json.result
	print(playerData)

func SavePlayerData():
	var saveFile = File.new()
	saveFile.open("res://Data/PlayerData.json", File.WRITE)
	saveFile.store_line(to_json(playerData))
	saveFile.close()

