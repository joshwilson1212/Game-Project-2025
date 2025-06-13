class_name FollowMovementC extends Node

@export var speed = 20

@onready var parent: CharacterBody2D = get_parent()

var start_position
var target: Player


func _ready() -> void:
	start_position = parent.position

func update_velocity():
	if target == null: return
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity


func _physics_process(_delta) -> void:
	
	if target == null: return
	update_velocity()
	parent.move_and_slide()

func disable() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _on_follow_area_body_entered(body):
	if body is Player:
		target = body

func _on_follow_area_body_exited(body):
	if body is Player:
		target = null
