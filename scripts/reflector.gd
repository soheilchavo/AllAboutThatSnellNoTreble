extends Area2D

var busy = false
var dragging = false

func _ready():
	$PositiveFlip.body_entered.connect(positive_flip)
	$NegativeFlip.body_entered.connect(negative_flip)
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		dragging = event.pressed

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("Rotate"):
			rotation += deg_to_rad(90)

func positive_flip(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			var curr_dir = body.get_meta("Direction")
			var new_dir = curr_dir.rotated(deg_to_rad(-90))
			body.set_meta("Direction", new_dir)
			body.position = position
			await get_tree().create_timer(1.0).timeout
			busy = false

func negative_flip(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			var curr_dir = body.get_meta("Direction")
			var new_dir = curr_dir.rotated(deg_to_rad(90))
			body.set_meta("Direction", new_dir)
			body.position = position
			await get_tree().create_timer(1.0).timeout
			busy = false
