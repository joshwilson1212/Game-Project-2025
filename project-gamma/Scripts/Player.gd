class_name Player extends CharacterBody2D

var SPEED = 100
var is_ready: bool = true
var Can_Attack = true
var attacking = false;
var idle_direction = "Down Idel"

#for Health Bar Progress
#please use new helth managment class logan 6-12-2025
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth
signal healthChanged

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation = $Sprites/Sword/AnimationPlayer
@onready var attack_cd: Timer = $"Sprites/Sword/sword hit/AttackCD"
@onready var timer = $dashtimer
@onready var sword: Node2D = $Sprites
@onready var swordSprite: Sprite2D = $Sprites/Sword
@onready var ray_cast_2d: RayCast2D = $Sprites/Sword/RayCast2D


@export var inv: Inv
var health = Health.new()
var pull_time = 0.0
var pull_target_destination = position
var travel_dur = 2
var speed = 300
func _ready() -> void:
	health.set_max_health(20)
	health.set_health(20)
	health.health -= 1
	print(health.get_health()) 
func _process(_delta):
	#checks if the mouse button was clicked and moves the sword
	if Input.is_action_just_pressed("Attack") and Can_Attack:
		Can_Attack = false
		attack()
		attack_cd.start()
		

func ability(direction):
		
		is_ready = false
		$dashtimer.start()
		SPEED *= 5
		velocity = direction * SPEED

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down",)
	
	sword.look_at(get_global_mouse_position())
	if sword.transform.get_rotation()*180/3.14 > 90 or sword.transform.get_rotation()*180/3.14 < -90:
		swordSprite.flip_v = true
	else:
		swordSprite.flip_v = false
			
	
	# Dash Code. Space key is the button for this
	if Input.is_action_just_pressed("dash") and is_ready:
		ability(direction)
	if Input.is_action_just_pressed("hook") and (ray_cast_2d.get_collider() != null):
		if ray_cast_2d.get_collider().get_class() == "CharacterBody2D":
			print(ray_cast_2d.get_collider())
			ray_cast_2d.get_collider().go_to(global_position)
		#ray_cast_2d.get_class().pull(global_position,20)

	#statments to handles walking direction and animimation from input
	if direction.x < 0:
		idle_direction = "Left Idel"
		animated_sprite.flip_h = false
		animated_sprite.play("Walking Right")
	elif direction.x > 0:
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

func start_dash(dur):
	timer.wait_time = dur
	timer.start()
	
func is_dashing(): return !timer.is_stopped()
	
#resets to normal speed after dash
func _on_dashtimer_timeout():
	is_ready = true
	SPEED = 100

#healthBar code
func hurtByEnemy(_area):
	currentHealth -= 10
	if currentHealth < 0:
		currentHealth = maxHealth
	
	healthChanged.emit()
#end of heathBar code

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
