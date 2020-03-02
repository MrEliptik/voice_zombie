extends Node2D

const VU_COUNT = 360
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

onready var color = Color(randf(), randf(), randf())

func _draw():
	if effect != null and effect.is_recording_active():
		#warning-ignore:integer_division
		var w = window_w / VU_COUNT
		var prev_hz = 0
		var points = PoolVector2Array([])
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
		

	draw_colored_polygon(points, Color(1.0, 1.0, 1.0))

func _process(_delta):
	update()
	
	for i in range($EnemiesContainer.get_child_count()):
		$EnemiesContainer.get_child(i).move_toward($Player.global_position)


func _ready():
	randomize()
	
	effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	effect.set_recording_active(true)
	
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	spectrum = AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("Record"), 1)
	
	# Spawn enemies
	for i in range(ENEMIES_NB):
		$EnemiesContainer.add_child(enemy.instance())

func _on_viewport_size_changed():
	# Do whatever you need to do when the window changes!
	print ("Viewport size changed")
	window_w = get_viewport().size.x
	offset = window_w/2

func _on_Timer_timeout():
	color = Color(randf(), randf(), randf())
