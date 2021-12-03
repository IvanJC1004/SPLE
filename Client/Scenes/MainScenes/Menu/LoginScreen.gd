extends Control

#Ready Variables

#UI_State Nodes
onready var loginScreen = get_node("Background/LoginScreen")
onready var createAccountScreen = get_node("Background/CreateAccount")

#Login Nodes
onready var usernameInput = get_node("Background/LoginScreen/Username")
onready var userPasswordInput = get_node("Background/LoginScreen/Password")
onready var loginButton = get_node("Background/LoginScreen/LoginButton")
onready var createAccountButton = get_node("Background/LoginScreen/CreateAccountButton")

#Create Account Nodes
onready var createUsernameInput = get_node("Background/CreateAccount/Username")
onready var createUserPasswordInput = get_node("Background/CreateAccount/Password")
onready var createUserPasswordRepeatInput = get_node("Background/CreateAccount/RepeatPassword")
onready var createButton = get_node("Background/CreateAccount/HBoxContainer/Create")
onready var cancelButton = get_node("Background/CreateAccount/HBoxContainer/Cancel")

#Principal Functions
func _ready():
	TranslationServer.set_locale("es")

# Signal Functions
func _on_LoginButton_pressed():
	if usernameInput.text == "" or userPasswordInput.text == "":
		#PopUp and Stop
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("IDPASSWORDERROR")
		$Warnings.show()
	else:
		loginButton.disabled = true
		var username = usernameInput.get_text()
		var password = userPasswordInput.get_text()
		print("Attempting to Login")
		Gateway.ConnectToServer(username, password, false)

func _on_CreateAccountButton_pressed():
	loginScreen.hide()
	createAccountScreen.show()

func _on_Cancel_pressed():
	loginScreen.show()
	createAccountScreen.hide()

func _on_Create_pressed():
	if createUsernameInput.get_text() == "":
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("USERNAMEERROR")
		$Warnings.show()
	elif createUserPasswordInput.get_text() == "":
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("PASSWORDERROR")
		$Warnings.show()
	elif createUserPasswordRepeatInput.get_text() == "":
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("PASSWORDREERROR")
		$Warnings.show()
	elif createUserPasswordInput.get_text() != createUserPasswordRepeatInput.get_text():
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("PASSWORDMATCHERROR")
		$Warnings.show()
	elif createUserPasswordInput.get_text().length() <= 6:
		$Warnings/NinePatchRect/NinePatchRect/VBoxContainer/Text.text = tr("PASSWORD7ERROR")
		$Warnings.show()
	else:
		createButton.disabled = true
		cancelButton.disabled = true
		var username = createUsernameInput.get_text()
		var password = createUserPasswordInput.get_text()
		Gateway.ConnectToServer(username, password, true)

func _on_CancelButton_pressed():
	$Warnings.hide()
