extends Control

@export var start_menu: PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") :
		get_tree().paused = true
		show()

func _on_button_pressed() -> void: #resume button
	hide()
	get_tree().paused = false
	


func _on_quit_button_pressed() -> void: #quit button
	get_tree().paused = false      
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	show()
