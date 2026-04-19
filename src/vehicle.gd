extends Node2D

@export var speed = 400
@export var spotRange = 200
@export var rescueRange = 20
@export var fuel = 100
@export var fuelBurnRate = 1

@onready var rescueArea = $Sprite2D/WinchSprite/Area2D
@onready var sprite = $Sprite2D
@onready var winchSprite = $Sprite2D/WinchSprite
@onready var info = $"../CanvasLayer/Stats"
@onready var banner = $"../CanvasLayer/Banner"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spotRange = pow(spotRange, 2)
	rescueRange = pow(rescueRange, 2)

# Called every frame. 'delta' is the elapsed time since the previous draw.
func _process(delta: float) -> void:   
	fuel -= delta * fuelBurnRate
	fuel = clamp(fuel, 0, 100)
	if fuel == 0:
		lose()
	move(delta)
	checkRescue()
	
func win():
	banner.win()
	
func lose():
	banner.lose()
	
func checkRescue():
	var wrecks = get_tree().get_nodes_in_group("wreck")
	info.setSignals(wrecks.size())
	if wrecks.size() == 0:
		win()
	info.setFuel(fuel)
	var pos = global_position
	for wreck in wrecks:
		var target = wreck.global_position
		if (pos.distance_squared_to(target) < spotRange):
			if !wreck.isSpotted:
				wreck.spotted()
				var sound = $FoundPing
				if !sound.playing:
					sound.play()
		if (
			rescueArea.overlaps_area(wreck.area)
			and winchSprite.visible
		):
			wreck.rescued()
			var sound = $SuccessPing
			if !sound.playing:
				sound.play()

func move(delta: float) -> void:    
	#print("player", global_position)                          
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("winch"):
		winchSprite.activate()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if velocity.x > 0:
			sprite.flip_h = false
			sprite.rotation = PI / 8
		else:
			sprite.flip_h = true
			sprite.rotation = -PI / 8
	else:
		sprite.rotation = 0
	position += velocity * delta
