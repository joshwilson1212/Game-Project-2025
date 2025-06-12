extends Area2D

@onready var enemy_skeleton: Node2D = $"../.."
@onready var game: Node2D = $"."
const COIN = preload("res://Scene/Prefabs/coin.tscn")
@onready var progress_bar: ProgressBar = $"../../ProgressBar"
@onready var sprite_2d: Sprite2D = $".."
const SKELETON_2_ = preload("res://Assets/ASSETS_Ours/Skeleton/Skeleton_2_.png")
var health = Health.new()
var hit_value = 0

func _ready() -> void:
	hit_value = progress_bar.value/5
	health.set_max_health(5)
	health.set_health(5)
	
func _on_area_entered(area: Area2D):
	#removed the node from the scene if collided with a hidbox with the name containing sword
	#should probably change this to a tag of some sort like weapon
	if area.name.contains("sword"):
		health.health -=1
		progress_bar.value-= hit_value
		#print(hit_value)
	if health.get_health() <= 2:
		sprite_2d.texture = SKELETON_2_
		print("low")
	if health.get_health() <= 0:
		enemy_skeleton.queue_free()

#fucntion is called right before being "deleted" or freeed from the queue
#will need to write some sort of function to determin drops
#for now it will just drop something
func _exit_tree() -> void:
	var coin_instance = COIN.instantiate()
	coin_instance.position = enemy_skeleton.global_position	
	get_tree().current_scene.add_child.call_deferred(coin_instance)
	#print("SKELETON DEAD")
