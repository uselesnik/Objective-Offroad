extends Control
@onready var car_scene = preload("res://worlds/car_test.tscn")
@onready var cam_scene = preload("res://yet_another_test.tscn")

@onready var seed_input = $"seed-input"

func _on_check_button_toggled(button_pressed):
	var current_mode = seed_input.editable
	seed_input.editable = !current_mode
	if current_mode:
		seed_input.text = ""
		seed_input.placeholder_text = "seed will be chosen randomly"
	else:
		seed_input.placeholder_text = "input your seed here"


func _on_car_butt_pressed():
	if seed_input.text != "" && seed_input.text.is_valid_int(): 
		Globals.seed = seed_input.text.to_int() % 200000
	else:
		Globals.seed = randi()% 200000 - 100000
	print(Globals.seed) 
	get_tree().change_scene_to_packed(car_scene)
	


func _on_cam_butt_pressed():
	if seed_input.text != "" && seed_input.text.is_valid_int(): 
		Globals.seed = seed_input.text.to_int() % 200000
	else:
		Globals.seed = randi()% 200000 - 100000
	print(Globals.seed)
	get_tree().change_scene_to_packed(cam_scene)
