extends CanvasLayer


@onready var option_select = $Panel/MarginContainer/VBoxContainer/VBoxContainer
@onready var color_container = $colorContainer

signal exited
var option_visible = false
@onready var margin_container = $Panel/MarginContainer
@onready var v_box_container = $Panel/MarginContainer/VBoxContainer

var my_style = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	set_mode()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Globals.pause_menu:
		visible = false
	else:
		visible = true
	color_container.size = $Panel/MarginContainer.size * 1.02
	var margin_value = 100
	margin_container.add_theme_constant_override("margin_top", get_viewport().size.y/2 -  v_box_container.size.y/2)
	margin_container.add_theme_constant_override("margin_left", get_viewport().size.x/2 - v_box_container.size.x/2)
	color_container.add_theme_constant_override("margin_top", get_viewport().size.y/2 -  v_box_container.size.y/2 - v_box_container.size.y * 0.1)
	color_container.add_theme_constant_override("margin_left", get_viewport().size.x/2 - v_box_container.size.x/2 - v_box_container.size.x * 0.05)
	$Panel/MarginContainer/VBoxContainer/VBoxContainer.visible = option_visible
	


func _on_exit_pressed():
	get_tree().quit()


func _on_options_pressed():
	option_visible = !option_visible


func _on_resume_pressed():
	visible = false
	Globals.pause_menu = false
	get_tree().paused = false


func _on_return_pressed():
	get_tree().paused = false
	emit_signal("exited")
	get_tree().change_scene_to_file("res://TITLEv2.tscn")
	get_parent().queue_free()

func set_mode(mode=0):
	if mode == 0:
		$Panel/MarginContainer/VBoxContainer/stats.visible = false
		$Panel/MarginContainer/VBoxContainer/statText.visible = false
		$Panel/MarginContainer/VBoxContainer/HBoxContainer.visible = false
		$Panel/MarginContainer/VBoxContainer/title.text = "Pause"
		$Panel/MarginContainer/VBoxContainer/resume.visible = true
	if mode == 1:
		Globals.highScore = max(Globals.score, Globals.highScore)
		$Panel/MarginContainer/VBoxContainer/stats.visible = true
		$Panel/MarginContainer/VBoxContainer/HBoxContainer.visible = true
		$Panel/MarginContainer/VBoxContainer/HBoxContainer/statsScore.text = "Score: " + str(Globals.score)
		$Panel/MarginContainer/VBoxContainer/HBoxContainer/statsHigh.text = "High Score: " + str(Globals.highScore)
		$Panel/MarginContainer/VBoxContainer/title.text = "Game over!"
		$Panel/MarginContainer/VBoxContainer/resume.visible = false
		var text = "Fuel picked up: {}
		Coins picked up: {}
		Hearts picked up: {}
		Diamonds picked up: {}".format(Globals.pickups, "{}")
		$Panel/MarginContainer/VBoxContainer/statText.text = text



func _on_stats_pressed():
	$Panel/MarginContainer/VBoxContainer/statText.visible = !$Panel/MarginContainer/VBoxContainer/statText.visible
