extends Node2D
@onready var area_2d: Area2D = $Area2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	#print("coin spawned")
	var x = 2000
	var y = randi_range(100,510)
	
	position = Vector2(x,y)

 # Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not global.game_started :
		return

	var temp = area_2d.get_overlapping_areas()
	for i in temp:
		if i.is_in_group("wall"): #plus chech if its in slime??
			queue_free()
	animated_sprite_2d.play("default")	
		
	position.x -= global.speed  # change this to a global variable same as the speed of level


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		#print("coin + 1")
		global.coin_count += 1
		print("coin count:" , global.coin_count)
 
		#global.speed += 1 
		queue_free()
		
		if global.coin_count % 5 == 0 :
			global.mod_hp(1)
		
		if global.coin_count % 10 == 0 :
			global.speed_up_whole()

		
		




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	#print("coin deleted")
