extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

  
func _process(delta: float) -> void:
	if not global.game_started :
		return
	animated_sprite_2d.play("default")
	position.x -= global.speed  # change this to a global variable same as the speed of level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	var x = 2000
	var y = randi_range(90,560)
	var degree = randi_range(0,180)
	
	position = Vector2(x,y)
	rotation = degree

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collision_shape_2d.set_deferred("disabled", true)#so it wont hit the player twice
		global.mod_hp(-1)
		#change to player die or lose hp




	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
