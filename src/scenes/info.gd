extends Label

@export var template = 'Signals Remaining: [%s], Fuel: [%-5.2f]'

var signals = 0
var fuel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = template % [signals, fuel]

func setFuel(x):
	fuel = x

func setSignals(x):
	signals = x
