extends Control

onready var BasicRestaurantB2 = get_node("/root/BasicRestaurant")

export var blinkTime = 5
export var typeChef = 1
var pressed = false
var pos = 0
var cutIngredients = ["Cut Tomatoes" , "Cut Cheese", "Cut Mushroom", "Cut Tomatoes" , "Cut Cheese", "Cut Ham", "Cut Tomatoes", "Cut Cheese", "Cut Chicken", "Cut Pineapple", "Cut Tomatoes", "Cut Cheese", "Cut Pepperoni", "Cut Ham"]

func _ready():
	$AnimatedSprite/Timer.wait_time = blinkTime

func _on_Timer_timeout():
	$AnimatedSprite.play("idle"+str(typeChef))

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()

func _on_ChefButton_pressed():
	$Particles.show()
	$Particles/ParticlesTimer.start()
	$AnimatedSprite.show()
	$AnimatedSprite.play("idle"+str(typeChef))
	$ChefButton.hide()
	pressed = true
	$AnimatedSprite/AddIngredient/addIngredientTimer.start()

func _on_ParticlesTimer_timeout():
	$Particles.queue_free()


func _on_addIngredientTimer_timeout():
	addIngredientOnTable()

func _on_endIngredientTimer_timeout():
	$AnimatedSprite/AddIngredient.hide()

func addIngredientOnTable():
	if typeChef == 1:
		$AnimatedSprite/AddIngredient/Ingredient.texture = load("res://Assets/Images/Levels/Ingredients/"+cutIngredients[pos]+" Normal.png")
		BasicRestaurantB2.IngredientType = cutIngredients[pos]
		BasicRestaurantB2.pizzaTableAddIngredients()
		$AnimatedSprite/AddIngredient.show()
		$AnimatedSprite/AddIngredient/endIngredientTimer.start()
		if pos <13:
			pos += 1
		else:
			pos = 0
	elif typeChef == 2:
		$AnimatedSprite/AddIngredient/Ingredient.texture = load("res://Assets/Images/Levels/Ingredients/Dough Normal.png")
		BasicRestaurantB2.IngredientType = "Dough"
		BasicRestaurantB2.pizzaTableAddIngredients()
		$AnimatedSprite/AddIngredient.show()
		$AnimatedSprite/AddIngredient/endIngredientTimer.start()
	elif typeChef == 3:
		if BasicRestaurantB2.cutTomatoes > 0:
			BasicRestaurantB2.IngredientType = "Tomatoes Sauce"
			BasicRestaurantB2.cutTomatoes -= 1
			$AnimatedSprite/AddIngredient/Ingredient.texture = load("res://Assets/Images/Levels/Ingredients/Tomatoes Sauce Normal.png")
			BasicRestaurantB2.IngredientType = "Tomatoes Sauce"
			BasicRestaurantB2.pizzaTableAddIngredients()
			$AnimatedSprite/AddIngredient.show()
			$AnimatedSprite/AddIngredient/endIngredientTimer.start()
