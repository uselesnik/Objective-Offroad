extends Area3D


@export_enum("fuel", "coin", "heart", "diamond") var mode: int
var value = 0
var og_pos 
signal picked_up
# Called when the node enters the scene tree for the first time.
func _ready():
	match mode:
		0:
			$"Fuel".visible = true
		1:
			$"Coin".visible = true
		2:
			$"Heart".visible = true
		3:
			$"Diamond".visible = true
	og_pos = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value += delta / 1.02
	position.y = og_pos + 0.2 * sin(value)
	rotate_y(delta * 2)


func _on_body_entered(body):
	if body.is_in_group("car"):
		Globals.pickups[mode] += 1
		match mode:
			0:
				Globals.fuel_value += 90
				if Globals.fuel_value > 100:
					Globals.fuel_value = 100
				print_debug("fuel picked")
			1:
				Globals.coins += 5
				print_debug("coin picked: " + str(Globals.coins))
			2:
				Globals.health += 1
				if Globals.health > 6:
					Globals.health = 6
					Globals.coins += 1
				print_debug("health picked")
			3: 
				Globals.health += 1
				if Globals.health > 6:
					Globals.health = 6
				Globals.coins += 2
				Globals.fuel_value += 40
				if Globals.fuel_value > 100:
					Globals.fuel_value = 100
		emit_signal("picked_up")
		queue_free()



