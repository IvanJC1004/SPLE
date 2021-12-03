extends Node

#UI_State Nodes
onready var StatsScreen = get_node("/root/Lobby/StatsScreen")
onready var Lobby = get_node("/root/Lobby")
onready var AudioButton = get_node("/root/Lobby/AudioButton")
var star = 0

var pizzaConfiguratorCreated = false

#Mouse Variable
var mouseTexture = ""

#Order
var order = 0
var pizzaCreated = []
var customerOrders = [["Cooked", "Cut Cheese", "Cut Mushroom", "Dough", "Tomatoes Sauce"], ["Cooked", "Cut Cheese", "Cut Ham", "Dough", "Tomatoes Sauce"],["Cooked", "Cut Cheese", "Cut Chicken", "Cut Pineapple", "Dough", "Tomatoes Sauce"],["Cooked", "Cut Cheese", "Cut Ham", "Cut Pepperoni", "Dough", "Tomatoes Sauce"]]

#Ingredients Variable
var DoughPizza = false
var TomatoeSaucePizza = false
var CheesePizza = false
var ChickenPizza = false
var HamPizza = false
var PepperoniPizza = false
var MushroomPizza = false
var PineapplePizza = false

#Event Functions
func _input(_event):
	if _event is InputEventKey:
		if _event.scancode == KEY_ESCAPE:
			queue_free()

#Principal Functions
func _ready():
	TranslationServer.set_locale(Server.language)
	$NinePatchRect/Front/Dialogue.LoadDialog()
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D.unit_offset = 1

func _on_Dialogue_tree_exited():
	$NinePatchRect/Front/Up.show()
	$NinePatchRect/Front/AnimationPlayer.play("Part1IDLE")
	$NinePatchRect/Front/Dialogue2._ready()
	$NinePatchRect/Front/Dialogue2.show()
	$NinePatchRect/Front/Dialogue2.LoadDialog()
	$NinePatchRect/Front/TranslatorButton.Dialogue1 = false
	$NinePatchRect/Front/Orders/Note.show()

func _process(delta):
	$NinePatchRect/Front/mouseTexture.rect_global_position = $"/root/MenuControls".mousePosition - Vector2(-1,-1)
	
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D.offset += 400 * delta
	
	if $NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D.offset >= 2367 and pizzaConfiguratorCreated == true:
		$NinePatchRect/Front/Up/Buttons/DeliverButton.show()
		pizzaConfiguratorCreated = false

#Buttons Functions General

func _on_PizzaConfigurator_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.show()

func _on_CancelButton3_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.hide()
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""

func _on_Trash_pressed():
	pizzaCreated = []
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""

func MouseTexture(type):
	if mouseTexture == "":
		$NinePatchRect/Front/mouseTexture.texture = load("res://Assets/Images/Levels/Ingredients/"+type+" Normal.png")
		$NinePatchRect/Front/mouseTexture.show()
		mouseTexture = type
#Chef Dialog Functions

func _on_HideButton_pressed():
	$NinePatchRect/Front/Dialogue2.hide()
	$NinePatchRect/Front/ChefButton.show()

func _on_ChefButton_pressed():
	$NinePatchRect/Front/Dialogue2.show()
	$NinePatchRect/Front/ChefButton.hide()

#__Preparing the Pizzas__

func _on_ChickenI3_pressed():
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""
	MouseTexture("Cut Chicken")

func _on_PepperoniI4_pressed():
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""
	MouseTexture("Cut Pepperoni")

func _on_HamI5_pressed():
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""
	MouseTexture("Cut Ham")

func _on_MushroomI6_pressed():
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""
	MouseTexture("Cut Mushroom")

func _on_PineappleI7_pressed():
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""
	MouseTexture("Cut Pineapple")

func _on_Table_pressed():
	if mouseTexture == "Cut Chicken" and ChickenPizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.show()
		$NinePatchRect/Front/mouseTexture.hide()
		mouseTexture = ""
		ChickenPizza = true
		pizzaCreated.append("Cut Chicken")
	elif mouseTexture == "Cut Pepperoni" and PepperoniPizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.show()
		$NinePatchRect/Front/mouseTexture.hide()
		mouseTexture = ""
		PepperoniPizza = true
		pizzaCreated.append("Cut Pepperoni")
	elif mouseTexture == "Cut Ham" and HamPizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.show()
		$NinePatchRect/Front/mouseTexture.hide()
		mouseTexture = ""
		HamPizza = true
		pizzaCreated.append("Cut Ham")
	elif mouseTexture == "Cut Mushroom" and MushroomPizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.show()
		$NinePatchRect/Front/mouseTexture.hide()
		mouseTexture = ""
		MushroomPizza = true
		pizzaCreated.append("Cut Mushroom")
	elif mouseTexture == "Cut Pineapple" and PineapplePizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.show()
		$NinePatchRect/Front/mouseTexture.hide()
		mouseTexture = ""
		PineapplePizza = true
		pizzaCreated.append("Cut Pineapple")
	
	print(pizzaCreated)


func _on_Yes_pressed():
	ChickenPizza = false
	HamPizza = false
	PepperoniPizza = false
	MushroomPizza = false
	PineapplePizza = false
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.hide()
	
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Dough.show()
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/TomatoeSauce.show()
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Cheese.show()
	for ingredients in pizzaCreated:
		if ingredients == "Cut Chicken":
			$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Chicken.show()
		elif ingredients == "Cut Ham":
			$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Ham.show()
		elif ingredients == "Cut Pepperoni":
			$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Pepperoni.show()
		elif ingredients == "Cut Mushroom":
			$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Mushroom.show()
		elif ingredients == "Cut Pineapple":
			$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Pineapple.show()
	$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D.unit_offset = 0
	pizzaConfiguratorCreated = true


func _on_No_pressed():
	ChickenPizza = false
	HamPizza = false
	PepperoniPizza = false
	MushroomPizza = false
	PineapplePizza = false
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.hide()
	pizzaCreated = []


func _on_DeliverButton_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Dough.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/TomatoeSauce.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Cheese.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Chicken.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Ham.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Pepperoni.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Mushroom.hide()
		$NinePatchRect/Front/Up/Buttons/Deliver/Path2D/PathFollow2D/PizzaCompleted/Pineapple.hide()
		$NinePatchRect/Front/Up/Buttons/DeliverButton.hide()
		OrderDeliver()

func OrderDeliver():
	pizzaCreated.append("Dough")
	pizzaCreated.append("Tomatoes Sauce")
	pizzaCreated.append("Cut Cheese")
	pizzaCreated.append("Cooked")
	pizzaCreated.sort()
	print(customerOrders[0])
	print(pizzaCreated)
	if customerOrders[0] == pizzaCreated:
		customerOrders.erase(pizzaCreated)
		pizzaCreated = []
		$NinePatchRect/Front/Up/Buttons/Deliver/CorrectOrder.show()
		$NinePatchRect/Front/Up/Buttons/Deliver/CorrectOrder/CorrectOrderTimer.start()
		if order == 0:
			$NinePatchRect/Front/Orders/Note/Order0.hide()
			$NinePatchRect/Front/Orders/Note/Order1.show()
			$NinePatchRect/Front/Orders/Note/Title.text = tr("PIZZAORDER1")
			star +=1
		if order == 1:
			$NinePatchRect/Front/Orders/Note/Order1.hide()
			$NinePatchRect/Front/Orders/Note/Order2.show()
			$NinePatchRect/Front/Orders/Note/Title.text = tr("PIZZAORDER2")
			star +=1
		elif order == 2:
			$NinePatchRect/Front/Orders/Note/Order2.hide()
			$NinePatchRect/Front/Orders/Note/Order3.show()
			$NinePatchRect/Front/Orders/Note/Title.text = tr("PIZZAORDER3")
			star +=1
		order+=1
	else:
		$NinePatchRect/Front/Up/Buttons/Deliver/WrongLabel.show()
		$NinePatchRect/Front/Up/Buttons/Deliver/WrongLabel/WrongtOrderTimer.start()
		if star > 0:
			star -=1
		pizzaCreated = []
	if order == 4:
		$NinePatchRect/Front/Orders/Note.hide()
		$NinePatchRect/Front/ChefButton.hide()
		$NinePatchRect/Front/AnimationPlayer.play("Part1IDLE")
		$NinePatchRect/Front.texture = load("res://Assets/Images/Levels/Basic Restaurant/Background Costumers.png")
		$NinePatchRect/Front/TranslatorButton.Dialogue2 = false
		$NinePatchRect/Front/Up.hide()
		$NinePatchRect/Front/Dialogue2.hide()
		$NinePatchRect/Front/ChefButton.hide()
		$NinePatchRect/Front/Dialogue3._ready()
		$NinePatchRect/Front/Dialogue3.show()
		$NinePatchRect/Front/Dialogue3.LoadDialog()
		$"/root/BasicRestaurant/NinePatchRect/Front/Dialogue3".changeComparative(Server.language)

func _on_CorrectOrderTimer_timeout():
	$NinePatchRect/Front/Up/Buttons/Deliver/CorrectOrder.hide()

func _on_WrongtOrderTimer_timeout():
	$NinePatchRect/Front/Up/Buttons/Deliver/WrongLabel.hide()

func _on_Dialogue3_tree_exited():
	$NinePatchRect/Front/TranslatorButton.Dialogue3 = false
	$Quiz.typeQuiz()
	$Quiz.show()

func _on_Quiz_tree_exited():
	updateStart()
	Lobby.show()
	AudioButton._on_AudioButton_pressed()
	queue_free()

func updateStart():
	if star > StatsScreen.playerStats["B3"]:
		print(star,"Updated")
		StatsScreen.StatsUpdate("B3", star)
