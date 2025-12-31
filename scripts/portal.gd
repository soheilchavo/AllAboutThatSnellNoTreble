extends Area2D

@export var sister_portal : Node2D
var busy = false
var dragging = false

var out_rot = 180
var offset_distance = -35

func _ready():
	$Entrance.body_entered.connect(teleport)
	input_event.connect(_on_input_event)
	out_rot = deg_to_rad(out_rot)
	
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		dragging = event.pressed

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("Rotate"):
			rotation += deg_to_rad(90)
			out_rot += deg_to_rad(90)

func teleport(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			var laser_direction = Vector2.from_angle(body.rotation).normalized()
			var new_dir = Vector2(laser_direction.y, laser_direction.x)
			new_dir = new_dir.rotated(sister_portal.out_rot)
			body.set_meta("Direction", -new_dir)
			body.position = sister_portal.position + new_dir * offset_distance
			await get_tree().create_timer(0.2).timeout
			busy = false
