extends Node2D
@onready var collision_polygon_2d: CollisionPolygon2D = $Area2D/CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("arrow incoming!!!")
	var x = 2000
	var y = randi_range(100,510)
	
	position = Vector2(x,y)  
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.game_started :
		return
	
	position.x -= global.arrow_speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collision_polygon_2d.set_deferred("disabled", true)#so it wont hit the player twice
		global.mod_hp(-2)
		#change to player die


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
