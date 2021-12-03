extends Node2D

#Global Variables
var mousePosition = ""

func _physics_process(_delta):
	mousePosition=get_local_mouse_position()

#Event Functions
func _input(_ev):
	pass
