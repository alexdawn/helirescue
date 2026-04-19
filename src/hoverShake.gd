extends AnimatedSprite2D

@export var magnitude = 5
@export var speed = 2

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position.y = sin(time * speed) * magnitude
