extends CharacterBody2D

var speed = 100
var moving:bool = false
var new_dest = Vector2()
const COIN = preload("res://Scene/Prefabs/coin.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var progress_bar: ProgressBar = $ProgressBar
const SKELETON_2_ = preload("res://Assets/ASSETS_Ours/Skeleton/Skeleton_2_.png")
var health = Health.new()
var hit_value = 0

func _ready() -> void:
	hit_value = progress_bar.value/5
	health.set_max_health(5)
	health.set_health(5)

func _physics_process(_delta: float) -> void:
	if round((new_dest-global_position).length()) < 25:
		moving = false
	if moving == true:
		move_and_slide()
	
func go_to(dest:Vector2):
	moving = true
	new_dest = dest
	var direction = dest - global_position
	var new_velocity = direction.normalized() * speed
	velocity = new_velocity
	
func _on_area_entered(area: Area2D):
	if area.name.contains("sword"):
		health.health -=1
		progress_bar.value-= hit_value
	if health.get_health() <= 2:
		sprite_2d.texture = SKELETON_2_
		print("low")
	if health.get_health() <= 0:
		queue_free()
		
func _exit_tree() -> void:
	var coin_instance = COIN.instantiate()
	coin_instance.position = global_position	
	get_tree().current_scene.add_child.call_deferred(coin_instance)
