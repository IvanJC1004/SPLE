extends Control

#Load Functions
func LoadTrophys(trophyType):
	if trophyType == "B1":
		$Background/TrophyB1.show()
	if trophyType == "B2":
		$Background/TrophyB2.show()
	if trophyType == "B3":
		$Background/TrophyB3.show()

# Singal Functions
func _on_CancelButton_pressed():
	hide()
