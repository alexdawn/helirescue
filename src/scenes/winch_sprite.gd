extends Sprite2D

@export var speed = 4
@export var mag = 10

@onready var rope = $"../Rope"

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		time += delta
		position.y = sin(time * speed) * mag
		rope.scale.y = 1 + position.y * 0.4
		if position.y <= 0:
			visible = false

func activate():
	if !visible:
		visible = true
		time = 0
