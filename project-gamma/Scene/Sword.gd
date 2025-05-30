extends Node2D
@onready var sword: Node2D = $"."
@onready var swordSprite: Sprite2D = $Sword


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	#print(sword.transform.get_rotation())
	if sword.transform.get_rotation()*180/3.14 > 90 or sword.transform.get_rotation()*180/3.14 < -90:
		swordSprite.flip_v = true
	else:
		swordSprite.flip_v = false
