extends Node

#Global Variables
var serverData
var playerStats
var quiz

#Principal Functions
func _ready():
	ReadingServeData()
	ReadingPlayerSats()
	ReadingQuiz()

#Reading Functions
func ReadingFunction(route):
	var DataFile = File.new()
	DataFile.open(route,File.READ)
	var DataJson = JSON.parse(DataFile.get_as_text())
	DataFile.close() 
	print(DataJson.result)
	return DataJson.result

func ReadingServeData():
	serverData = ReadingFunction("res://Data/ServerData.json")

func ReadingPlayerSats():
	playerStats = ReadingFunction("res://Data/PlayerStatsData.json")

func ReadingQuiz():
	quiz = ReadingFunction("res://Data/Quiz.json")

#Writing Functions
func WritingFunction(route, content):
	var DataFile = File.new()
	DataFile.open(route,File.WRITE)
	DataFile.store_string(content)
	DataFile.close() 

func UpdatePlayerSats(newPlayerStats, username):
	playerStats[username] = newPlayerStats
	WritingFunction("res://Data/PlayerStatsData.json", JSON.print(playerStats))

func WritingPlayerSats(username):
	playerStats[username] = {"B1" : 0, "B2" : 0, "B3" : 0, "I1" : 0, "A1" : 0}
	WritingFunction("res://Data/PlayerStatsData.json", JSON.print(playerStats))

func UpdateQuiz(newAnswers, username):
	var type = newAnswers.pop_back() 
	quiz[username][type-1] = newAnswers
	WritingFunction("res://Data/Quiz.json", JSON.print(quiz))

func WritingQuiz(username):
	quiz[username] = [[], [], []]
	WritingFunction("res://Data/Quiz.json", JSON.print(quiz))
