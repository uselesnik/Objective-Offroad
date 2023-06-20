extends VehicleBody3D

@export var dash_dist = 7000
var timed_out = false
var flipping = false

var chunk_size = Globals.chunk_size
var prev_position = Vector2()
signal switched_chunks

func _ready():
	Globals.coins = 0
	Globals.health = 6
	Globals.fuel_value = 100
	Globals.pause_menu = false

func _physics_process(delta):
#	$Camera3d.rotation.x = -$".".rotation.x
	changed_chunk()
	if position.y < -100 or Globals.health <= 0:
		die()
	if Input.is_action_just_pressed("ui_cancel"):
		Globals.pause_menu = true
		get_tree().paused = true
	if (Globals.fuel_value <= 0):
		die()
	steering = lerp(steering, Input.get_axis("ui_right", "ui_left") * 0.4, 5 * delta)
	
	engine_force = Input.get_axis("ui_down", "ui_up") * 900
	var fuel_spent = abs(Input.get_axis("ui_down", "ui_up")) * delta * 0.8
	if Input.is_action_just_released("ui_accept") && !timed_out:
		fuel_spent += 6.4
		timed_out = true
		$".".apply_central_impulse(Vector3(dash_dist * Input.get_axis("ui_down", "ui_up"),0,0).rotated(Vector3(0,1,0), $".".rotation.y).rotated(Vector3(0,0,1), $".".rotation.z))
		await get_tree().create_timer(1.0).timeout
		timed_out = false
	if Input.is_action_just_released("flip") && !flipping:
		fuel_spent += 3.2
		flipping = true
		$".".rotation.x = lerp_angle($".".rotation.x, 0, 1)
		$".".rotation.z = lerp_angle($".".rotation.z, 0, 1)
		flipping = false
	Globals.fuel_value -= fuel_spent
	

func changed_chunk():
	var chunk_coords = Vector2(round(self.position.x / chunk_size / 2), round(self.position.z / chunk_size / 2))
	if (prev_position.x != chunk_coords.x) || (prev_position.y != chunk_coords.y):
		print("changed_chunk")
		emit_signal("switched_chunks", prev_position, chunk_coords)
		
	prev_position = chunk_coords

func _on_damage_detector_body_entered(body):
	Globals.health -= 1

func die():
	Globals.score = Globals.coins
	Globals.highScore = Globals.score if(Globals.score > Globals.highScore)else Globals.highScore
	Globals.pause_menu = true
	get_parent().get_node("pause").set_mode(1)




func _on_mdt_world_move_car(new_y):
	print("moved")
	$".".position.y = new_y
