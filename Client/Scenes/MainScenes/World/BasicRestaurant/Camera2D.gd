extends Camera2D

var zoomMin = Vector2 (.200001, .200001)
var zoomMax = Vector2 (1, 1)
var zoomSpeed = Vector2 (.2, .2)
var desZoom = zoom

func _process(_delta):
	zoom = lerp(zoom, desZoom, .2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index ==  BUTTON_WHEEL_UP:
				if desZoom > zoomMin:
					desZoom -= zoomSpeed
			if event.button_index ==  BUTTON_WHEEL_DOWN:
				if desZoom < zoomMax:
					desZoom += zoomSpeed
