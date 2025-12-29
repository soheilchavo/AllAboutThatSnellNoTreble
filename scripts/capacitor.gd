extends Area2D

var busy = false
var dragging = false

var out_dir = Vector2(0, 1)
var charge_time = 1

func _ready():
	$Charge.body_entered.connect(charge)
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		dragging = event.pressed

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

func charge(body):
	if not busy:
		if body.is_in_group("laser"):
			busy = true
			await get_tree().create_timer(0.05).timeout
			if body:
				out_dir = body.get_meta("Direction")
				body.queue_free()
				$Symbol.visible = true
				await get_tree().create_timer(charge_time).timeout
				
				var laser = load("res://scenes/Laser.tscn")
				var instance = laser.instantiate()
				get_parent().add_child.call_deferred(instance)
				
				instance.position = global_position
				instance.set_meta("Direction", out_dir)
				$Symbol.visible = false
				
				await get_tree().create_timer(0.4).timeout
				busy = false
