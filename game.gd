extends Node2D

const VU_COUNT = 180
const FREQ_MAX = 11050.0

const enemy = preload("res://enemy.tscn")

const ENEMIES_NB = 10

onready var window_w = get_viewport().size.x
onready var window_h = get_viewport().size.y
const HEIGHT = 300
onready var offset = Vector2(window_w/2, window_h/2)
const MIN_DB = 60
const BASE_CIRCLE = 60
var spectrum = null
var recording
var effect = null
var points

onready var color = Color(randf(), randf(), randf())

func _draw():
	if effect != null and effect.is_recording_active():
		#warning-ignore:integer_division
		var w = window_w / VU_COUNT
		var prev_hz = 0
		points = PoolVector2Array([])
		for i in range(1, VU_COUNT+1):	
			var hz = i * FREQ_MAX / VU_COUNT;
			var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
			var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
			var height = energy * HEIGHT
			#draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.white)
			prev_hz = hz
			
			var phi = i * PI * 2.0 / VU_COUNT
			var v = Vector2(sin(phi), cos(phi))
			points.push_back((BASE_CIRCLE * v) + (v * height))
		
		draw_set_transform(Vector2(offset.x, offset.y), deg2rad(-90), Vector2(1.0, 1.0))
		draw_colored_polygon(points, color)
		

	#draw_colored_polygon(points, Color(1.0, 1.0, 1.0))

func _process(_delta):
	update()

func _physics_process(delta):
	if points:
		for point in points:
			# Cast to point
			$Player/RayCast2D.set_cast_to(Vector2(point.x, point.y))
			#print(Vector2(point.x, point.y))
#			# Check if collision
			$Player/RayCast2D.force_raycast_update()
			if $Player/RayCast2D.is_colliding():
				var enemy = $Player/RayCast2D.get_collider()
				print(enemy)
				$EnemiesContainer.remove_child(enemy)
	
	for i in range($EnemiesContainer.get_child_count()):
		$EnemiesContainer.get_child(i).move_toward($Player/RayCast2D.global_position)


func _ready():
	randomize()
	
	
	effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	effect.set_recording_active(true)
	
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	spectrum = AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("Record"), 1)
	
	$Player.global_position = offset
	$Player/Area2D.connect("body_exited", self, "_on_Area2D_body_entered")
	$Player/RayCast2D.position = offset
	
	# Spawn enemies
	for i in range(ENEMIES_NB):
		$EnemiesContainer.add_child(enemy.instance())

func _on_viewport_size_changed():
	# Do whatever you need to do when the window changes!
	print ("Viewport size changed")
	window_w = get_viewport().size.x
	window_h = get_viewport().size.y
	offset = Vector2(window_w/2, window_h/2)
	$Player/RayCast2D.position = offset

func _on_Timer_timeout():
	color = Color(randf(), randf(), randf())

func _on_Area2D_body_entered(body):
	print("AAAAAAAAAAA")
	get_tree().reload_current_scene()
