extends Node2D
   

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = global.player.position
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position.x -= global.speed 
	position.y += global.speed *4


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
