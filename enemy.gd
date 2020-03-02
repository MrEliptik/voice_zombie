extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(20, 20)), Color(0.5, 0.5, 0.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	
func move_toward(point):
	#print('Moving')
	pass
