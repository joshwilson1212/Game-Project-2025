class_name HotKeyRebindButton
extends Control
@onready var label: Label = $HBoxContainer/Label as Label
@onready var button: Button = $HBoxContainer/Button as Button
@export var action_name : String = "move_left"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name() -> void:
	label.text = "Unassigned"
	match action_name:
		"move_left":
			label.text = "Walk Left"
		"move_right":
			label.text = "Walk Right"
		"move_up":
			label.text = "Walk Up"
		"move_down":
			label.text = "Walk Down"
		"dash":
			label.text = "Dash"
		"Attack":
			label.text = "Attack"
		"Interact":
			label.text = "Interact"
		"Pause":
			label.text = "Pause"
		"Inventory":
			label.text = "Inventory"
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_keycode = "null"
	#print(action_events)
	var action_event = action_events[0]
	#catches error relating to mouse button keycode
	if action_name == "Attack":
		action_keycode = "Mouse1"
	else:
		action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	#print(action_keycode)
	button.text = "%s" % action_keycode
	
func _on_button_toggled(button_pressed) -> void:
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
		
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event)->void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name,event)
	
	set_process_unhandled_input(false)
	set_text_for_key()
	set_action_name()
