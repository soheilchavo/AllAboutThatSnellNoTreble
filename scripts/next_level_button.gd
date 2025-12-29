extends Area2D

@export var next_level : int

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://Levels/Level" + str(next_level) + ".tscn")
