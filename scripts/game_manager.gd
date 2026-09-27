extends Node
@onready var game_manager: Node = $"."

@onready var og_level: Node2D = $"../og_level"

@export var level: PackedScene #import the whole level scene, used to spwan a new level
@export var arrow: PackedScene #import the whole arrow scene, used to spwan a new arrow
@export var coin: PackedScene # To do this again, drag from the file system, hold option and drop it
@export var wall: PackedScene
@export var slime: PackedScene
@export var death_menu: PackedScene


@onready var timer_arrow: Timer = %Timer_arrow
@onready var timer_coin: Timer = %Timer_coin
@onready var timer_wall: Timer = %Timer_wall
@onready var timer_slime: Timer = %Timer_slime


@onready var label: Label = $"../Label"
@onready var label_2: Label = $"../Label2"
@onready var label_3: Label = $"../Label3"
@onready var label_4: Label = $"../Label4"
@onready var label_5: Label = $"../Label5"
@onready var label_6: Label = $"../Label6"
@onready var label_7: Label = $"../Label7"
@onready var label_8: Label = $"../Label8"
@onready var label_9: Label = $"../Label9"
@onready var label_10: Label = $"../Label10"
@onready var label_11: Label = $"../Label11"
@onready var label_12: Label = $"../Label12"





var current_level : Node2D
var next_level : Node2D


var new_arrow : Node2D
var new_coin : Node2D
var new_wall : Node2D
#var new_slime : Node2D


func _input(event: InputEvent) -> void:
	#control start or restart game
	if global.is_dead and event.is_action_pressed("start_game") and not global.game_started :
		get_tree().reload_current_scene()
		global.game_started = true
		#global.is_dead = false
		#global.reset_stat()

	elif event.is_action_pressed("start_game") and not global.game_started :
		print("starrrrrrrt")
		global.game_started = true
		await get_tree().create_timer(1.0).timeout
		timer_arrow.start()
		timer_coin.start()
		timer_wall.start()
		timer_slime.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
		global.is_dead = false
		global.reset_stat()
		#timer_arrow.stop()
		#imer_coin.stop()
		#timer_wall.stop()
		#timer_slime.stop()
		print("hiiii")
		print("HP : " , global.hp)
		current_level = og_level
		current_level.position = Vector2(0,0)

	
		next_level = level.instantiate()
		next_level.position = Vector2(1080,0)
		game_manager.add_child(next_level)
		
		if global.game_started and not global.is_dead: #restart all timer
			timer_arrow.start()
			timer_coin.start()
			timer_wall.start()
			timer_slime.start()
			

func generate_and_remove_level() -> void :
	#current_level.queue_free()
	current_level = next_level
	
	next_level = level.instantiate()
	next_level.position = Vector2(current_level.position.x + 1080,0)
	#next_level.position = Vector2(1080,0)
	game_manager.add_child(next_level)
	
	#game_manager.remove_child()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	if global.is_dead:
		if global.current_score > global.highest_score:
			global.highest_score = global.current_score
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(death_menu)
		#return

		
	
	label_2.text = str(global.hp)
	label_4.text = str(global.max_hp)
	label_6.text = str(global.slime_kill_count)
	label_8.text = str(global.coin_count)
	label_10.text = str(roundf(global.current_score))
	label_12.text = str(roundf(global.highest_score))
	
	
	if global.game_started:
		global.current_score += global.score_per_frame
		if next_level.position.x <= 500:
			generate_and_remove_level()
	
	
	



func _on_timer_timeout() -> void:

	timer_arrow.wait_time = global.arrow_spawn_time
	timer_arrow.start()
	new_arrow = arrow.instantiate()
	game_manager.add_child(new_arrow)
	
	


func _on_timer_coin_timeout() -> void:
	timer_coin.wait_time = global.coin_spawn_time
	timer_coin.start()
	new_coin = coin.instantiate()
	game_manager.add_child(new_coin)
	
	
	
	
	


func _on_timer_wall_timeout() -> void:
	timer_wall.wait_time = global.wall_spawn_time
	timer_wall.start()
	new_wall = wall.instantiate()
	game_manager.add_child(new_wall)
	
	


func _on_timer_slime_timeout() -> void:
	#timer_slime.wait_time = global.slime_spawn_time
	#timer_slime.start()
	#new_slime = slime.instantiate()
	#game_manager.add_child(new_slime)
	#new_slime.position = Vector2(1100,550)
	spawn_slime()
	
	
	
var new_slime : Node2D
var new_slime2 : Node2D	
var new_slime3 : Node2D	
func spawn_slime() -> void:
	var x_offset = randi_range(-500,500)
	var y = randi_range(90,550)
	var y_offset = randi_range(-200, 200)
	
	var y1 = y + y_offset
	var y2 = y + y_offset
	
	if y1 < 90:
		y1 = 90
	
	if y2 > 550:
		y2 = 550	
		
		
	
	
	
	
	timer_slime.wait_time = global.slime_spawn_time
	timer_slime.start()
	
	if global.coin_count >= global.lv2_coin_count :
		
		new_slime = slime.instantiate()
		game_manager.add_child(new_slime)
				
		new_slime2 = slime.instantiate()
		game_manager.add_child(new_slime2)
		
		new_slime3 = slime.instantiate()
		game_manager.add_child(new_slime3)
		
		new_slime.position = Vector2(2000,y)
		new_slime2.position = Vector2(2000+x_offset, y1)	
		new_slime3.position = Vector2(2000-x_offset, y2)	
	elif global.coin_count >= global.lv1_coin_count :
		
		
		new_slime = slime.instantiate()
		game_manager.add_child(new_slime)
				
		new_slime2 = slime.instantiate()
		game_manager.add_child(new_slime2)
		
		new_slime.position = Vector2(2000,y)
		new_slime2.position = Vector2(2000 + x_offset,y1)
		

		
	else :
		new_slime = slime.instantiate()
		game_manager.add_child(new_slime)
		new_slime.position = Vector2(2000,y)
	
	
	
