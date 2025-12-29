extends Area2D

var busy = false
var dragging = false

var out_dir = Vector2(0, 1)

func _ready():
	$Flip.body_entered.connect(flip)
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		dragging = event.pressed

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("Rotate"):
			rotation += deg_to_rad(45)
			out_dir = out_dir.rotated(deg_to_rad(45)).normalized()

func flip(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			var curr_dir = body.get_meta("Direction")
			body.set_meta("Direction", -out_dir)
			body.position = position
			
			await get_tree().create_timer(1.0).timeout
			busy = false
