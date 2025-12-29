extends RigidBody2D

var SPEED = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Set Body rotation to metadata direction
	var dir = get_meta("Direction")
	rotation_degrees = int(rad_to_deg(dir.angle())) + 90

	#Apply velocity
	var collision = move_and_collide(dir * SPEED * delta)
	if collision and (collision.get_collider().is_in_group("wall") or collision.get_collider().is_in_group("laser")) :
		queue_free()
