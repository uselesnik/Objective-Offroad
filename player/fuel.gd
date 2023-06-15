extends Control

var prev_value = 100.0
var health = 6
@onready var marginContainer = $MarginContainer
@onready var marginContainer2 = $MarginContainer/PanelContainer/Panel/MarginContainer
@onready var coin_text = $MarginContainer/PanelContainer/Panel/MarginContainer/HBoxContainer/coin_text



# Called when the node enters the scene tree for the first time.
func _ready():
	prev_value = Globals.fuel_value
	$TextureProgressBar.value = prev_value
	$TextureProgressBar.tint_progress = Color.from_hsv(prev_value/360.0 +0.03, 1, 0.5)
	health = Globals.health
	$health.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MarginContainer/PanelContainer.custom_minimum_size.x = $MarginContainer/PanelContainer/Panel/MarginContainer/HBoxContainer.size.x + get_viewport().size.x/75
	$MarginContainer/PanelContainer.custom_minimum_size.y = $MarginContainer/PanelContainer/Panel/MarginContainer/HBoxContainer.size.y + get_viewport().size.y/75
	
	marginContainer.add_theme_constant_override("margin_top", get_viewport().size.y/100 )
	marginContainer.add_theme_constant_override("margin_left", get_viewport().size.x/100 )
	marginContainer2.add_theme_constant_override("margin_top", get_viewport().size.y/150 )
	marginContainer2.add_theme_constant_override("margin_left", get_viewport().size.x/150 )
	coin_text.text = str(Globals.coins)
	if prev_value != Globals.fuel_value:
		prev_value = lerp(float(prev_value), float(Globals.fuel_value), delta * 2.5)
		$TextureProgressBar.value = prev_value
		$TextureProgressBar.tint_progress = Color.from_hsv(prev_value/360.0 +0.03, 1, 0.5)
	
	if health != Globals.health:
		health = Globals.health
		$health.value = health + 0.5 - 1
		

#	if Input.is_action_pressed("ui_down"):
#		Globals.fuel_value -= 1
#	if Input.is_action_pressed("ui_up"):
#		Globals.fuel_value += 1
#	if Input.is_action_just_pressed("ui_left"):
#		Globals.health += 1
#	if Input.is_action_just_pressed("ui_right"):
#		Globals.health -= 1

