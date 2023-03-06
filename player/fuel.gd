extends Control

var prev_value = 100.0
var health = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	prev_value = Globals.fuel_value
	$TextureProgressBar.value = prev_value
	$TextureProgressBar.tint_progress = Color.from_hsv(prev_value/360.0 +0.03, 1, 0.5)
	health = Globals.health
	$health.value = prev_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if prev_value != Globals.fuel_value:
		prev_value = Globals.fuel_value
		$TextureProgressBar.value = prev_value
		$TextureProgressBar.tint_progress = Color.from_hsv(prev_value/360.0 +0.03, 1, 0.5)
		print(prev_value)
	
	if health != Globals.health:
		health = Globals.health
		$health.value = health + 0.5
		print(health)

#	if Input.is_action_pressed("ui_down"):
#		Globals.fuel_value -= 1
#	if Input.is_action_pressed("ui_up"):
#		Globals.fuel_value += 1
#	if Input.is_action_just_pressed("ui_left"):
#		Globals.health += 1
#	if Input.is_action_just_pressed("ui_right"):
#		Globals.health -= 1
