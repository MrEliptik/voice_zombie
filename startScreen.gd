extends Control

signal start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if !visible: return
	if event.is_action_released("ui_accept") \
		or event.is_action_released("ui_left_click") \
		or event.is_action_released("ui_right_click"):
		emit_signal("start")

