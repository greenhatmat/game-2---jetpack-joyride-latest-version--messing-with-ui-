extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var is_dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y > 560 or global_position.y < 80:
		print('no spawn')
		queue_free()
	if not global.game_started :
		return
	var temp = area_2d.get_overlapping_areas()
	for i in temp:
		#print(i)
		if i.is_in_group("wall"): #plus chech if its in slime??
			queue_free()
	
	if not is_dead :
		animated_sprite_2d.play("idle")
	
	position.x -= global.speed
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is CharacterBody2D:
		collision_shape_2d.set_deferred("disabled", true)#so it wont hit the player twice
		global.mod_hp(-3)
			
		
			
			
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		print("slime died")
		collision_shape_2d.set_deferred("disabled", true)  
		global.slime_kill_count += 1
		print("skl :  ", global.slime_kill_count)
		is_dead = true
		
		if global.slime_kill_count % 3   == 0 and global.slime_kill_count > 0:
			print("slime kill count : ", global.slime_kill_count)
			
			global.max_hp += 1
		
		animated_sprite_2d.play("new_die")
		await get_tree().create_timer(1.0).timeout
		queue_free()	



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
