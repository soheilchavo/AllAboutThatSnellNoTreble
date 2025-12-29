extends Node2D

@export var SPEED : float
@export var AMPLITUDE : float
@export var OFFSET : float
var BEGIN_TIME : float
var activated = false

func _process(delta: float) -> void:
	if activated:
		for child in get_children():
			child.position.x += AMPLITUDE * sin(OFFSET + SPEED * (Time.get_ticks_msec() - BEGIN_TIME)/1000)

func activate():
	activated = true
	BEGIN_TIME = Time.get_ticks_msec()
