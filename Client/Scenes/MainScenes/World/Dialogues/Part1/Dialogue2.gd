extends Control

export var positionMin = 5
export var positionMax = 34
export var typeDialog = 1

var dialogIndex = 0
var next = true
var dialog =[]

func _ready():
	TranslationServer.set_locale(Server.language)
	dialog =[]
	for positionR in range(positionMin,positionMax):
		dialog.append(tr("DIALOGPART"+str(typeDialog)+"N"+str(positionR)))

func LoadDialog():
	if next == false:
		dialogIndex -=1
		next = true
	if dialogIndex == 0:
		$"Next Indicator/PreviousTextureButton".hide()
	else:
		$"Next Indicator/PreviousTextureButton".show()
	if dialogIndex == positionMax - positionMin - 1:
		$"Next Indicator/NextTextureButton".hide()
	else:
		$"Next Indicator/NextTextureButton".show()
	if dialogIndex < dialog.size():
		$RichTextLabel.bbcode_text = dialog[dialogIndex]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel,"percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		queue_free()
	dialogIndex +=1

func _on_NextTextureButton_pressed():
	LoadDialog()


func _on_PreviousTextureButton_pressed():
	dialogIndex-=2
	LoadDialog()
