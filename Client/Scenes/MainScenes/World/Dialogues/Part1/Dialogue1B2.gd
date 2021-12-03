extends Control

export var positionMin = 1
export var positionMax = 6
export var typeDialog = 2

var dialogIndex = 0
var finished = false
var next = true
var dialog =[]

func _ready():
	dialog =[]
	TranslationServer.set_locale(Server.language)
	for positionR in range(positionMin,positionMax):
		dialog.append(tr("DIALOGPART"+str(typeDialog)+"N"+str(positionR)))

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
	dialogIndex +=1

func _on_Tween_tween_completed(_object, _key):
	finished = true

func _on_Timer_timeout():
	$"DialogBox/Effect".hide()

func _on_TextureButton_pressed():
	LoadDialog()
