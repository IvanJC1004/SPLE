extends Control

#UI_State Nodes
onready var StatsScreen = get_node("/root/Lobby/StatsScreen")
onready var Shelving = get_node("/root/Shelving")
onready var Lobby = get_node("/root/Lobby")
onready var AudioButton = get_node("/root/Lobby/AudioButton")
#Node Variables
var LevelLoad

#Variables
export var number = 0
export var buttonType = 0 # 0 = basic / 1 = Intermediate / 2 = Advanced
export var route = ""

var enable = false

# Principal Functions
func _ready():
	$LevelButton/Label.text = str(number)
	if buttonType == 1:
		$LevelButton.texture_normal = load("res://Assets/UIElements/Image/Levels/Intermediate/Icon World Intermediate Level Normal.png")
		$LevelButton.texture_pressed = load("res://Assets/UIElements/Image/Levels/Intermediate/Icon World Intermediate Level Pressed.png")
		$LevelButton.texture_hover = load("res://Assets/UIElements/Image/Levels/Intermediate/Icon World Intermediate Level Hover.png")
		$LevelButton.texture_disabled = load("res://Assets/UIElements/Image/Levels/Intermediate/Icon World Intermediate Level Disabled.png")
	elif buttonType == 2:
		$LevelButton.texture_normal = load("res://Assets/UIElements/Image/Levels/Advanced/Icon World Advanced Level Normal.png")
		$LevelButton.texture_pressed = load("res://Assets/UIElements/Image/Levels/Advanced/Icon World Advanced Level Pressed.png")
		$LevelButton.texture_hover = load("res://Assets/UIElements/Image/Levels/Advanced/Icon World Advanced Level Hover.png")
		$LevelButton.texture_disabled = load("res://Assets/UIElements/Image/Levels/Advanced/Icon World Advanced Level Disabled.png")

func LevelUpdate(star):
	if enable == true:
		$LevelButton.disabled = false
	if star >= 1:
		$LevelButton/Star1.show()
	if star >= 2:
		$LevelButton/Star2.show()
	if star >= 3:
		$LevelButton/Star3.show()

func _on_LevelButton_pressed():
	LevelLoad = load(route).instance()
	get_tree().get_root().add_child(LevelLoad)
	StatsScreen.hide()
	Shelving.hide()
	Lobby.hide()
	AudioButton.audioOff()
