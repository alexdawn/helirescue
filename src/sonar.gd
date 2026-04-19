extends AudioListener2D

@onready var pingIcon: Node2D = $"../PingIcon"

@export var cooldown_time = 1
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = cooldown_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if time > cooldown_time:
		# need pick and response
		ping()
		time = 0

func ping():
	var wrecks = get_tree().get_nodes_in_group("wreck")
	var nearest = null
	var nearest_distance = INF
	var pos = pingIcon.global_position

	for wreck in wrecks:
		var target = wreck.global_position
		var audio_player: AudioStreamPlayer2D = wreck.get_child(1)
		if !audio_player.playing:
			audio_player.play()
		if (pos.distance_squared_to(target) < nearest_distance):
			nearest = wreck
			nearest_distance = pos.distance_squared_to(target)
	if nearest != null:
		var target = nearest.global_position
		pingIcon.pinged.emit(target)
