extends Control
@onready var options: Control = $"../Options"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scene/UI/Options.tscn")
	visible = false
	options.visible = true
