extends Area2D
@onready var enemy_skeleton: Node2D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#
func _on_area_entered(area: Area2D):
	#removed the node from the scene if collided with a hidbox with the name containing sword
	#should probably change this to a tag of some sort like weapon
	if area.name.contains("sword"):
		enemy_skeleton.queue_free()
	print("hit:{0}".format([area.name]))
	pass # Replace with function body.
