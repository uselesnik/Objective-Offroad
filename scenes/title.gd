extends Node2D

@onready var option_select = $MarginContainer/VBoxContainer/optionSelect
@onready var color_container = $colorContainer
var start_visible = false
var option_visible = false
var new_game = preload("res://scenes/new_world.tscn")
@onready var margin_container = $MarginContainer
@onready var v_box_container = $MarginContainer/VBoxContainer
var my_style = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	print("loadeed")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	color_container.size = $MarginContainer.size * 1.02
	var margin_value = 100
	margin_container.add_theme_constant_override("margin_top", get_viewport().size.y * 0.9 -  v_box_container.size.y)
	margin_container.add_theme_constant_override("margin_left", get_viewport().size.x/2 - v_box_container.size.x/2)
	color_container.add_theme_constant_override("margin_top", get_viewport().size.y * 0.9 -  v_box_container.size.y - v_box_container.size.y * 0.1)
	color_container.add_theme_constant_override("margin_left", get_viewport().size.x/2 - v_box_container.size.x/2 - v_box_container.size.x * 0.05)
	$MarginContainer/VBoxContainer/ColorRect.visible = start_visible
	option_select.visible = option_visible

func _on_play_pressed():
	start_visible =!start_visible
	option_visible = false

func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	option_visible = !option_visible
	start_visible = false
