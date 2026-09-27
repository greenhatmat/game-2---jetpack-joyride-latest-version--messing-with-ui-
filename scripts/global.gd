extends Node

var game_started : bool = false

var current_score = 0
var highest_score = 0

var score_per_frame = 0.5


var player : CharacterBody2D

var max_hp = 6
var hp = 6


var is_hit = false
var is_dead = false

var slime_kill_count = 0

var coin_count = 0

var lv1_coin_count = 10
var lv2_coin_count = 20
var lv3_coin_count = 30
var lv4_coin_count = 40




var speed = 3

var arrow_speed = 15

var bomb_drop_time = 2

var coin_spawn_time = 1
var arrow_spawn_time = 8
var wall_spawn_time = 4
var slime_spawn_time = 5



	

	
	
func speed_up_whole() -> void:
	print("speed up")
	
	speed = speed * 1.2
	coin_spawn_time *= 0.9
	arrow_spawn_time *= 0.9
	wall_spawn_time *= 0.9
	arrow_speed = arrow_speed * 1.1
	slime_spawn_time *= 0.9
	bomb_drop_time *= 0.9
	score_per_frame += 0.15
	"""
	speed = speed * 1.2
	coin_spawn_time -= 0.02
	arrow_spawn_time -= 0.3
	wall_spawn_time -= 0.2 
	arrow_speed = arrow_speed * 1.1
	slime_spawn_time -= 0.2
	bomb_drop_time -= 0.25
	"""

func mod_hp(amount : int) -> void:
	if hp == max_hp and amount >= 1:
		print("max hp already")
		print("HP : " , hp)
		return

	
	if amount >= 1 : #amount is positive
		if (max_hp - hp) < amount :
			hp += (max_hp - hp)
			print("+" , (max_hp - hp), " hp")
		else :
			hp += amount	
			print("+" , amount, " hp")

		
		
	else : #amount is negative
		if (hp + amount) <= 0 :
			hp += amount
			print("GGGgggggggggggggggggGGG U DIED")
			game_started = false
			is_dead = true
			#is_hit = true
			player.animated_sprite_2d.play("die")
			#await get_tree().create_timer(1.0).timeout
			#is_dead = false
			#game_started = false
		else :
			hp += amount
			print("-" , abs(amount), " hp")
			is_hit = true
			player.animated_sprite_2d.play("hit")
			await get_tree().create_timer(1.0).timeout
			is_hit = false
			
	
	print("HP : " , hp)

func reset	() -> void :
	get_tree().reload_current_scene()
	
func reset_stat() -> void:
	max_hp = 6
	hp = 6
	coin_count = 0
	slime_kill_count = 0
	speed = 3
	arrow_speed = 15
	bomb_drop_time = 2
	coin_spawn_time = 1
	arrow_spawn_time = 8
	wall_spawn_time = 4
	slime_spawn_time = 5	
	current_score = 0
		
	
func double_slime() -> void:
	pass	
	
	
	
	
