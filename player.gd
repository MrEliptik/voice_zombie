extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _on_Area2D_body_entered(body):
	print("DEAD")
