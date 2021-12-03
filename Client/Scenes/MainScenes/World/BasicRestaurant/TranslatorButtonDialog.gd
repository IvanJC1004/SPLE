extends TextureButton

#Variables
var Dialogue1 = true
var Dialogue2 = true
var Dialogue3 = true

#Functions
func _on_TextureButton_pressed():
	$TranslatortemList.show()

func Dialog(type):
	if type == 0:
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue".next = false
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue"._ready()
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue".LoadDialog()
	elif type == 1:
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue2".next = false
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue2"._ready()
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue2".LoadDialog()
	elif type == 2:
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue3".next = false
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue3"._ready()
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue3".LoadDialog()
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue3".changeComparative(Server.language)
	else:
		$"/root/BasicRestaurant/Quiz".typeQuiz()

func _on_ItemList_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("es")
		Server.language = "es"
		if Dialogue1 ==true:
			Dialog(0)
		elif Dialogue2 == true:
			Dialog(1)
		elif Dialogue3 == true:
			Dialog(2)
		else:
			Dialog(3)
	else:
		TranslationServer.set_locale("en")
		Server.language = "en"
		if Dialogue1 == true:
			Dialog(0)
		elif Dialogue2 == true:
			Dialog(1)
		elif Dialogue3 == true:
			Dialog(2)
		else:
			Dialog(3)
	$TranslatortemList.hide()
