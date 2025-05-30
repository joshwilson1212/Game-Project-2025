class_name Player extends CharacterBody2D

var SPEED = 100
var is_ready: bool = true
var Can_Attack = true
@export var attacking = false;
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation = $Sprites/Sword/AnimationPlayer
var idle_direction = "Down Idel"
@onready var attack_cd: Timer = $"Sprites/Sword/sword hit/AttackCD"

func _process(delta):
	#checks if the mouse button was clicked and moves the sword
	if Input.is_action_just_pressed("Attack") and Can_Attack:
		Can_Attack = false
		attack()
		attack_cd.start()
func _physics_process(delta: float) -> void:
	#finds out what direction the character is moving
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down",)
	
	# Dash Code. Space key is the button for this
	if Input.is_action_just_pressed("dash") and is_ready:
		is_ready = false
		$dashtimer.start()
		SPEED *= 5
		velocity = direction * SPEED
	
	#statments to handles walking direction and animimation from input
	if direction.x > 0:
		idle_direction = "Right Idel"
		animated_sprite.flip_h = false
		animated_sprite.play("Walking Right")
	elif direction.x < 0:
		idle_direction = "Left Idel"
		animated_sprite.flip_h = true
		animated_sprite.play("Walking Left")
	elif direction.y < 0:
		idle_direction = "Up Idel"
		animated_sprite.play("Walking up")
	elif direction.y > 0:
		idle_direction = "Down Idel"
		animated_sprite.play("Walking Down")
	else:
		animated_sprite.play(idle_direction)
	
	#sets velocity and moves accordinly to it 
	velocity = direction * SPEED
	move_and_slide()
	
#resets to normal speed after dash
func _on_dashtimer_timeout():
	is_ready = true
	SPEED = 100

#Sword Code
func attack():
	attacking = true
	animation.play("Attack")
	
func _on_sword_hit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
# end of sword code

#function called on timer end to turn attacking back on
func _on_attack_cd_timeout() : Can_Attack = true 
