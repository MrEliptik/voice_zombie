extends KinematicBody2D

var target
var multiplier = 1
var speed = 1

onready var spawn_location = [Vector2(0, 0), Vector2(get_viewport().size.x, 0), 
	Vector2(get_viewport().size.x, get_viewport().size.y), Vector2(0, get_viewport().size.y)]

func init(multiplier):
	self.multiplier = multiplier
	speed = rand_range(30, 40) * multiplier

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = spawn_location[rand_range(0, len(spawn_location)-1)]

func _draw():
	#draw_rect(Rect2(Vector2(0, 0), Vector2(20, 20)), Color(0.5, 0.5, 0.5))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Tween.interpolate_property($Sprite, "scale", 0.150, 0.8, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	#$Tween.start()
	update()
	
func _physics_process(delta):
	if target:
		move_and_collide(target * speed * delta)
	
func move_toward(point):
	#print('At: ' + str(self.global_position) + ' moving to ' + str(point))
	target = (point - self.global_position).normalized()
