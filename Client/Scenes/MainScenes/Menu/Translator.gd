extends TextureButton

#Functions
func _on_TextureButton_pressed():
	$TranslatortemList.show()


func _on_ItemList_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("es")
		Server.language = "es"
	else:
		TranslationServer.set_locale("en")
		Server.language = "en"
	$TranslatortemList.hide()
