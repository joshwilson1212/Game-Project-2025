extends Control
@onready var controls: Control = $"../Controls"
@onready var pause_menue: Control = $"../PauseMenue"

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Pause") and visible == true:
	#	_on_back_pressed()
	pass
func _on_back_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scene/UI/main_menu.tscn")
	print("back")
	visible = false
	pause_menue.visible = true

func _on_controls_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scene/UI/controls.tscn")
	controls.visible = true
	visible = false
