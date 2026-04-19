extends Path2D

@export var spawnCount = 5
@export var scene: PackedScene = preload("res://src/scenes/wreck.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_spawn_location = $SpawnLocation
	for x in range(spawnCount):
		mob_spawn_location.progress_ratio = randf()
		print("spawn", x, mob_spawn_location.global_position)
		var instance = scene.instantiate()
		add_sibling.call_deferred(instance)
		instance.global_position = mob_spawn_location.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
