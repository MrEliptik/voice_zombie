extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	pass
#	if effect != null and effect.is_recording_active():
#		#warning-ignore:integer_division
#		var w = window_w / VU_COUNT
#		var prev_hz = 0
#		var points = PoolVector2Array([])
#		for i in range(1, VU_COUNT+1):	
#			var hz = i * FREQ_MAX / VU_COUNT;
#			var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
#			var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
#			var height = energy * HEIGHT
#			#draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.white)
#			prev_hz = hz
#
#			var phi = i * PI * 2.0 / VU_COUNT
#			var v = Vector2(sin(phi), cos(phi))
#			points.push_back((BASE_CIRCLE * v) + (v * height))
#
#		draw_set_transform(Vector2(offset.x, offset.y), deg2rad(-90), Vector2(1.0, 1.0))
#		draw_colored_polygon(points, color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
