extends Area2D

var going = false

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and not going:
		going = true
		$PlayButton.visible = false
		$PlayButtonDisabled.visible = true
		for source in get_tree().get_nodes_in_group("source"):
			source.launch()
		for obj in get_tree().get_nodes_in_group("object"):
			obj.activate()
