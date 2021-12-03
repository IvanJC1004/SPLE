extends Control

export var positionMin = 34
export var positionMax = 39
export var typeDialog = 1

var dialogIndex = 0
var finished = false
var next = true
var dialog =[]

#Customers
var chef = load("res://Assets/Images/Levels/Basic Restaurant/Dialog/David Chef.png")
var carla = load("res://Assets/Images/Levels/Basic Restaurant/Dialog/Carla.png")
var daniel = load("res://Assets/Images/Levels/Basic Restaurant/Dialog/Daniel.png")
var laura = load("res://Assets/Images/Levels/Basic Restaurant/Dialog/Laura.png")
var customers = [chef, carla, daniel, laura, chef]
var customersPosition = 0
var endDialog = false

func _ready():
	dialog =[]
	TranslationServer.set_locale(Server.language)
	for positionR in range(positionMin,positionMax):
		dialog.append(tr("DIALOGPART"+str(typeDialog)+"N"+str(positionR)))

func _process(_delta):
	$"DialogBox/Next Indicator".visible = finished

func LoadDialog():
	if next == false:
		dialogIndex -= 1
		customersPosition -= 1
		next = true
	if dialogIndex < dialog.size():
		finished = false
		$DialogBox/Customer1.texture = customers[customersPosition]
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialogIndex]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel,"percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		$Comparative.show()
	dialogIndex +=1
	customersPosition+=1

func _on_Tween_tween_completed(_object, _key):
	finished = true

func _on_Timer_timeout():
	$"DialogBox/Effect".hide()

func _on_TextureButton_pressed():
	if endDialog == false:
		LoadDialog()
	else:
		queue_free()

func _on_NextButton_pressed():
	$Comparative.hide()
	$DialogBox/RichTextLabel.bbcode_text = tr("DIALOGPART"+str(typeDialog)+"N"+str(positionMax))
	$DialogBox/RichTextLabel.percent_visible = 0
	$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel,"percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$DialogBox/Tween.start()
	endDialog = true

func changeComparative(type):
	if typeDialog == 1:
		if type == "es":
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative1Es.png")
		else:
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative1En.png")
	elif typeDialog == 2:
		if type == "es":
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative2Es.png")
		else:
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative2En.png")
	elif typeDialog == 3:
		if type == "es":
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative3Es.png")
		else:
			$Comparative.texture = load("res://Assets/Images/Levels/Basic Restaurant/Quiz/Comparative3En.png")
