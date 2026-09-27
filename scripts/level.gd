extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.game_started:
		position.x -= global.speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.game_started :
		return
	position.x -= global.speed
	



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#print("level deleted")
	queue_free()
