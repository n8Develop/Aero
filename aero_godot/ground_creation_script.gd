extends Node

var ground_size = Vector2(20,20)
var next_chunk_coord = Vector3(0,0,0)


@onready var map = $Ground
@onready var player = $Player_Root
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var next_trigger = (next_chunk_coord.z * 10) - (ground_size.y * 10)
	if player.translation.z > next_trigger:
		create_chunk(ground_size.x, ground_size.y)

func create_chunk(chunk_width, chunk_length):
	for x in chunk_width:
		for z in chunk_length:
			var a = (randi() % 2)
			map.set_cell_item(x, 0, z + next_chunk_coord.z +1, a)
	next_chunk_coord.z += chunk_length
