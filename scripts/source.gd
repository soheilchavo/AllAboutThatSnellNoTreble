extends StaticBody2D

@export var direction : Vector2

func launch():
	var laser = load("res://scenes/Laser.tscn")
	var instance = laser.instantiate()
	get_parent().add_child.call_deferred(instance)
	
	instance.position = $Mussel.global_position
	instance.set_meta("Direction", direction)
