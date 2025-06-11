extends Area2D
@onready var enemy_skeleton: Node2D = $"../.."
@onready var game: Node2D = $"."
const COIN = preload("res://Scene/Prefabs/coin.tscn")
@onready var progress_bar: ProgressBar = $"../../ProgressBar"
@onready var sprite_2d: Sprite2D = $".."
const SKELETON_2_ = preload("res://ASSETS_Ours/Skeleton/Skeleton_2_.png")
var HEALTH = 5
var hit_value = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_value = progress_bar.value/5
func _on_area_entered(area: Area2D):
	#removed the node from the scene if collided with a hidbox with the name containing sword
	#should probably change this to a tag of some sort like weapon
	if area.name.contains("sword"):
		HEALTH-=1
		progress_bar.value-= hit_value
		#print(hit_value)
	if HEALTH <= 2:
		sprite_2d.texture = SKELETON_2_
		print("low")
	if HEALTH <= 0:
		enemy_skeleton.queue_free()
	#print("hit:{0}".format([area.name]))
	pass # Replace with function body.

#fucntion is called right before being "deleted" or freeed from the queue
#will need to write some sort of function to determin drops
#for now it will just drop something
func _exit_tree() -> void:
	var coin_instance = COIN.instantiate()
	coin_instance.position = enemy_skeleton.global_position	
	get_tree().current_scene.add_child.call_deferred(coin_instance)
	#print("SKELETON DEAD")
