extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("laser"):
		body.queue_free()
		$Checkmark.visible = true
		set_meta("completed", true)
		
		get_parent().find_child("GameManager").reciever_cleared()
