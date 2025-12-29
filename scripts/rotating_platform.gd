extends Node2D

@export var SPEED : float
var activated = false

func _process(delta: float) -> void:
	if activated:
		for child in get_children():
			child.rotation_degrees += SPEED * delta

func activate():
	activated = true
