extends Node2D
@export var current_level : int

func _ready():
	if Global.saved_transforms.size() > 0:
		var resources = get_parent().find_child("Resources")
		var super_reflector_index = 0
		var portal_index = 0
		for i in range(resources.get_child_count()):
			resources.get_child(i).position = Global.saved_transforms[i].position
			resources.get_child(i).rotation = Global.saved_transforms[i].rotation
			
			if resources.get_child(i).is_in_group("super_reflector"):
				resources.get_child(i).out_dir = Global.saved_reflector_dir[super_reflector_index]
				super_reflector_index += 1
			if resources.get_child(i).is_in_group("portal"):
				resources.get_child(i).out_rot = Global.saved_portal_rot[portal_index]
				portal_index += 1
		Global.saved_transforms = []  # Clear after use
	
func reciever_cleared():
	for reciever in get_tree().get_nodes_in_group("Reciever"):
		if reciever.get_meta("completed") == false:
			return
	get_parent().find_child("NextLevel").next_level = current_level + 1
	get_parent().find_child("NextLevel").visible = true
