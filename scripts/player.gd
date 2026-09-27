extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var bomb: PackedScene
@onready var player: CharacterBody2D = $"."


@onready var timer_bomb: Timer = $Timer_bomb
@onready var game_manager: Node = $"../GameManager"

@export var esc_menu: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -200.0


var new_bomb : Node2D

var menu : Control

#var global.player : CharacterBody2D

func _ready() -> void:
	#menu = esc_menu.instantiate()
	#player.add_child(menu)
	global.player = self
	



func _physics_process(delta: float) -> void:
	if not global.is_hit and not global.is_dead :
		animated_sprite_2d.play("idle")
	
	if not global.game_started and global.is_dead:
		return
	if not global.game_started:
		return
	
	# play animation
	#if not global.is_hit and not global.is_dead :
	#	animated_sprite_2d.play("idle")
	#elif global.is_hit :
#		animated_sprite_2d.play("hit")
#	else :
#		animated_sprite_2d.play("die")	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.1
	
	# Handle jump.
	
	#if Input.is_action_pressed("esc") :
	#	get_tree().change_scene_to_file("res://scenes/esc_menu.tscn")
		
		
	
	if Input.is_action_pressed("jump") and timer_bomb.is_stopped():
		velocity.y = JUMP_VELOCITY
		
		new_bomb = bomb.instantiate()
		game_manager.add_child(new_bomb)	
		timer_bomb.start()
		
	elif Input.is_action_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	

		
	move_and_slide()	





	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
#		velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
 

func _on_timer_bomb_timeout() -> void:
	timer_bomb.wait_time = global.bomb_drop_time
	timer_bomb.stop()
	
	
	
	
	
