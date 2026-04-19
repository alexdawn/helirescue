extends Label

@export var decayRate = 0.5
@export var decayFinish = 0.1

@onready var sub = $SubLabel

var finished = false
var decay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decay = decayRate
	sub.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate = Color(modulate, clamp(modulate.a - decay * delta, 0, 1))
	if finished:
		if Input.is_action_pressed("restart"):
			get_tree().reload_current_scene()

func win():
	if !finished:
		finished = true
		modulate.a = 1.0
		decay = decayFinish
		text = "everyone is saved"
		sub.text = "press r to play again"
	
func lose():
	if !finished:
		finished = true
		modulate.a = 1.0
		decay = decayFinish
		modulate = Color(5, 0, 0)
		text = "YOU CRASH AND BURN"
		sub.text = "press r to try again"
