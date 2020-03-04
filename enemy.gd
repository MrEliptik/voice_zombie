extends KinematicBody2D

var target
var multiplier = 1
var speed = 1
var dead = false

onready var spawn_location = [
		Vector2(0, rand_range(0, get_viewport().size.y)), 
		Vector2(rand_range(0, get_viewport().size.x), 0), 
		Vector2(get_viewport().size.x, rand_range(0, get_viewport().size.y)),
		Vector2(rand_range(0, get_viewport().size.x), get_viewport().size.y)
	]

func init(multiplier):
	self.multiplier = multiplier
	speed = rand_range(25, 35) * multiplier

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = spawn_location[randi()%len(spawn_location)]

func _draw():
	#draw_rect(Rect2(Vector2(0, 0), Vector2(20, 20)), Color(0.5, 0.5, 0.5))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	
func _physics_process(delta):
	if target:
		move_and_collide(target * speed * delta)
		
func die():
	if dead: return
	dead = true
	$fake_explosion_particles.visible = true
	$fake_explosion_particles.particles_explode = true
	$Sprite.visible = false
	var select_idx = randi()%$SFX.get_child_count()
	var sound = $SFX.get_child(select_idx)
	sound.play()
	
func move_toward(point):
	#print('At: ' + str(self.global_position) + ' moving to ' + str(point))
	target = (point - self.global_position).normalized()
