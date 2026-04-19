extends Sprite2D

signal pinged(target: Vector2)

@export var decay = 50
@export var ping_strength = 10
var transparancy = 0

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transparancy = clamp(transparancy - delta * decay, 0, 255)
	self_modulate = Color(128, 128, 128, transparancy)


func _on_pinged(target: Vector2) -> void:
	look_at(target)
	transparancy = ping_strength
