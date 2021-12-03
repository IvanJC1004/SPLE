extends Control

#Ready Variables
onready var basicConcepts = get_node("Background/Stats/HBoxBasicConcepts/StartValue")
onready var intermediateConcepts = get_node("Background/Stats/HBoxIntermediateConcepts/StartValue")
onready var advancedConcepts = get_node("Background/Stats/HBoxAdvancedConcepts/StartValue")
onready var Shelving = get_node("/root/Shelving")
var playerStats

# Principal Functions
func _ready():
	TranslationServer.set_locale(Server.language)

#Load Functions
func LoadPlayerStats(stats):
	playerStats=stats
	#basicConcepts.set_text(str(stats.basicConcepts)+"%")
	#intermediateConcepts.set_text(str(stats.intermediateConcepts)+"%")
	#advancedConcepts.set_text(str(stats.advancedConcepts)+"%")
	
	#Level Indicator Update
	$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator1.enable = true
	$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator1.LevelUpdate(playerStats["B1"])
	if playerStats["B1"] != 0:
		$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator2.enable = true
		$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator2.LevelUpdate(playerStats["B2"])
	if playerStats["B2"] != 0:
		$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator3.enable = true
		$Background/Levels/VBoxContainer/HBoxContainer/BasicLevelIndicator3.LevelUpdate(playerStats["B3"])
	if playerStats["B1"] == 3:
		Shelving.LoadTrophys("B1")
	if playerStats["B2"] == 3:
		Shelving.LoadTrophys("B2")
	if playerStats["B3"] == 3:
		Shelving.LoadTrophys("B3")

func StatsUpdate(typeStats, stars):
	playerStats[typeStats] = stars
	Server.UpdateplayerStats(playerStats)

#Sign Functions
func _on_StatsButton_pressed():
	$Background/Stats.show()
	$Background/Levels.hide()
	$Background/BackButton.show()

func _on_CancelButton_pressed():
	hide()
	$Background/Levels.show()
	$Background/Stats.hide()
	$Background/BackButton.hide()

func _on_BackButton_pressed():
	$Background/Levels.show()
	$Background/Stats.hide()
	$Background/BackButton.hide()
