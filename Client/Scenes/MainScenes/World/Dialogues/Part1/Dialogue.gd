extends Control

var dialogIndex = 0
var finished = false
var next = true
var dialog =[]

func _ready():
	dialog =[]
	TranslationServer.set_locale(Server.language)
	for positionR in range(1,5):
		dialog.append(tr("DIALOGPART1N"+str(positionR)))

func _process(_delta):
	$"DialogBox/Next Indicator".visible = finished
		

func LoadDialog():
	if next == false:
		dialogIndex -=1
		next = true
	if dialogIndex < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialogIndex]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel,"percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		queue_free()
	if dialogIndex == 3:
		$"DialogBox/David".hide()
		$"DialogBox/David Chef".show()
		$"DialogBox/Effect".show()
		$DialogBox/Effect/Timer.start()
	dialogIndex +=1

func _on_Tween_tween_completed(_object, _key):
	finished = true

func _on_Timer_timeout():
	$"DialogBox/Effect".hide()

func _on_TextureButton_pressed():
	LoadDialog()
