extends Area2D
func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var resources = get_parent().find_child("Resources")
		Global.saved_transforms = []
		Global.saved_reflector_dir = []
		for child in resources.get_children():
			Global.saved_transforms.append({
				"position": child.position,
				"rotation": child.rotation
			})
			if child.is_in_group("super_reflector"):
				Global.saved_reflector_dir.append(child.out_dir)
		get_tree().reload_current_scene()
