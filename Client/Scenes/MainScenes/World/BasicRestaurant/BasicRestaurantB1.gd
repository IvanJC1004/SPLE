extends Node

#UI_State Nodes
onready var StatsScreen = get_node("/root/Lobby/StatsScreen")
onready var Lobby = get_node("/root/Lobby")
onready var AudioButton = get_node("/root/Lobby/AudioButton")

#Mouse Variable
var mouseTexture = ""
var cut = false
var cutIngredient = ""
var knead = false
var stove = false

#Ingredients Variable
var DoughPizza = false
var TomatoeSaucePizza = false
var CheesePizza = false
var ChickenPizza = false
var HamPizza = false
var PepperoniPizza = false
var MushroomPizza = false
var PineapplePizza = false

#Ingredients Variable Counts
var tomatoesSauce = 0
var cutCheese = 0
var cutChicken = 0
var cutPepperoni = 0
var cutHam = 0
var cutMushroom = 0
var cutPineapple = 0

#Pizza
var pizzaCreated = []
var isPizzaOven = false
var isCooked = false
var isBurned = false
var customerPizza = []
var order = 0

var star = 0
#Order
var customerOrders = [["Cooked", "Cut Cheese", "Dough", "Tomatoes Sauce"], ["Cooked", "Cut Cheese", "Cut Ham", "Cut Pineapple", "Dough", "Tomatoes Sauce"],["Cooked", "Cut Cheese", "Cut Chicken", "Cut Mushroom", "Dough", "Tomatoes Sauce"],["Cooked", "Cut Cheese", "Cut Pepperoni", "Dough", "Tomatoes Sauce"]]
#Event Functions
func _input(_event):
	if _event is InputEventKey:
		if _event.scancode == KEY_ESCAPE:
			queue_free()

#Principal Functions
func _ready():
	TranslationServer.set_locale(Server.language)
	$NinePatchRect/Front/mouseTexture.hide()
	$NinePatchRect/Front/Dialogue.LoadDialog()

func _on_Dialogue_tree_exited():
	$NinePatchRect/Front/Up.show()
	$NinePatchRect/Front/AnimationPlayer.play("Part1IDLE")
	$NinePatchRect/Front/Dialogue2._ready()
	$NinePatchRect/Front/Dialogue2.show()
	$NinePatchRect/Front/Dialogue2.LoadDialog()
	$NinePatchRect/Front/TranslatorButton.Dialogue1 = false
	$NinePatchRect/Front/Orders/Note.show()

func _physics_process(_delta):
	$NinePatchRect/Front/mouseTexture.rect_global_position = $"/root/MenuControls".mousePosition - Vector2(-1,-1)

func MouseTexture(type):
	if mouseTexture == "":
		$NinePatchRect/Front/mouseTexture.texture = load("res://Assets/Images/Levels/Ingredients/"+type+" Normal.png")
		$NinePatchRect/Front/mouseTexture.show()
		mouseTexture = type
	
#Buttons Functions General

func _on_CancelButton_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/FridgeInventory.hide()


func _on_Pizza_Oven_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory.show()

func _on_CancelButton2_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory.hide()


func _on_CancelButton3_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.hide()
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""

func _on_Trash_pressed():
	if mouseTexture == "Pizza Icon" and isPizzaOven == false:
		pizzaCreated = []
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.value = 0
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.hide()
		isCooked = false
		isBurned = false
	$NinePatchRect/Front/mouseTexture.hide()
	mouseTexture = ""

#Chef Dialog Functions

func _on_HideButton_pressed():
	$NinePatchRect/Front/Dialogue2.hide()
	$NinePatchRect/Front/ChefButton.show()

func _on_ChefButton_pressed():
	$NinePatchRect/Front/Dialogue2.show()
	$NinePatchRect/Front/ChefButton.hide()

#Fridge Functions

func _on_Fridge_pressed():
	$NinePatchRect/Front/Up/Buttons/Menus/FridgeInventory.show()

func _on_I1TextureButton_pressed():
	MouseTexture("Tomatoes")

func _on_I2TextureButton_pressed():
	MouseTexture("Flour")

func _on_I3TextureButton_pressed():
	MouseTexture("Cheese")

func _on_I4TextureButton_pressed():
	MouseTexture("Chicken")

func _on_I5TextureButton_pressed():
	MouseTexture("Pepperoni")

func _on_I6TextureButton_pressed():
	MouseTexture("Ham")

func _on_I7TextureButton_pressed():
	MouseTexture("Mushroom")

func _on_I8TextureButton_pressed():
	MouseTexture("Pineapple")

# Buttons Tables

#__Cooking Table__
func _on_CookingTable_pressed():
	if mouseTexture == "Tomatoes" or mouseTexture == "Cheese" or mouseTexture == "Chicken" or mouseTexture == "Pepperoni" or mouseTexture == "Ham" or mouseTexture == "Mushroom" or mouseTexture == "Pineapple":
		cutIngredient = mouseTexture
		cut = true
		$NinePatchRect/Front/Up/Buttons/CookingTable.disabled = true
		_on_Trash_pressed()

func CutIngredients(type):
	MouseTexture(type)
	$NinePatchRect/Front/Up/Buttons/CookingTable.disabled = false

func _on_CutTomatoes_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutTomatoes.hide()
		CutIngredients("Cut Tomatoes")

func _on_CutCheese_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutCheese.hide()
		CutIngredients("Cut Cheese")

func _on_CutChicken_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutChicken.hide()
		CutIngredients("Cut Chicken")

func _on_CutPepperoni_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutPepperoni.hide()
		CutIngredients("Cut Pepperoni")

func _on_CutHam_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutHam.hide()
		CutIngredients("Cut Ham")

func _on_CutMushroom_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutMushroom.hide()
		CutIngredients("Cut Mushroom")

func _on_CutPineapple_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/CookingTable/CutPineapple.hide()
		CutIngredients("Cut Pineapple")

#__Knead__
func _on_knead_pressed():
	if mouseTexture == "Flour":
		_on_Trash_pressed()
		knead = true
		$NinePatchRect/Front/Up/Buttons/knead.disabled = true

func _on_Dough_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/knead/Dough.hide()
		MouseTexture("Dough")
		$NinePatchRect/Front/Up/Buttons/knead.disabled = false

#__Stove__

func _on_Stove_pressed():
	if mouseTexture == "Cut Tomatoes":
		_on_Trash_pressed()
		stove = true
		$NinePatchRect/Front/Up/Buttons/Stove.disabled = true

func _on_TomatoesSauce_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/Stove/TomatoesSauce.hide()
		MouseTexture("Tomatoes Sauce")
		$NinePatchRect/Front/Up/Buttons/Stove.disabled = false

#__Pizza Table__
func PizzaTable():
	$NinePatchRect/Front/Up/Buttons/PizzaTable/AddIngredient.show()
	$NinePatchRect/Front/Up/Buttons/PizzaTable/AddIngredient/AddIngredientTimer.start()
	_on_Trash_pressed()

func _on_PizzaTable_pressed():
	if mouseTexture == "Tomatoes Sauce":
		PizzaTable()
		if tomatoesSauce == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1.disabled = false
		tomatoesSauce += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1/Label.text = str(tomatoesSauce)
	elif mouseTexture == "Cut Cheese":
		PizzaTable()
		if cutCheese == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2.disabled = false
		cutCheese += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2/Label.text = str(cutCheese)
	elif mouseTexture == "Cut Chicken":
		PizzaTable()
		if cutChicken == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3.disabled = false
		cutChicken += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3/Label.text = str(cutChicken)
	elif mouseTexture == "Cut Pepperoni":
		PizzaTable()
		if cutPepperoni == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4.disabled = false
		cutPepperoni += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4/Label.text = str(cutPepperoni)
	elif mouseTexture == "Cut Ham":
		PizzaTable()
		if cutHam == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5.disabled = false
		cutHam += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5/Label.text = str(cutHam)
	elif mouseTexture == "Cut Mushroom":
		PizzaTable()
		if cutMushroom == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6.disabled = false
		cutMushroom += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6/Label.text = str(cutMushroom)
	elif mouseTexture == "Cut Pineapple":
		PizzaTable()
		if cutPineapple == 0:
			if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7.disabled == true:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7.disabled = false
		cutPineapple += 1
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7/Label.text = str(cutPineapple)
	elif mouseTexture == "Dough":
		PizzaTable()
		if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory1/DoughI1.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory1/DoughI1.disabled = false
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory2/DoughI2.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory2/DoughI2.disabled = false
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory3/DoughI3.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory3/DoughI3.disabled = false
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory4/DoughI4.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory4/DoughI4.disabled = false
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory5/DoughI5.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory5/DoughI5.disabled = false
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory6/DoughI6.disabled == true:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory6/DoughI6.disabled = false
	elif mouseTexture == "" and isPizzaOven == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.show()

func _on_AddIngredientTimer_timeout():
	$NinePatchRect/Front/Up/Buttons/PizzaTable/AddIngredient.hide()

#__Preparing the Pizzas__

func _on_DoughI1_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_DoughI2_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_DoughI3_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_DoughI4_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_DoughI5_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_DoughI6_pressed():
	_on_Trash_pressed()
	MouseTexture("Dough")

func _on_TomatoesSauceI1_pressed():
	_on_Trash_pressed()
	MouseTexture("Tomatoes Sauce")

func _on_CheeseI2_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Cheese")

func _on_ChickenI3_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Chicken")

func _on_PepperoniI4_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Pepperoni")

func _on_HamI5_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Ham")

func _on_MushroomI6_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Mushroom")

func _on_PineappleI7_pressed():
	_on_Trash_pressed()
	MouseTexture("Cut Pineapple")

func _on_Table_pressed():
	if mouseTexture == "Dough" and DoughPizza == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Dough.show()
		_on_Trash_pressed()
		DoughPizza = true
		pizzaCreated.append("Dough")
		if $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory6/DoughI6.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory6/DoughI6.disabled = true
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory5/DoughI5.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory5/DoughI5.disabled = true
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory4/DoughI4.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory4/DoughI4.disabled = true
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory3/DoughI3.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory3/DoughI3.disabled = true
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory2/DoughI2.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory2/DoughI2.disabled = true
		elif $NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory1/DoughI1.disabled == false:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/DoughPlace/Inventory1/DoughI1.disabled = true
	elif mouseTexture == "Tomatoes Sauce" and TomatoeSaucePizza == false and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/TomatoeSauce.show()
		_on_Trash_pressed()
		TomatoeSaucePizza = true
		pizzaCreated.append("Tomatoes Sauce")
		if tomatoesSauce > 1:
			tomatoesSauce -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1/Label.text = str(tomatoesSauce)
		else:
			tomatoesSauce -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1/Label.text = str(tomatoesSauce)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory1/TomatoesSauceI1.disabled = true
	elif mouseTexture == "Cut Cheese" and CheesePizza == false and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Cheese.show()
		_on_Trash_pressed()
		CheesePizza = true
		pizzaCreated.append("Cut Cheese")
		if cutCheese > 1:
			cutCheese -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2/Label.text = str(cutCheese)
		else:
			cutCheese -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2/Label.text = str(cutCheese)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory2/CheeseI2.disabled = true
	elif mouseTexture == "Cut Chicken" and ChickenPizza == false and CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.show()
		_on_Trash_pressed()
		ChickenPizza = true
		pizzaCreated.append("Cut Chicken")
		if cutChicken > 1:
			cutChicken -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3/Label.text = str(cutChicken)
		else:
			cutChicken -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3/Label.text = str(cutChicken)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory3/ChickenI3.disabled = true
	elif mouseTexture == "Cut Pepperoni" and PepperoniPizza == false and CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.show()
		_on_Trash_pressed()
		PepperoniPizza = true
		pizzaCreated.append("Cut Pepperoni")
		if cutPepperoni > 1:
			cutPepperoni -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4/Label.text = str(cutPepperoni)
		else:
			cutPepperoni -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4/Label.text = str(cutPepperoni)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory4/PepperoniI4.disabled = true
	elif mouseTexture == "Cut Ham" and HamPizza == false and CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.show()
		_on_Trash_pressed()
		HamPizza = true
		pizzaCreated.append("Cut Ham")
		if cutHam > 1:
			cutHam -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5/Label.text = str(cutHam)
		else:
			cutHam -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5/Label.text = str(cutHam)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory5/HamI5.disabled = true
	elif mouseTexture == "Cut Mushroom" and MushroomPizza == false and CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.show()
		_on_Trash_pressed()
		MushroomPizza = true
		pizzaCreated.append("Cut Mushroom")
		if cutMushroom > 1:
			cutMushroom -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6/Label.text = str(cutMushroom)
		else:
			cutMushroom -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6/Label.text = str(cutMushroom)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory6/MushroomI6.disabled = true
	elif mouseTexture == "Cut Pineapple" and PineapplePizza == false and CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.show()
		_on_Trash_pressed()
		PineapplePizza = true
		pizzaCreated.append("Cut Pineapple")
		if cutPineapple > 1:
			cutPineapple -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7/Label.text = str(cutPineapple)
		else:
			cutPineapple -=1
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7/Label.text = str(cutPineapple)
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/UpInventory/Inventory7/PineappleI7.disabled = true



func _on_Yes_pressed():
	if CheesePizza == true and TomatoeSaucePizza == true and DoughPizza == true:
		DoughPizza = false
		TomatoeSaucePizza = false
		CheesePizza = false
		ChickenPizza = false
		HamPizza = false
		PepperoniPizza = false
		MushroomPizza = false
		PineapplePizza = false
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Dough.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/TomatoeSauce.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Cheese.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable.hide()
	
		for ingredients in pizzaCreated:
			if ingredients == "Dough":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Dough.show()
			elif ingredients == "Tomatoe Sauce":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/TomatoeSauce.show()
			elif ingredients == "Cut Cheese":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Cheese.show()
			elif ingredients == "Cut Chicken":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Chicken.show()
			elif ingredients == "Cut Ham":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Ham.show()
			elif ingredients == "Cut Pepperoni":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Pepperoni.show()
			elif ingredients == "Cut Mushroom":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Mushroom.show()
			elif ingredients == "Cut Pineapple":
				$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Pineapple.show()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/ButtonPizza.show()


func _on_No_pressed():
	for i in pizzaCreated:
		mouseTexture = i
		_on_PizzaTable_pressed()
	DoughPizza = false
	TomatoeSaucePizza = false
	CheesePizza = false
	ChickenPizza = false
	HamPizza = false
	PepperoniPizza = false
	MushroomPizza = false
	PineapplePizza = false
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Dough.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/TomatoeSauce.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Cheese.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Chicken.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Ham.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pepperoni.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Mushroom.hide()
	$NinePatchRect/Front/Up/Buttons/Menus/PizzaTable/Table/Pineapple.hide()
	pizzaCreated = []


func _on_ButtonPizza_pressed():
	if mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Dough.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/TomatoeSauce.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Cheese.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Chicken.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Ham.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Pepperoni.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Mushroom.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/Pineapple.hide()
		$NinePatchRect/Front/Up/Buttons/PizzaTable/PizzaCompleted/ButtonPizza.hide()
		MouseTexture("Pizza Icon")

#Oven

func _on_ButtonPizzaOven1_pressed():
	if mouseTexture == "Pizza Icon":
		isPizzaOven = true
		_on_Trash_pressed()
		for ingredients in pizzaCreated:
			if ingredients == "Dough":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Dough.show()
			elif ingredients == "Tomatoe Sauce":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/TomatoeSauce.show()
			elif ingredients == "Cut Cheese":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Cheese.show()
			elif ingredients == "Cut Chicken":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Chicken.show()
			elif ingredients == "Cut Ham":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Ham.show()
			elif ingredients == "Cut Pepperoni":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Pepperoni.show()
			elif ingredients == "Cut Mushroom":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Mushroom.show()
			elif ingredients == "Cut Pineapple":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Pineapple.show()
			elif ingredients == "Cooked":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Cooked.show()
			elif ingredients == "Burned":
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Burned.show()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/ButtonPizzaOven1.show()
	elif isPizzaOven == true and mouseTexture == "":
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Dough.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/TomatoeSauce.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Cheese.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Chicken.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Ham.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Pepperoni.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Mushroom.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Pineapple.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Cooked.hide()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Burned.hide()
		MouseTexture("Pizza Icon")
		isPizzaOven = false
		

# Timer

func TimerFunction():
	$NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.show()
	$NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.value +=1
	if $NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.value == $NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.max_value:
		$NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.hide()
		$NinePatchRect/Front/Up/Buttons/CookingTable/CookingTableProgress.value = 0
		cut = false
		cutIngredient = ""
		return true

func _on_Timer_timeout():
	if cut == true:
		if cutIngredient == "Tomatoes":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutTomatoes.show()
		elif cutIngredient == "Cheese":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutCheese.show()
		elif cutIngredient == "Chicken":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutChicken.show()
		elif cutIngredient == "Pepperoni":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutPepperoni.show()
		elif cutIngredient == "Ham":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutHam.show()
		elif cutIngredient == "Mushroom":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutMushroom.show()
		elif cutIngredient == "Pineapple":
			if(TimerFunction()):
				$NinePatchRect/Front/Up/Buttons/CookingTable/CutPineapple.show()
	if knead == true:
		$NinePatchRect/Front/Up/Buttons/knead/KneadProgress.show()
		$NinePatchRect/Front/Up/Buttons/knead/KneadProgress.value +=1
		if $NinePatchRect/Front/Up/Buttons/knead/KneadProgress.value == $NinePatchRect/Front/Up/Buttons/knead/KneadProgress.max_value:
			$NinePatchRect/Front/Up/Buttons/knead/KneadProgress.hide()
			$NinePatchRect/Front/Up/Buttons/knead/KneadProgress.value = 0
			knead = false
			$NinePatchRect/Front/Up/Buttons/knead/Dough.show()
	if stove == true:
		$NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.show()
		$NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.value +=1
		if $NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.value == $NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.max_value:
			$NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.hide()
			$NinePatchRect/Front/Up/Buttons/Stove/StoveProgress.value = 0
			stove = false
			$NinePatchRect/Front/Up/Buttons/Stove/TomatoesSauce.show()
	if isPizzaOven == true and isBurned == false:
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.show()
		$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.value +=1
		if $NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.value == $NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.max_value:
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.hide()
			$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Oven1Progress.value = 0
			if isCooked == false:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Cooked.show()
				pizzaCreated.append("Cooked")
				isCooked = true
			elif isBurned == false:
				$NinePatchRect/Front/Up/Buttons/Menus/PizzaOvenInventory/GridContainer/Inventory1/Icon/PizzaOven/Burned.show()
				pizzaCreated.pop_back()
				pizzaCreated.append("Burned")
				isBurned = true

func _on_Pizza_Box_pressed():
	if mouseTexture == "Pizza Icon":
		customerPizza = pizzaCreated
		_on_Trash_pressed()
		MouseTexture("Pizza Box")


func _on_Deliver_pressed():
	if mouseTexture == "Pizza Box":
		customerPizza.sort()
		print(customerOrders[0])
		print(customerPizza)
		if customerOrders[0] == customerPizza:
			_on_Trash_pressed()
			customerOrders.erase(customerPizza)
			customerPizza = []
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

func _on_Quiz1_tree_exited():
	updateStart()
	Lobby.show()
	AudioButton._on_AudioButton_pressed()
	queue_free()

func updateStart():
	if star > StatsScreen.playerStats["B1"]:
		print(star,"Updated")
		StatsScreen.StatsUpdate("B1", star)
