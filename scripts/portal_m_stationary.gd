extends Area2D

@export var sister_portal : Node2D
var busy = false
var dragging = false

var out_rot = 180
var offset_distance = 35

func _ready():
	$Entrance.body_entered.connect(teleport)
	out_rot = deg_to_rad(out_rot)

func teleport(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			var laser_direction = Vector2.from_angle(body.rotation).normalized()
			var new_dir = Vector2(laser_direction.y, laser_direction.x)
			
				
			
			
			#Laser is 0 90 180 or 270
			if abs(int(new_dir.y) - int(new_dir.x)) == 1:				
				if int(out_rot) % 180 == 0:
					if abs(new_dir.y) == 1:					
						var rotated_dir = new_dir.rotated(deg_to_rad(90))
						body.set_meta("Direction", -rotated_dir)
					else:						
						var rotated_dir = new_dir.rotated(deg_to_rad(90))
						body.set_meta("Direction", -rotated_dir)
				else:
					if abs(new_dir.y) == 1:						
						var rotated_dir = new_dir.rotated(deg_to_rad(-90))
						body.set_meta("Direction", -rotated_dir)
					else:						
						var rotated_dir = new_dir.rotated(deg_to_rad(-90))
						body.set_meta("Direction", -rotated_dir)
				
				body.position = position
			else:
				new_dir = new_dir.rotated(sister_portal.out_rot).rotated(PI)
				body.set_meta("Direction", new_dir)
				body.position = sister_portal.position + new_dir * offset_distance
				
			await get_tree().create_timer(0.2).timeout
			busy = false
