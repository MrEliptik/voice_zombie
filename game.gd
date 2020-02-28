extends Node2D

const VU_COUNT = 360
const FREQ_MAX = 11050.0

onready var width = get_viewport().size.x
const HEIGHT = 100

const MIN_DB = 60

var spectrum = null
var recording
var effect = null

func _draw():
	if effect != null and effect.is_recording_active():
		#warning-ignore:integer_division
		var w = width / VU_COUNT
		var prev_hz = 0
		for i in range(1, VU_COUNT+1):	
			var hz = i * FREQ_MAX / VU_COUNT;
			var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
			var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
			var height = energy * HEIGHT
			draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.white)
			prev_hz = hz


func _process(_delta):
	update()


func _ready():
	effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	effect.set_recording_active(true)
	
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
	spectrum = AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("Record"), 1)

func _on_viewport_size_changed():
	# Do whatever you need to do when the window changes!
	print ("Viewport size changed")
	width = get_viewport().size.x
