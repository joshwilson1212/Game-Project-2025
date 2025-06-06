extends Control
@onready var game: Node2D = $"../.."
@onready var options: Control = $"../Options"
@onready var pause_menue: Control = $"."

'''
func _process(delta: float) -> void:
	await get_tree().create_timer(.1).timeout
	if Input.is_action_just_pressed("Pause") and visible == true:
		print("unpause")
		get_tree().paused = false
		visible = false
		
'''

func _on_resume_button_pressed() -> void:
	print("resumed")
	game.pauseMenu()

func _on_options_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scene/UI/Options.tscn")
	options.visible = true
	visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
