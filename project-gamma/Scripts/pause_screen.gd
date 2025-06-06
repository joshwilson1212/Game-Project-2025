extends Node2D
@onready var pause_menue: Control = $"UI Elements/PauseMenue"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(.1).timeout
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
func pauseMenu():
	if get_tree().paused == true:
		get_tree().paused = false
		pause_menue.visible = false
	else:
		get_tree().paused = true
		pause_menue.visible = true
		
