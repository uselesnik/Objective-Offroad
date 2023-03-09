extends Node3D
var car_scene = preload("res://worlds/car_test.tscn")
var creative = preload("res://yet_another_test.tscn")
# Called when the node enters the scene tree for the first time.


func _on_color_rect_changed_scene(value):
	if Input.is_action_just_pressed("ui_undo"):
		get_tree().change_scene_to_packed(creative)
	if value == 1:
		print("aha1")
		get_tree().change_scene_to_packed(car_scene)
	if value == 2:
		print("aha2")
		get_tree().change_scene_to_packed(creative)
