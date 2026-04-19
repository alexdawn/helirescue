extends Label

@export var decayRate = 1
@export var decayFinish = 0.25

var finished = false
var decay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decay = decayRate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate = Color(modulate, clamp(modulate.a - decay * delta, 0, 1))

func win():
	if !finished:
		finished = true
		modulate.a = 1.0
		decay = decayFinish
		text = "A WINNER IS YOU"
	
func lose():
	if !finished:
		finished = true
		modulate.a = 1.0
		decay = decayFinish
		modulate = Color(5, 0, 0)
		text = "YOU CRASH AND BURN"
