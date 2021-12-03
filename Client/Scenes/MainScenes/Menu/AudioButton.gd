extends TextureButton

var isStopped = false

func _on_AudioButton_pressed():
	if $AudioStreamPlayer.playing == false:
		texture_normal = load("res://Assets/UIElements/Image/Music Icon Normal.png")
		texture_hover = load("res://Assets/UIElements/Image/Music Icon Hover.png")
		texture_pressed = load("res://Assets/UIElements/Image/Music Icon Pressed.png")
		$AudioStreamPlayer.play()
		isStopped = false
	else:
		texture_normal = load("res://Assets/UIElements/Image/No Music Icon Normal.png")
		texture_hover = load("res://Assets/UIElements/Image/No Music Icon Hover.png")
		texture_pressed = load("res://Assets/UIElements/Image/No Music Icon Pressed.png")
		$AudioStreamPlayer.stop()
		isStopped = true

func audioOff():
	texture_normal = load("res://Assets/UIElements/Image/No Music Icon Normal.png")
	texture_hover = load("res://Assets/UIElements/Image/No Music Icon Hover.png")
	texture_pressed = load("res://Assets/UIElements/Image/No Music Icon Pressed.png")
	$AudioStreamPlayer.stop()
	isStopped = true

func _on_AudioStreamPlayer_finished():
	if isStopped == false:
		$AudioStreamPlayer.play()
