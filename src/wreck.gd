extends Node2D

@export var showSpeed = 5;
@export var debugNoHide = true;
@export var driftChangeSpeed = 1000;
@export var driftScale = 0.07;
@export var maxSpeed = 1;
var isSpotted = false
var visibility
var time = 0
@onready var noise = FastNoiseLite.new()
@onready var area: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if debugNoHide:
		visibility = 125
	else:
		visibility = 0
	modulate = Color(modulate, visibility)
	randomize()
	noise.seed = randi()
	noise.frequency = 0.001 
	noise.fractal_octaves = 2




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("wreck", global_position)
	time += driftChangeSpeed * delta
	var x = clamp(driftScale * noise.get_noise_2d(noise.seed*2, time), -maxSpeed, maxSpeed)
	var y = clamp(driftScale * noise.get_noise_2d(noise.seed*3, time), -maxSpeed, maxSpeed)
	global_position += Vector2(x, y)

	if isSpotted:
		visibility = clamp(visibility + showSpeed * delta, 0, 255)
		modulate = Color(modulate, visibility)

func move(delta):
	pass

func spotted():
	if !isSpotted:
		isSpotted = true
		print("spotted")

func rescued():
	print("rescued")
	queue_free()
	
