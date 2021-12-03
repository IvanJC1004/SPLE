extends NinePatchRect

#Node Variables
var Shelving = preload("res://Scenes/MainScenes/Menu/Shelving.tscn").instance()

# Principal Functions
func _ready():
	get_tree().get_root().add_child(Shelving)
	Shelving.hide()

# Singal Functions
func _on_ShelvingButton_pressed():
	Server.FetchPlayerStats()
	Shelving.show()


func _on_BoardButton_pressed():
	Server.FetchPlayerStats()
	get_node("/root/Lobby/StatsScreen").show()
