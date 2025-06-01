extends Node2D
const GAME_TEST_2 = "res://Scene/Game Test 2.tscn"
var atDoor = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		atDoor = true
		print("At Door")
func _process(delta):
	if Input.is_action_just_pressed("Interact") and atDoor:
		get_tree().change_scene_to_file(GAME_TEST_2)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("awayfromdoor")
		atDoor = false
