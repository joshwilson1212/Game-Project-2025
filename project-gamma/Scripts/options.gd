extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/UI/main_menu.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/UI/controls.tscn")
