extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_score(score):
	$Score.text = 'SCORE: ' + str(score)

func set_wave(wave):
	$Wave.text = 'WAVE ' + str(wave)
	$WaveBig.text = 'WAVE ' + str(wave)
