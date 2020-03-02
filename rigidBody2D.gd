extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_circle(Vector2(0, 0), 30, Color(0.5, 0.5, 0.5))
	
func _process(delta):
	update()

func move_toward(point):
	#print('Moving')
	pass
